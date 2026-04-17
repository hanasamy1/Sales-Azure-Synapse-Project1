TRUNCATE TABLE bronze.crm_customers;

COPY INTO bronze.crm_customers
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/CRM System/customers.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

TRUNCATE TABLE bronze.crm_products;

COPY INTO bronze.crm_products
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/CRM System/products.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

TRUNCATE TABLE bronze.crm_sales;

COPY INTO bronze.crm_sales
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/CRM System/sales_details.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

TRUNCATE TABLE bronze.erp_customer_details;

COPY INTO bronze.erp_customer_details
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/ERP System/customer_details.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

TRUNCATE TABLE bronze.erp_customer_location;

COPY INTO bronze.erp_customer_location
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/ERP System/customer_location.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

TRUNCATE TABLE bronze.erp_product_details;

COPY INTO bronze.erp_product_details
FROM 'https://salesdataset.dfs.core.windows.net/sales-dataset/ERP System/product_details.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY= 'Managed Identity')
);

SELECT 'Data has been inserted into Bronze tables successfully'
