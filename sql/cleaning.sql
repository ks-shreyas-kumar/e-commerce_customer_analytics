-- ============================================
-- DATA CLEANING PIPELINE
-- Transforms raw data into analysis-ready tables
-- ============================================

-- 1. CLEANED CUSTOMERS TABLE
DROP TABLE IF EXISTS cleaned_customers;
CREATE TABLE cleaned_customers AS
SELECT 
    customer_id,
    TRIM(LOWER(customer_city)) as customer_city,
    UPPER(customer_state) as customer_state,
    -- Handle missing zip codes
    COALESCE(CAST(customer_zip_code_prefix AS TEXT), 'UNKNOWN') as zip_code
FROM customers
WHERE customer_id IS NOT NULL;

-- 2. CLEANED ORDERS TABLE  
DROP TABLE IF EXISTS cleaned_orders;
CREATE TABLE cleaned_orders AS
SELECT 
    order_id,
    customer_id,
    -- Extract date parts for easier analysis
    DATE(order_purchase_timestamp) as order_date,
    strftime('%Y', order_purchase_timestamp) as order_year,
    strftime('%m', order_purchase_timestamp) as order_month,
    -- Standardize status categories
    CASE 
        WHEN order_status IN ('delivered', 'shipped') THEN 'completed'
        WHEN order_status IN ('canceled', 'unavailable') THEN 'cancelled'
        ELSE 'other'
    END as order_status
FROM orders
WHERE order_purchase_timestamp IS NOT NULL;

-- 3. SALES FACT TABLE (primary analysis table)
DROP TABLE IF EXISTS sales_fact;
CREATE TABLE sales_fact AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    oi.product_id,
    oi.price,
    oi.freight_value,
    -- Derived metrics
    (oi.price + oi.freight_value) as item_total,
    SUM(oi.price + oi.freight_value) OVER(PARTITION BY o.order_id) as order_total
FROM cleaned_orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'completed';

-- 4. VERIFICATION QUERY
SELECT 'cleaned_customers' as table_name, COUNT(*) as row_count FROM cleaned_customers
UNION ALL
SELECT 'cleaned_orders', COUNT(*) FROM cleaned_orders  
UNION ALL
SELECT 'sales_fact', COUNT(*) FROM sales_fact;