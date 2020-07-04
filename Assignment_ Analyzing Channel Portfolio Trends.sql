SELECT 
	-- YEARWEEK(created_at),
    MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT website_session_id) AS sessions,
	COUNT(DISTINCT CASE WHEN device_type = 'desktop' AND utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS gsearch_dsk_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' AND utm_source = 'bsearch' THEN website_session_id ELSE NULL END) AS bsearch_dsk_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' AND utm_source = 'bsearch' THEN website_session_id ELSE NULL END) /  COUNT(DISTINCT CASE WHEN device_type = 'desktop' AND utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS b_pct_of_g_dsk,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' AND utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS gsearch_mob_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' AND utm_source = 'bsearch' THEN website_session_id ELSE NULL END) AS bsearch_mob_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' AND utm_source = 'bsearch' THEN website_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN device_type = 'mobile' AND utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS b_pct_of_g_mob
FROM website_sessions
WHERE created_at >'2012-11-04' 
	AND created_at < '2012-12-22'
    AND utm_campaign = 'nonbrand'
GROUP BY
	YEARWEEK(created_at)
    ;
   