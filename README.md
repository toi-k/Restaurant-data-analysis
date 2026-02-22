# Pizzeria Database Project

This project demonstrates the design of a normalized relational database for a pizzeria and the development of business-focused SQL analysis.

The goal is to structure operational order data in a way that is:

- **Updatable**
- **Scalable**
- **Easy to analyze**

The current analysis focuses on KPI monitoring and product-level revenue insights.


---

## Original dataset
Included is a sample of the original data:

<img width="665" height="74" alt="sample-data" src="https://github.com/user-attachments/assets/44226e64-f247-473b-bdc6-a0531cebd751" />

## Database Design

The database follows normalization principles to ensure:

- Reduced redundancy
- Atomic data storage
- Clean relationships between entities
- Efficient analytical querying

### Core Tables Used in Analysis

The analysis is built on the following normalized tables:

- **Customers** – customer-level information  
- **Address** – delivery address details  
- **Orders** – order-level data (date, delivery type, customer reference)  
- **OrderItems** – line items within each order (product + quantity)  
- **Items** – product details, including pricing and category  

---

### Data Model Logic

The original dataset existed in a single flat spreadsheet. To improve data integrity and analytical flexibility, the data was normalized into separate dimension and junction tables.

This approach ensures:

- Reduced redundancy  
- Easier updates and maintenance  
- Storage efficiency  
- Cleaner and more scalable analytics  

For example:

- An **order can contain multiple items**
- A **product can appear in multiple orders**

This many-to-many relationship is resolved through the `OrderItems` junction table, following relational database design principles.

#### Data Relationships

- Each order is stored once in `Orders`
- Each product within an order is stored in `OrderItems`
- Product attributes and pricing are stored in `Items`
- Revenue is calculated dynamically using:  
  `item_price × quantity`

This structure enables scalable KPI calculations and product-level revenue analysis without duplicating data.

## Data Loading

Data was prepared in Excel, exported to CSV, and imported into SQLite.

Example:

```bash
sqlite3 pizzeria.db < customers.csv
sqlite3 pizzeria.db < address.csv
sqlite3 pizzeria.db < items.csv
sqlite3 pizzeria.db < orders.csv
sqlite3 pizzeria.db < orderitems.csv

See the full schema and data load in the sql_load directory.

## Analysis

I created an analysis to the data that is two-fold:

1. Kpi-overview, which answers the question, "How is our business doing at the moment?"
2. Product analysis, which answers the question, "Which products create the most revenue?"

## Kpi-overview

This analysis was focused on the core metrics of the business. It is to give the management of the business an overview of e.g. orders, total revenue and what kind of orders customers make on average.

'''
-- Total Orders
SELECT COUNT(*) AS total_orders
FROM Orders;

-- Total Revenue
SELECT SUM(i.item_price * oi.quantity) AS total_revenue
FROM Orders o
JOIN OrderItems oi ON o.id = oi.order_id
JOIN Items i ON i.id = oi.item_id;


'''
Key insights from the KPI analysis include:

1. The business had a total of 15 orders over the week, generating approximately $258 in revenue.

2. The average order value was about $17.70.

3. A total of 42 items were sold during the week.

4. About two-thirds of the orders were delivered, so delivery dominated the order types.

5. Most revenue was generated towards the end of the week (Thursday, Friday, and Saturday).

<img width="268" height="125" alt="revenue-analysis-daily" src="https://github.com/user-attachments/assets/b692a04e-d8bd-4769-9304-f7eca6d3f998" />
Chart created with ChatGPT

## Product analysis

'''
-- Contribution of each product category to total revenue

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

'''


<img width="365" height="74" alt="revenue-by-category" src="https://github.com/user-attachments/assets/c526984f-4828-4d3a-b64f-645414141fb2" />

