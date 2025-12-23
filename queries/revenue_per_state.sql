-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 
SELECT
	oc.customer_state,
	SUM(oop.payment_value) AS Revenue
FROM olist_customers oc
INNER JOIN olist_orders oo 
ON oc.customer_id = oo.customer_id
INNER JOIN olist_order_payments oop
ON oop.order_id = oo.order_id 
WHERE oo.order_status = 'delivered'
AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY oc.customer_state
ORDER BY Revenue DESC
LIMIT 10;