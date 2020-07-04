USE mavenfuzzyfactory;
SELECT 
	year(created_at) AS year,
    Month(created_at) AS month,
	COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_session_id ELSE NULL END) as nonbrand,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_session_id ELSE NULL END) as brand,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_session_id ELSE NULL END) AS brand_pct_of_nonbrand,
    COUNT(DISTINCT CASE WHEN http_referer IS NULL THEN website_session_id ELSE NULL END) AS direct,
    COUNT(DISTINCT CASE WHEN http_referer IS NULL THEN website_session_id ELSE NULL END)/ COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_session_id ELSE NULL END) AS direct_pct_of_nonbrand,
    COUNT(DISTINCT CASE WHEN utm_campaign IS NULL and utm_source IS NULL and http_referer IS NOT NULL THEN website_session_id ELSE NULL END) AS organic,
    COUNT(DISTINCT CASE WHEN utm_campaign IS NULL and utm_source IS NULL and http_referer IS NOT NULL THEN website_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_session_id ELSE NULL END) AS organic_pct_of_nonbrand
FROM website_sessions
WHERE created_at < '2012-12-23'
GROUP BY 
	year(created_at),
    Month(created_at)
;