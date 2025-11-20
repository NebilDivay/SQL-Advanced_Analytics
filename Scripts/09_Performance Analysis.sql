 WITH yearly_sales_growth AS
 (
SELECT
YEAR(f.order_date) AS order_date,
p.product_name,
SUM(f.sales_amount) as current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(f.order_date),
p.product_name)




SELECT
 order_date,
 product_name,
 current_sales,
 AVG(current_sales) OVER(PARTITION BY product_name) avg_sales,
 current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
 CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above_Avg'
	  WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below_Avg'
	  ELSE 'Avg'
 END Avg_change,
 LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date ) AS previous_year_sale,
 current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date ) AS diff_py,
 --Year-over-Year Analysis
 CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date ) > 0 THEN 'Increasing'
	  WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_date ) < 0 THEN 'Decreasing'
	  ELSE 'Same'
 END Py_Change
FROM yearly_sales_growth 
ORDER BY product_name,order_date