USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE first_pv
SELECT 
	website_sessions.website_session_id,
	MIN(website_pageviews.website_pageview_id) AS min_pv_id,
    COUNT(website_pageviews.website_pageview_id) AS count_pageviews
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_pageviews.created_at < '2012-08-31'
    AND website_pageviews.created_at > '2012-06-01'
    AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY 1;

SELECT * FROM first_pv; 

CREATE TEMPORARY TABLE session_landing_page_and_created_at
SELECT 
	first_pv.website_session_id,
    first_pv.min_pv_id,
    first_pv.count_pageviews,
    website_pageviews.pageview_url AS landing_page,
    website_pageviews.created_at AS session_created_at
FROM first_pv
	LEFT JOIN website_pageviews
		ON website_pageviews.website_pageview_id = first_pv.min_pv_id;

   
SELECT 
	-- yearweek(session_created_at) AS year_week,
	MIN(DATE(session_created_at)) AS week_start_date,
	-- COUNT(DISTINCT session_landing_page_and_created_at.website_session_id) AS total_sessions,
   --  COUNT(DISTINCT CASE WHEN count_pageviews = 1 THEN website_session_id ELSE NULL END) AS bounced_sessions,
    COUNT(DISTINCT CASE WHEN count_pageviews = 1 THEN website_session_id ELSE NULL END) / COUNT(DISTINCT session_landing_page_and_created_at.website_session_id) AS bounce_rate,
    COUNT(DISTINCT CASE WHEN landing_page = '/home' THEN website_session_id ELSE NULL END) AS home_sessions,
    COUNT(DISTINCT CASE WHEN landing_page = '/lander-1' THEN website_session_id ELSE NULL END) AS lander_sessions   
	
FROM session_landing_page_and_created_at
GROUP BY YEARWEEK(session_created_at);

-- DROP TABLE first_pv, session_landing_page_and_created_at;