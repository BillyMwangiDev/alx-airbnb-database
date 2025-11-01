# Complex SQL Queries with Joins

## 📖 Overview

This directory contains advanced SQL queries demonstrating different types of JOIN operations for the AirBnB Clone database. These queries are essential for retrieving related data across multiple tables efficiently.

---

## 🎯 Objectives

Master SQL joins by writing complex queries using different types of joins:

1. **INNER JOIN** - Retrieve matching records from both tables
2. **LEFT JOIN** - Retrieve all records from the left table with matching records from the right table
3. **FULL OUTER JOIN** - Retrieve all records from both tables, with or without matches

---

## 📂 Files

- **`joins_queries.sql`** - SQL script containing all join queries
- **`README.md`** - This documentation file

---

## 🔍 Query Descriptions

### Query 1: INNER JOIN

**Objective:** Retrieve all bookings and the respective users who made those bookings.

**Description:** 
An INNER JOIN returns only the rows that have matching values in both tables. This query shows:
- All bookings that have an associated user
- User information for each booking
- Only includes users who have made bookings

**Use Case:** 
Perfect for finding active users who have made bookings, excluding users who haven't booked anything yet.

**SQL Syntax:**
```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;
```

**Expected Results:**
- Returns only bookings that have a matching user_id
- Returns only users who have made bookings
- Excludes bookings with invalid user_ids
- Excludes users with no bookings

---

### Query 2: LEFT JOIN

**Objective:** Retrieve all properties and their reviews, including properties that have no reviews.

**Description:**
A LEFT JOIN returns all rows from the left table (Property) and matching rows from the right table (Review). If there is no match, NULL values are returned for Review columns.

**Use Case:**
Essential for property listings where you want to show all properties, regardless of whether they have reviews yet. Useful for new listings or properties that haven't received feedback.

**SQL Syntax:**
```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.created_at DESC;
```

**Expected Results:**
- Returns ALL properties (even those with no reviews)
- Review columns will be NULL for properties without reviews
- Properties with multiple reviews will appear multiple times
- Useful for identifying properties that need more reviews

**Aggregated Version:**
The file also includes an aggregated version that counts reviews per property:
```sql
SELECT 
    p.property_id,
    p.name,
    COUNT(r.review_id) AS total_reviews,
    COALESCE(AVG(r.rating), 0) AS average_rating
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name;
```

---

### Query 3: FULL OUTER JOIN

**Objective:** Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

**Description:**
A FULL OUTER JOIN returns all rows from both tables, matching them where possible. If there is no match, NULL values are returned for the missing side.

**Important Note:** 
- **PostgreSQL** supports FULL OUTER JOIN natively
- **MySQL** does NOT support FULL OUTER JOIN natively
- For MySQL compatibility, use a UNION of LEFT JOIN and RIGHT JOIN (provided in the file)

**Use Case:**
- Find all users (including those who never booked)
- Find all bookings (including orphaned bookings)
- Data validation to identify orphaned records
- Complete audit of all users and bookings

**PostgreSQL Syntax:**
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    "User" u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    COALESCE(b.created_at, u.created_at) DESC;
```

**MySQL-Compatible Syntax:**
```sql
-- Use UNION of LEFT and RIGHT JOIN
SELECT ...
FROM "User" u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

SELECT ...
FROM Booking b
LEFT JOIN "User" u ON b.user_id = u.user_id
WHERE u.user_id IS NULL;
```

**Expected Results:**
- Users with bookings: Shows user info + booking info
- Users without bookings: Shows user info + NULL for booking columns
- Bookings without users: Shows NULL for user columns + booking info (indicates data integrity issue)
- Helps identify orphaned bookings or inactive users

---

## 🚀 How to Use

### Prerequisites

1. Ensure your database is set up with the schema from `database-script-0x01/schema.sql`
2. Ensure your database is populated with sample data from `database-script-0x02/seed.sql`
3. Have database client access (psql, pgAdmin, DBeaver, MySQL Workbench, etc.)

### Running the Queries

#### PostgreSQL

```bash
# Connect to your database
psql -U your_username -d airbnb_clone

# Run the queries
\i database-adv-script/joins_queries.sql

# Or execute specific queries directly
psql -U your_username -d airbnb_clone -f database-adv-script/joins_queries.sql
```

#### MySQL

```bash
# Connect to your database
mysql -u your_username -p airbnb_clone

# Source the file
source database-adv-script/joins_queries.sql

