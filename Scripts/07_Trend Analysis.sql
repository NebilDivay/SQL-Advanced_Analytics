--Trend Analysis (Change over time)
SELECT 
YEAR(order_date) as order_year,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date) 


SELECT 
MONTH(order_date) as order_month,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)


SELECT 
YEAR(order_date) as order_year,
MONTH(order_date) as order_month,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)


SELECT 
DATETRUNC(YEAR, order_date) as order_date,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date) 
ORDER BY DATETRUNC(YEAR, order_date) 


SELECT 
FORMAT(order_date, 'yyyy-MMM') as order_date,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_qty,
COUNT(DISTINCT customer_key) as total_customer
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM') 