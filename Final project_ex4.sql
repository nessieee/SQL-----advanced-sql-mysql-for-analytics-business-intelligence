USE mavenfuzzyfactory;

SELECT
	Year(website_sessions.created_at) AS year,
	quarter(website_sessions.created_at) AS quarter,
	COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS gsearch_nonbrand_CONV_rate,
	COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END)AS bsearch_nonbrand_CONV_rate,
    COUNT(DISTINCT CASE WHEN utm_source = 'brand' THEN orders.order_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN utm_source = 'brand' THEN website_sessions.website_session_id ELSE NULL END) AS brand_CONV_rate,
    COUNT(DISTINCT CASE WHEN utm_source  IS NULL AND utm_campaign IS NOT NULL THEN orders.order_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN utm_source  IS NULL AND utm_campaign IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END) AS organic_search_CONV_rate,
    COUNT(DISTINCT CASE WHEN utm_source  IS NULL AND utm_campaign IS NULL THEN orders.order_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN utm_source  IS NULL AND utm_campaign IS NULL THEN website_sessions.website_session_id ELSE NULL END)AS direct_type_in_CONV_rate
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id  = orders.website_session_id
GROUP BY 1,2
;