-- TODO: This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. The first column 
-- will be Category, that will contain the top 10 least revenue categories; the 
-- second one will be Num_order, with the total amount of orders of each 
-- category; and the last one will be Revenue, with the total revenue of each 
-- catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.
SELECT 
	pcnt.product_category_name_english AS Category,
	COUNT(DISTINCT oo.order_id) AS Num_order,
	SUM(oop.payment_value) AS Revenue
FROM olist_products op
INNER JOIN product_category_name_translation pcnt
ON op.product_category_name  = pcnt.product_category_name
INNER JOIN olist_order_items ooi 
ON ooi.product_id = op.product_id
INNER JOIN olist_orders oo 
ON oo.order_id = ooi.order_id
INNER JOIN olist_order_payments oop 
ON oop.order_id = oo.order_id
WHERE pcnt.product_category_name_english IS NOT NULL
AND oo.order_status = "delivered"
AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY Category 
ORDER BY Revenue
LIMIT 10;