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

-- Orders table
CREATE TABLE Orders (
    id INTEGER PRIMARY KEY,
    created_at TEXT,  -- DATETIME as TEXT in SQLite3
    delivery TEXT,
    customer_id INTEGER,
    address_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (address_id) REFERENCES Address(id)
);

-- Items table
CREATE TABLE Items (
    id INTEGER PRIMARY KEY,
    sku TEXT,
    item_name TEXT,
    item_category TEXT,
    item_size TEXT,
    item_price REAL
);

-- OrderItems table
CREATE TABLE OrderItems (
    id INTEGER PRIMARY KEY,
    item_id INTEGER,
    order_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (item_id) REFERENCES Items(id),
    FOREIGN KEY (order_id) REFERENCES Orders(id)
);
