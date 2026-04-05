/*
Quality Check Script: This SQL script performs quality checks to ensure data accuracy, 
consistency, and integrity in the gold layer.
*/

-- Check data quality of gold.dim_customers

-- Check for duplicates in the primary key
-- Expected results: none
SELECT customer_key, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check data quality of gold.dim_products

-- Check for duplicates in the primary key
-- Expected results: none
SELECT product_key, COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check data quality of gold.fact_sales

-- Check the referential integrity with the dimension tables
-- Expected results: none
SELECT *
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
ON s.customer_key = c.customer_key
LEFT JOIN gold.dim_products AS p
ON s.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;