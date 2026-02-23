-- KPI Overview - Pizzeria Database

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM Orders;

-- Total Revenue
SELECT SUM(i.item_price * oi.quantity) AS total_revenue
FROM Orders o
JOIN OrderItems oi ON o.id = oi.order_id
JOIN Items i ON i.id = oi.item_id;

-- Total Items Sold
SELECT SUM(oi.quantity) AS total_items_sold
FROM Orders o
JOIN OrderItems oi ON o.id = oi.order_id;

-- Average Order Value
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT o.id AS order_id,
           SUM(i.item_price * oi.quantity) AS order_total
    FROM Orders o
    JOIN OrderItems oi ON o.id = oi.order_id
    JOIN Items i ON i.id = oi.item_id
    GROUP BY o.id
) AS order_totals;

-- Revenue by Day
SELECT DATE(o.created_at) AS date,
       SUM(i.item_price * oi.quantity) AS total_revenue
FROM Orders o
JOIN OrderItems oi ON o.id = oi.order_id
JOIN Items i ON i.id = oi.item_id
GROUP BY date
ORDER BY date;

-- Delivery vs. pickup-%
SELECT 
    delivery,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Orders), 2) AS percentage
FROM Orders
GROUP BY delivery;