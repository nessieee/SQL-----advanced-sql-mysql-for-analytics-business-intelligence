USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE first_pv
SELECT 
	website_pageviews.website_session_id,
	MIN(website_pageviews.website_pageview_id) AS min_pv_id
FROM website_pageviews
	WHERE website_pageviews.created_at < '2012-06-14'
GROUP BY 1;

CREATE TEMPORARY TABLE session_landing_page
SELECT 
	first_pv.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_pv
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id = first_pv.website_session_id
	WHERE website_pageviews.pageview_url = '/home';

CREATE TEMPORARY TABLE bounced_sessions	
SELECT 
	session_landing_page.website_session_id,
    session_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS bounced_page
FROM session_landing_page
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id = session_landing_page.website_session_id
GROUP BY 1,2
HAVING 
	COUNT(website_pageviews.website_pageview_id) = 1;
    
SELECT 
	COUNT(DISTINCT session_landing_page.website_session_id) AS sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id) / COUNT(DISTINCT session_landing_page.website_session_id) AS bounce_rate
FROM session_landing_page
	LEFT JOIN bounced_sessions
		ON session_landing_page.website_session_id = bounced_sessions.website_session_id
ORDER BY session_landing_page.website_session_id ;

-- DROP TABLE first_pv, session_landing_page, bounced_sessions;
