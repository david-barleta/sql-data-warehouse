/*
Quality Check Script: This SQL script performs quality checks to ensure data accuracy, 
consistency, and standardization in the silver layer.
*/

-- Check data quality of silver.crm_cust_info

-- Check for duplicates and NULLs in the primary key
-- Expected results: none
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unnecessary whitespaces in cst_key field
-- Expected results: none
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

 -- Ensure data is standardized & consistent
 SELECT DISTINCT cst_marital_status
 FROM silver.crm_cust_info;

 SELECT DISTINCT cst_gndr
 FROM silver.crm_cust_info;

-- Check data quality of silver.crm_prd_info

-- Check for duplicates and NULLs in primary key
-- Expected results: none
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 or prd_id IS NULL;

-- Check for unnecessary whitespaces in prd_nm field
-- Expected results: none
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for negative values and NULLs in prd_cost field
-- Expected results: none
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Ensure data is standardized & consistent
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

-- Check for invalid date orders
-- Expected results: none
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Check data quality of silver.crm_sales_details

-- Check for invalid date orders
-- Expected results: none
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Ensure data is consistent: sales = quantity * price
SELECT DISTINCT sls_sales, sls_quantity, sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL
	OR sls_quantity IS NULL
	OR sls_price IS NULL
	OR sls_sales <= 0
	OR sls_quantity <= 0
	OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- Check data quality of silver.erp_cust_az12

-- Check for duplicates and NULLs in primary key
-- Expected results: none
SELECT cid, COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 or cid IS NULL;

-- Check for out-of-range birthdates
-- Expected results: birthdates between 1916-01-01 and today
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate < '1916-01-01' OR bdate > GETDATE();

-- Ensure data is standardized & consistent
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

-- Check data quality of silver.erp_loc_a101

-- Check for duplicates and NULLs in primary key
-- Expected results: none
SELECT cid, COUNT(*)
FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1 or cid IS NULL;

-- Ensure data is standardized & consistent
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- Check data quality of silver.erp_px_cat_g1v2

-- Check for duplicates and NULLs in primary key
-- Expected results: none
SELECT id, COUNT(*)
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 or id IS NULL;

-- Check for unnecessary whitespaces
-- Expected results: none
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
	OR subcat != TRIM(subcat)
	OR maintenance != TRIM(maintenance)

-- Ensure data is standardized & consistent
SELECT DISTINCT cat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT subcat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;