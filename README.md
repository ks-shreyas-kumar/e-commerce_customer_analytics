# Brazilian E-Commerce Analytics

## Project Overview
End-to-end analytics pipeline analyzing 100K+ customer transactions from Brazilian e-commerce data. Extracting insights on customer behavior, revenue trends, and product performance using SQL, Python, and Power BI.

## Current Progress
- **Data Acquisition**: Downloaded and extracted 9 datasets from Kaggle
- **SQL Analysis**: Executed 4 key business queries and built cleaning pipeline
- **Python EDA**: Completed sales trends, customer behavior, and value drivers analysis
- **Customer Segmentation**: RFM analysis in progress
- **Visualization**: Power BI dashboard planning

## Key Insights (So Far)
1. **Revenue Geography**: São Paulo (SP) generates 52% of total revenue
2. **Top Category**: Health & Beauty leads with 1.25M BRL revenue  
3. **Customer Behavior**: 65% of customers make only one purchase
4. **Seasonality**: Clear revenue peaks in November (Black Friday)

## Technical Stack
- **SQL** (SQLite/PostgreSQL) for data querying and joins
- **Python** (Pandas, NumPy) for analysis and cleaning
- **Power BI** for interactive dashboards
- **Git/GitHub** for version control and portfolio

## Analysis Completed 

### 1. Data Pipeline & SQL Transformation
- Implemented SQL-based ETL pipeline cleaning 100k+ transactional records
- Created analysis-ready datasets: `cleaned_customers`, `cleaned_orders`, `sales_fact`
- Executed 4 key business SQL queries for revenue, trends, segmentation, and product analysis

### 2. Exploratory Data Analysis (Python)
- **Sales Trends**: Identified seasonal patterns with Black Friday peaks (Nov-Dec)
- **Customer Behavior**: 65% one-time buyers, highlighting retention opportunity
- **Value Drivers**: Medium price segment (50-150 BRL) drives 45% of revenue
- **Geographic Insights**: São Paulo generates 52% of total revenue

### 3. Key Business Insights
- **Retention Opportunity**: Majority of customers are one-time purchasers
- **Revenue Concentration**: Top 3 states account for 75% of total revenue
- **Product Strategy**: Health & Beauty category leads revenue; Watches & Gifts has highest average price
- **Seasonal Planning**: Clear Q4 peaks require inventory and marketing preparation

## Project Structure

## Code Organization
- **SQL Queries**: See [`sql/key_queries.sql`](sql/key_queries.sql) for all business logic
- **Analysis Notebooks**: Step-by-step exploration in Jupyter
- **Scripts**: Reusable Python utilities


## Next Steps
- Complete RFM customer segmentation
- Build interactive Power BI dashboard
- Add predictive analytics for customer churn

---
*Project started: December 2025 | Last updated: [27th January 2026]*