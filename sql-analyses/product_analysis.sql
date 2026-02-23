-- Revenue by product 

SELECT 
    I.item_name, 
    I.item_size, 
    SUM(Oi.quantity * I.item_price) AS product_revenue
FROM Orders O
JOIN OrderItems Oi ON O.id = Oi.order_id
JOIN Items I ON Oi.item_id = I.id
GROUP BY I.item_name, I.item_size
ORDER BY product_revenue DESC;

-- Contribution of each product category to revenue

SELECT 
    I.item_category,
    ROUND(
        100.0 * SUM(Oi.quantity * I.item_price) /
        (
            SELECT SUM(Oi2.quantity * I2.item_price)
            FROM OrderItems Oi2
            JOIN Items I2 ON Oi2.item_id = I2.id
        ),
        2
    ) AS revenue_percentage
FROM Orders O
JOIN OrderItems Oi ON O.id = Oi.order_id
JOIN Items I ON Oi.item_id = I.id
GROUP BY I.item_category
ORDER BY revenue_percentage DESC;