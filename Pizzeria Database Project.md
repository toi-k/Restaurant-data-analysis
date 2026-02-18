# Pizzeria Database Project

This project demonstrates the design of a relational database for a new pizzeria. The goal is to store business information in a way that is **updatable, scalable, and easy to analyze** using SQL.

---

## Goal

Design a database that is:

- **Updatable** — easily change data without errors  
- **Scalable** — easy to add new products or remove customer info  
- **Easy to analyze** — data is atomic, so computing is efficient and SQL queries are straightforward  

The ultimate aim is to monitor business performance, e.g.:

- Revenue per year  
- Deciding to which city open a new restaurant based on data  

---

## NOTE: If you are interested only in the analytics side of this project, please skip ahead to step X.

## Step 1: Identify Entities

The first step is to determine what entities the business needs to track:

- **Staff** — track which employees are working and when  
- **Orders** — record the orders placed by customers  
- **Stock control** — manage ingredients inventory  

---

## Step 2: Create Initial Orders Table

Initially, a single large table for Orders was created, containing attributes such as:

order_id, item_name, delivery_address, customer_name, created_at, etc.


*(Insert photo of columns here if needed)*

---

## Step 3: Normalize the Data

Relational database design principles suggest that data should be **atomic** — stored in one place only.  

**Benefits:**

- Reduces redundancy  
- Improves maintainability  
- Simplifies analytics and calculations  

---

### Step 3.1: Create Customers Table

- Extract customer information from Orders into a separate **Customers** table with a unique `customer_id`.  
- Replace the customer info in Orders with a reference to `customer_id`.  

**Result:**  
Less redundancy, easier maintenance, clean customer data.

---

### Step 3.2: Repeat for Addresses and Items

- Create separate tables for **Addresses** and **Items**.  
- Move relevant columns from Orders to these new tables, and replace them with foreign keys in Orders.

---

### Step 3.3: Split Orders into Orders and OrderItems

- Further normalize Orders by creating **OrderItems**, because Orders can have many items, and items can belong to many orders 
- **Orders** now stores only order-level information (date, delivery, customer, address).  
- **OrderItems** stores which items are in each order and their quantity.

**Result:**  

- Each order is one row in Orders  
- Items per order are listed in OrderItems  
- Redundant columns like `created_at` and `delivery` are no longer repeated  

---

### Step 3.4 For stock control, following similar steps as in 3.1 - 3.3; created recipes, ingredients and inventory tables, which track which ingredients each product includes, those ingredients, and lastly how much of those ingredients are in stock:

(photo here)

### Step 3.5 Staff data: which staff members are working and when, and how much are the unit cost for each pizza (staff salary + delivery + ingredients); created tables for staff, shifts and rota (a junction table between staff and shifts).

## Summary

This structure ensures the database is:

- **Relational and normalized**  
- **Scalable** — easy to add new customers, items, or orders  
- **Ready for analysis** — queries can easily calculate revenue, order counts, etc.  
- **Accurately models real-world business logic** — one order can contain multiple items, and one item can appear in multiple orders

The result looks now like this:

## Step 4: Create the database on sqlite3, (see the full schema on the sql-load directory)
'''
-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- Customers table
CREATE TABLE Customers (
    id INTEGER PRIMARY KEY,
    firstname TEXT,
    lastname TEXT
);

-- Address table
CREATE TABLE Address (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    delivery_address1 TEXT,
    delivery_address2 TEXT,
    delivery_city TEXT,
    delivery_zipcode TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

'''

## Step 5: Add data into the new table from Excel; turn excel-file into csv and run in command line







