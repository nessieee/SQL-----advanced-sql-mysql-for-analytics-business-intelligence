USE mavenfuzzyfactory;

SELECT
	YEAR(website_sessions.created_at) as yr,
    MONTH(website_sessions.created_at) as mo,
    -- WEEK(website_sessions.created_at) as week,
	-- MIN(date(website_sessions.created_at)) as week_start_date,
    COUNT(DISTINCT website_sessions.website_session_id) as sessions,
    COUNT(DISTINCT orders.order_id) as orders
FROM website_sessions
LEFT JOIN orders
	ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2013-01-01'
GROUP BY 1,2
;
    