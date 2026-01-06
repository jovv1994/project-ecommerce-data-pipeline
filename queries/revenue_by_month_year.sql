-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
WITH payments_unique AS (
    SELECT
        order_id,
        MIN(payment_value) AS payment_value
    FROM olist_order_payments
    GROUP BY order_id
)
SELECT
	STRFTIME('%m', oo.order_delivered_customer_date) AS month_no,
    CASE STRFTIME('%m', oo.order_delivered_customer_date)
        WHEN '01' THEN 'Jan'
        WHEN '02' THEN 'Feb'
        WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Apr'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul'
        WHEN '08' THEN 'Aug'
        WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct'
        WHEN '11' THEN 'Nov'
        WHEN '12' THEN 'Dec'
    END AS month,
    SUM(CASE STRFTIME('%Y', oo.order_delivered_customer_date) WHEN '2016' THEN pu.payment_value ELSE 0 END) AS Year2016,
    SUM(CASE STRFTIME('%Y', oo.order_delivered_customer_date) WHEN '2017' THEN pu.payment_value ELSE 0 END) AS Year2017,
    SUM(CASE STRFTIME('%Y', oo.order_delivered_customer_date) WHEN '2018' THEN pu.payment_value ELSE 0 END) AS Year2018
FROM olist_orders oo
INNER JOIN payments_unique pu
ON pu.order_id = oo.order_id
WHERE oo.order_status = 'delivered'
AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY month_no
ORDER BY month_no;