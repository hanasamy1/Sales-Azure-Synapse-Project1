TRUNCATE TABLE silver.crm_customers;

INSERT INTO silver.crm_customers (
    cst_id, cst_key, cst_firstname, cst_lastname,
    cst_marital_status, cst_gndr, cst_create_date, dwh_create_date
)
SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname),
    TRIM(cst_lastname),
    CASE
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'n/a'
    END,
    CASE
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        ELSE 'n/a'
    END,
    cst_create_date,
    GETDATE()
FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS rn
    FROM bronze.crm_customers
    WHERE cst_id IS NOT NULL
) t
WHERE rn = 1;

TRUNCATE TABLE silver.crm_products;

INSERT INTO silver.crm_products (
    prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt, dwh_create_date
)
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL(prd_cost, 0),
    CASE
        WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
        WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
        WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
        ELSE 'n/a'
    END,
    CAST(prd_start_dt AS DATE),
    CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE),
    GETDATE()
FROM bronze.crm_products;

TRUNCATE TABLE silver.crm_sales;

INSERT INTO silver.crm_sales (
    sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt,
    sls_sales, sls_quantity, sls_price, dwh_create_date
)
SELECT
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) END,
    CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) END,
    CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) END,
    CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
         THEN sls_quantity * ABS(sls_price)
         ELSE sls_sales
    END,
    sls_quantity,
    CASE WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity,0) ELSE sls_price END,
    GETDATE()
FROM bronze.crm_sales;

TRUNCATE TABLE silver.erp_customer_details;

INSERT INTO silver.erp_customer_details (cid, bdate, gen, dwh_create_date)
SELECT
    CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) ELSE cid END,
    CASE WHEN bdate > GETDATE() THEN NULL ELSE bdate END,
    CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
         WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
         ELSE 'n/a'
    END,
    GETDATE()
FROM bronze.erp_customer_details;

TRUNCATE TABLE silver.erp_customer_location;

INSERT INTO silver.erp_customer_location
SELECT
    REPLACE(cid, '-', ''),
    CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
         WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
         WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
         ELSE TRIM(cntry)
    END,
    GETDATE()
FROM bronze.erp_customer_location;

TRUNCATE TABLE silver.erp_product_details;

INSERT INTO silver.erp_product_details
SELECT
    ISNULL(id, 'Unknown'),
    ISNULL(NULLIF(cat, ''), 'n/a'),
    ISNULL(NULLIF(subcat, ''), 'n/a'),
    ISNULL(NULLIF(maintenance, ''), 'n/a'),
    GETDATE()
FROM bronze.erp_product_details;

SELECT 'Data has been inserted into silver tables successfully'
