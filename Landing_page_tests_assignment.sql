USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE first_pv
SELECT 
	website_pageviews.website_session_id,
	MIN(website_pageviews.website_pageview_id) AS min_pv_id
FROM website_pageviews
	INNER JOIN website_sessions
		ON website_sessions.website_session_id = website_pageviews.website_session_id
	WHERE website_pageviews.created_at < '2012-07-28'
    AND website_pageviews.website_pageview_id > 23504
    AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1;

SELECT * FROM first_pv;

CREATE TEMPORARY TABLE session_landing_page
SELECT 
	first_pv.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_pv
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id = first_pv.website_session_id
	WHERE website_pageviews.pageview_url IN ('/home', '/lander-1');


CREATE TEMPORARY TABLE bounced_sessions	
SELECT 
	session_landing_page.website_session_id,
    session_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM session_landing_page
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id = session_landing_page.website_session_id
GROUP BY 1,2
HAVING 
	COUNT(website_pageviews.website_pageview_id) = 1;
    
SELECT * FROM bounced_sessions;

SELECT 
	session_landing_page.landing_page AS landing_page,
    COUNT(DISTINCT session_landing_page.website_session_id) AS all_sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id) AS bounced_sessions,
     COUNT(DISTINCT bounced_sessions.website_session_id) / COUNT(DISTINCT session_landing_page.website_session_id)  AS bounce_rate
FROM session_landing_page
	LEFT JOIN bounced_sessions
		ON bounced_sessions.website_session_id = session_landing_page.website_session_id
	GROUP BY session_landing_page.landing_page
ORDER BY session_landing_page.website_session_id;

-- DROP TABLE first_pv, session_landing_page, bounced_sessions;