# Or execute directly
mysql -u your_username -p airbnb_clone < database-adv-script/joins_queries.sql
```

#### Database Client (pgAdmin, DBeaver, etc.)

1. Open your database client
2. Connect to your database
3. Open `joins_queries.sql`
4. Execute individual queries or the entire file

---

## 📊 Understanding JOIN Types

### Visual Representation

```
INNER JOIN (A ∩ B)
Returns only matching rows from both tables
     Table A      Table B
    ┌──────┐     ┌──────┐
    │ 1,2  │━━━━━│ 2,3  │
    │      │     │      │
    └──────┘     └──────┘
Result: {2} (only matching values)

LEFT JOIN (A ∪ B where B matches)
Returns all rows from A, plus matching rows from B
     Table A      Table B
    ┌──────┐     ┌──────┐
    │ 1,2  │━━━━━│ 2,3  │
    │      │     │      │
    └──────┘     └──────┘
Result: {1, 2} (all from A, matches from B)

FULL OUTER JOIN (A ∪ B)
Returns all rows from both tables
     Table A      Table B
    ┌──────┐     ┌──────┐
    │ 1,2  │━━━━━│ 2,3  │
    │      │     │      │
    └──────┘     └──────┘
Result: {1, 2, 3} (all from both)
```

---

## 🔑 Key Concepts

### JOIN Conditions

Always specify the join condition explicitly:
```sql
INNER JOIN "User" u ON b.user_id = u.user_id
```

### NULL Handling

When using LEFT or FULL OUTER JOIN, handle NULLs appropriately:
```sql
COALESCE(column_name, 'Default Value')
COALESCE(AVG(rating), 0)
```

### Multiple Joins

You can chain multiple JOINs:
```sql
SELECT ...
FROM Table1 t1
INNER JOIN Table2 t2 ON t1.id = t2.id
LEFT JOIN Table3 t3 ON t2.id = t3.id
```

### Performance Tips

1. **Indexes**: Ensure foreign keys are indexed for faster joins
2. **Filter Early**: Use WHERE clauses to reduce data before joining
3. **Selectivity**: Join on indexed columns when possible
4. **Query Plan**: Use EXPLAIN to analyze join performance

---

## ✅ Verification

After running the queries, verify the results:

### Query 1 Verification
```sql
-- Should return only bookings with valid users
SELECT COUNT(*) FROM Booking b
INNER JOIN "User" u ON b.user_id = u.user_id;
```

### Query 2 Verification
```sql
-- Should return all properties (more than properties with reviews)
SELECT COUNT(DISTINCT p.property_id) FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
```

### Query 3 Verification
```sql
-- Should return count of all users + count of all bookings (may have duplicates)
SELECT COUNT(*) FROM "User" u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;
```

---

## 🎓 Learning Outcomes

By completing this task, you will:

✅ **Understand INNER JOIN**: Match records that exist in both tables  
✅ **Master LEFT JOIN**: Retrieve all records from left table with optional matches  
✅ **Grasp FULL OUTER JOIN**: Get complete picture from both tables  
✅ **Handle NULL Values**: Deal with missing relationships appropriately  
✅ **Write Complex Queries**: Combine multiple tables and conditions  
✅ **Optimize Performance**: Use indexes and efficient join strategies  

---

## 📚 Additional Resources

- [PostgreSQL JOIN Documentation](https://www.postgresql.org/docs/current/queries-table-expressions.html)
- [MySQL JOIN Documentation](https://dev.mysql.com/doc/refman/8.0/en/join.html)
- [SQL JOIN Visual Guide](https://sql-joins.leopard.in.ua/)
- [Database Normalization](./../../normalization.md)

---

## 🐛 Troubleshooting

### Issue: "Table doesn't exist"
**Solution:** Ensure schema is created using `database-script-0x01/schema.sql`

### Issue: "No data returned"
**Solution:** Ensure database is seeded using `database-script-0x02/seed.sql`

### Issue: "FULL OUTER JOIN not supported" (MySQL)
**Solution:** Use the MySQL-compatible version with UNION in the file

### Issue: "Column name ambiguous"
**Solution:** Use table aliases and qualify column names (e.g., `u.user_id`)

---

## 📝 Notes

- All queries use proper table aliases for readability
- Column names are qualified to avoid ambiguity
- NULL handling is demonstrated with COALESCE
- Queries are optimized with ORDER BY for meaningful results
- Both PostgreSQL and MySQL-compatible versions are provided where needed

---

## 👨‍💻 Author

**Billy Mwangi**

- Project: ALX Airbnb Database Module
- Repository: [alx-airbnb-database](https://github.com/BillyMwangiDev/alx-airbnb-database)

---

**Last Updated:** November 1, 2025  
**Version:** 1.0.0  
**Status:** ✅ Complete

