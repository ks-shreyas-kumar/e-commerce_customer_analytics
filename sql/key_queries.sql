-- BRAZILIAN E-COMMERCE ANALYSIS QUERIES

-- QUERY 1: Top States by Revenue
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(oi.price) as total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 5;

-- QUERY 2: Monthly Revenue Trends
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) as month,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(oi.price) as total_revenue,
    AVG(oi.price) as avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY month
ORDER BY month;

-- QUERY 3: Customer Segmentation by Order Frequency
WITH customer_order_counts AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) as order_count
    FROM orders
    GROUP BY customer_id
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count = 2 THEN 'Repeat (2)'
        WHEN order_count BETWEEN 3 AND 5 THEN 'Repeat (3-5)'
        ELSE 'Loyal (6+)'
    END as customer_segment,
    COUNT(*) as customer_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) as percentage
FROM customer_order_counts
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- QUERY 4: Top Product Categories by Revenue
SELECT 
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) as order_count,
    SUM(oi.price) as total_revenue,
    ROUND(AVG(oi.price), 2) as avg_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;