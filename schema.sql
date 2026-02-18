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

-- Ingredients table
CREATE TABLE Ingredients (
    id INTEGER PRIMARY KEY,
    name TEXT,
    weight REAL,
    measure TEXT,
    price REAL
);

-- Recipes table (many-to-many between Items and Ingredients)
CREATE TABLE Recipes (
    id INTEGER PRIMARY KEY,
    item_id INTEGER,
    ing_id INTEGER,
    quantity REAL,
    FOREIGN KEY (item_id) REFERENCES Items(id),
    FOREIGN KEY (ing_id) REFERENCES Ingredients(id)
);

-- Inventory table
CREATE TABLE Inventory (
    id INTEGER PRIMARY KEY,
    item_id INTEGER,
    quantity REAL,
    FOREIGN KEY (item_id) REFERENCES Items(id)
);

-- Staff table
CREATE TABLE Staff (
    id TEXT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    position TEXT,
    hourly_rate REAL
);

-- Shifts table
CREATE TABLE Shifts (
    id TEXT PRIMARY KEY,
    day_of_week TEXT,
    start_time TEXT,  -- DATETIME as TEXT
    end_time TEXT     -- DATETIME as TEXT
);

-- Rota table
CREATE TABLE Rota (
    id INTEGER PRIMARY KEY,
    rota_id TEXT,
    date TEXT,          -- DATETIME as TEXT
    shift_id TEXT,
    staff_id TEXT,
    FOREIGN KEY (shift_id) REFERENCES Shifts(id),
    FOREIGN KEY (staff_id) REFERENCES Staff(id)
);