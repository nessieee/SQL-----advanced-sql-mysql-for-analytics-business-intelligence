USE mavenfuzzyfactory;

SELECT 
	created_at,
	pageview_url
FROM website_pageviews
WHERE pageview_url = '/billing-2'
ORDER BY
	created_at ASC
LIMIT 1;

SELECT 
	website_pageviews.website_session_id,
	website_pageviews.pageview_url AS billing_version_seen,
        orders.order_id
FROM website_pageviews
LEFT JOIN orders
	ON orders.website_session_id = website_pageviews.website_session_id
WHERE website_pageviews.website_pageview_id >= 53550
	AND website_pageviews.created_at < '2012-11-10'
    AND website_pageviews.pageview_url IN ('/billing', '/billing-2')
;

SELECT
	billing_version_seen,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT order_id) AS orders,
	COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS billing_to_order_rt
FROM(
SELECT 
	website_pageviews.website_session_id,
	website_pageviews.pageview_url AS billing_version_seen,
	orders.order_id
FROM website_pageviews
LEFT JOIN orders
	ON orders.website_session_id = website_pageviews.website_session_id
WHERE website_pageviews.website_pageview_id >= 53550
	AND website_pageviews.created_at < '2012-11-10'
    AND website_pageviews.pageview_url IN ('/billing', '/billing-2')
) AS billing_to_order
GROUP BY
1;
    