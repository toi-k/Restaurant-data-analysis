# Pizzeria Database Project

This project demonstrates the design of a normalized relational database for a pizzeria and the development of business-focused SQL analysis.

The goal is to structure operational order data in a way that is:

- **Updatable**
- **Scalable**
- **Easy to analyze**

The current analysis focuses on KPI monitoring and product-level revenue insights.


---

## Original dataset
<img width="665" height="74" alt="sample-data" src="https://github.com/user-attachments/assets/44226e64-f247-473b-bdc6-a0531cebd751" />

## Database Design

The database follows normalization principles to ensure:

- Reduced redundancy
- Atomic data storage
- Clean relationships between entities
- Efficient analytical querying

### Core Tables Used in Analysis

- **Customers**
- **Address**
- **Orders**
- **OrderItems**
- **Items**

### Data Model Logic

- Each order is stored once in `Orders`
- Each product within an order is stored in `OrderItems`
- Product details and pricing are stored in `Items`
- Revenue is calculated dynamically using `item_price × quantity`

This structure enables scalable KPI and revenue analysis without data duplication.

---

## Data Loading

Data was prepared in Excel, exported to CSV, and imported into SQLite.

Example:

```bash
sqlite3 pizzeria.db < customers.csv
sqlite3 pizzeria.db < address.csv
sqlite3 pizzeria.db < items.csv
sqlite3 pizzeria.db < orders.csv
sqlite3 pizzeria.db < orderitems.csv
