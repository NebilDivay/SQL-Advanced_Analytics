--Which categories contribute the most to overall sales
WITH category_sales AS
(
SELECT
p.category,
SUM(f.sales_amount) total_sales
FROM gold.fact_sales f 
LEFT JOIN
gold.dim_products p
ON F.product_key = P.product_key
GROUP BY category
)

SELECT 
category,
total_sales,
SUM(total_sales) OVER(),
CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER())* 100,2), '%') AS Sales_contribution
FROM
category_sales
ORDER BY total_sales DESC