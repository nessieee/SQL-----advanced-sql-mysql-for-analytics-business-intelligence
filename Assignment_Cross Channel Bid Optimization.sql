SELECT 
	device_type,
    utm_source,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
	COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate
FROM website_sessions
LEFT JOIN orders
	ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at > '2012-08-22'
	AND website_sessions.created_at < '2012-09-18'
    AND utm_campaign = 'nonbrand'
GROUP BY
	device_type,
    utm_source
ORDER BY
	COUNT(DISTINCT website_sessions.website_session_id) DESC
	;