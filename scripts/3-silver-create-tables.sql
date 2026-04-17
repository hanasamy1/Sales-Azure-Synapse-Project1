IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');

IF OBJECT_ID('silver.crm_customers', 'U') IS NOT NULL DROP TABLE silver.crm_customers;
CREATE TABLE silver.crm_customers (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE,
    dwh_create_date     DATETIME
);

IF OBJECT_ID('silver.crm_products', 'U') IS NOT NULL DROP TABLE silver.crm_products;
CREATE TABLE silver.crm_products (
    prd_id       INT,
    cat_id       NVARCHAR(50),
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
    dwh_create_date DATETIME
);

IF OBJECT_ID('silver.crm_sales', 'U') IS NOT NULL DROP TABLE silver.crm_sales;
CREATE TABLE silver.crm_sales (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
    dwh_create_date DATETIME
);

IF OBJECT_ID('silver.erp_customer_details', 'U') IS NOT NULL DROP TABLE silver.erp_customer_details;
CREATE TABLE silver.erp_customer_details (
    cid          NVARCHAR(50),
    bdate        DATE,
    gen          NVARCHAR(50),
    dwh_create_date DATETIME
);

IF OBJECT_ID('silver.erp_customer_location', 'U') IS NOT NULL DROP TABLE silver.erp_customer_location;
CREATE TABLE silver.erp_customer_location (
    cid          NVARCHAR(50),
    cntry        NVARCHAR(50),
    dwh_create_date DATETIME
);

IF OBJECT_ID('silver.erp_product_details', 'U') IS NOT NULL DROP TABLE silver.erp_product_details;
CREATE TABLE silver.erp_product_details (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50),
    dwh_create_date DATETIME
);

SELECT 'Silver Tables have been created successfully'
