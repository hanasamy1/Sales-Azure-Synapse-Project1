IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_create_date, ci.cst_id) AS customer_key,
    ci.cst_id        AS customer_id,
    ci.cst_key       AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname  AS last_name,
    COALESCE(NULLIF(la.cntry,''), 'n/a') AS country,
    COALESCE(NULLIF(ci.cst_marital_status,'n/a'), 'n/a') AS marital_status,
    COALESCE(NULLIF(ci.cst_gndr,'n/a'), NULLIF(ca.gen,'n/a'), 'n/a') AS gender,
    ca.bdate        AS birthdate,
    ci.cst_create_date AS create_date
FROM silver.crm_customers ci
LEFT JOIN silver.erp_customer_details ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_customer_location la
    ON ci.cst_key = la.cid;

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
    pn.prd_id      AS product_id,
    pn.prd_key     AS product_number,
    pn.prd_nm      AS product_name,
    pn.cat_id      AS category_id,
    COALESCE(NULLIF(pc.cat,''), 'n/a') AS category,
    COALESCE(NULLIF(pc.subcat,''), 'n/a') AS subcategory,
    COALESCE(NULLIF(pc.maintenance,''), 'n/a') AS maintenance,
    pn.prd_cost    AS cost,
    pn.prd_line    AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_products pn
LEFT JOIN silver.erp_product_details pc
    ON UPPER(LTRIM(RTRIM(pn.cat_id))) = UPPER(LTRIM(RTRIM(pc.id)))
WHERE pn.prd_end_dt IS NULL;

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;

SELECT 'Gold layer views have been created successfully' AS Message;
