# Sales Data Warehouse - Azure Synapse Analytics

## Project Overview
This project demonstrates the design and implementation of a modern data warehouse using Azure Synapse Analytics, following the Medallion Architecture (Bronze, Silver, Gold).

## Tools & Technologies
- Azure Synapse Analytics
- Azure Data Lake Storage Gen2
- Power BI
- SQL

## Data Architecture
The project follows the Medallion Architecture:
- **Bronze Layer** - Raw data ingested from CSV files (CRM & ERP systems)
- **Silver Layer** - Cleaned and transformed data
- **Gold Layer** - Business-ready Star Schema (Fact & Dimension tables)

## Data Sources
- CRM System: customers, products, sales details
- ERP System: customer details, customer location, product details

## Scripts
| Script | Description |
|--------|-------------|
| 1-bronze-create-tables.sql | Creates raw tables in Bronze layer |
| 2-bronze-load-data.sql | Loads CSV data into Bronze tables |
| 3-silver-create-tables.sql | Creates cleaned tables in Silver layer |
| 4-silver-load-data.sql | Transforms and loads data into Silver layer |
| 5-gold-create-views.sql | Creates Star Schema views in Gold layer |

## Power BI Dashboard
The dashboard includes:
- Sales by Month
- Top 10 Products
- Sales by Country
- Sales by Category
