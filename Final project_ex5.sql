USE mavenfuzzyfactory;

SELECT
	YEAR(order_items.created_at) AS yr,
    MONTH(order_items.created_at) AS mo,
	SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) AS mrfuzzy_revenue,
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE NULL END) AS mrfuzzy_margin,
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) AS lovebear_revenue,
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE NULL END) AS lovebear_margin,
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) AS birthdaybear_revenue,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE NULL END) AS birthdaybear_margin,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS minibear_revenue,
    SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE NULL END) AS minibear_margin
	FROM order_items
GROUP BY 1,2
ORDER BY 1,2;


