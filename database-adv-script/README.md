# Complex SQL Queries with Joins

## Overview

This directory contains SQL queries demonstrating different types of JOIN operations using the AirBnB Clone database schema.

## Files

### `joins_queries.sql`
Contains three main queries:
1. **INNER JOIN**: Retrieves all bookings with their respective users
2. **LEFT JOIN**: Retrieves all properties with their reviews (including properties with no reviews)
3. **FULL OUTER JOIN**: Retrieves all users and all bookings, even if unlinked

## Query Details

### Query 1: INNER JOIN
Retrieve all bookings and the respective users who made those bookings.

Returns only rows where there's a match in both tables. Bookings without a valid user_id are excluded.

### Query 2: LEFT JOIN
Retrieve all properties and their reviews, including properties that have no reviews.

Returns all rows from the Property table. For properties without reviews, review columns will be NULL.

### Query 3: FULL OUTER JOIN
Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

Returns all rows from both tables. Users without bookings will have NULL booking columns. Orphaned bookings will have NULL user columns.

## Usage

### Prerequisites
- Database schema created using `database-script-0x01/schema.sql`
- PostgreSQL 13+ database
- SELECT permissions on all tables

### Running the Queries

**Using psql:**
```bash
psql -U your_username -d airbnb_clone -f database-adv-script/joins_queries.sql
```

**Using PostgreSQL Client:**
Open the `joins_queries.sql` file in your client and execute individual queries or the entire script.

## Related Resources

- Schema Definition: `../database-script-0x01/schema.sql`
- Sample Data: `../database-script-0x02/seed.sql`

---

**Author:** Billy Mwangi  
**Date:** October 26, 2025

