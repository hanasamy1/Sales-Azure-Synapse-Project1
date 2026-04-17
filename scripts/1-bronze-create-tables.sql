IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
   EXEC('CREATE SCHEMA bronze')

IF OBJECT_ID('bronze.crm_customers', 'U') IS NOT NULL DROP TABLE bronze.crm_customers;
CREATE TABLE bronze.crm_customers (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);

IF OBJECT_ID('bronze.crm_products', 'U') IS NOT NULL DROP TABLE bronze.crm_products;
CREATE TABLE bronze.crm_products (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

IF OBJECT_ID('bronze.crm_sales', 'U') IS NOT NULL DROP TABLE bronze.crm_sales;
CREATE TABLE bronze.crm_sales (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

IF OBJECT_ID('bronze.erp_customer_location', 'U') IS NOT NULL DROP TABLE bronze.erp_customer_location;
CREATE TABLE bronze.erp_customer_location (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_customer_details', 'U') IS NOT NULL DROP TABLE bronze.erp_customer_details;
CREATE TABLE bronze.erp_customer_details (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_product_details', 'U') IS NOT NULL DROP TABLE bronze.erp_product_details;
CREATE TABLE bronze.erp_product_details (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

SELECT 'Bronze Tables have been created successfully'
