-- Running Sales
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY DATETRUNC(year, order_date) ORDER BY order_date) AS running_sales
FROM
(
SELECT 
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date) 
 ) t

--Moving Average
SELECT
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY DATETRUNC(year, order_date) ORDER BY order_date) AS running_sales,
AVG(avg_price) OVER (PARTITION BY DATETRUNC(year, order_date) ORDER BY order_date) AS MOVING_AVG
FROM
(
SELECT 
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) as total_sales,
AVG(price) as avg_price,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date) 
 ) t

