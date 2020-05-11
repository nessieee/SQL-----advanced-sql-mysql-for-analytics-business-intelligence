USE mavenfuzzyfactory;

SELECT 
	-- YEAR(website_sessions.created_at),
    -- MONTH(website_sessions.created_at),
    MIN(DATE(website_sessions.created_at)) AS month_start,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate
FROM website_sessions
LEFT JOIN orders
	ON website_sessions.website_session_id = orders.website_session_id
WHERE
website_sessions.utm_source = 'gsearch'
	AND website_sessions.created_at < '2012-11-27'
GROUP BY 
	YEAR(website_sessions.created_at),
   	MONTH(website_sessions.created_at)
	
;
