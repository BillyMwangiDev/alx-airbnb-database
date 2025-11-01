# Advanced SQL Queries

## Overview

This directory contains SQL queries for the AirBnB Clone database, including joins, subqueries, aggregations, and window functions.

## Files

### `joins_queries.sql`
SQL queries using different join types:
- **INNER JOIN**: Retrieves all bookings with their respective users
- **LEFT JOIN**: Retrieves all properties with their reviews (including properties with no reviews)
- **FULL OUTER JOIN**: Retrieves all users and all bookings, even if unlinked
- Additional examples: COUNT reviews per property, users with no bookings

### `subqueries.sql`
Subquery implementations:
- **Non-Correlated Subquery**: Finds properties where average rating is greater than 4.0
- **Correlated Subquery**: Finds users who have made more than 3 bookings
- Alternative approaches: GROUP BY/HAVING, EXISTS clause

### `aggregations_and_window_functions.sql`
Aggregation and ranking queries:
- **COUNT with GROUP BY**: Total number of bookings per user
- **Window Functions**: Ranks properties by booking count using ROW_NUMBER, RANK, and DENSE_RANK
- Additional features: SUM/AVG aggregations, PARTITION BY, cumulative calculations, percentile ranking

## Features

### Joins
- Combines data from multiple tables (User, Booking, Property, Review)
- Handles NULL values appropriately with LEFT and FULL OUTER JOINs
- Returns complete booking information with user details
- Returns all properties regardless of review status

### Subqueries
- Non-correlated subqueries for independent filtering
- Correlated subqueries for user-specific calculations
- Efficient property filtering by rating averages
- User booking count analysis

### Aggregations and Window Functions
- Booking counts per user and property
- Revenue calculations (total, average, min, max)
- Property rankings by popularity (booking count)
- Location-based rankings with PARTITION BY
- Cumulative booking and revenue tracking
- Percentile and distribution analysis

## Usage

### Prerequisites
- Database schema created using `database-script-0x01/schema.sql`
- PostgreSQL 13+ database
- SELECT permissions on all tables

### Running the Queries

**Using psql:**
```bash
psql -U your_username -d airbnb_clone -f database-adv-script/joins_queries.sql
psql -U your_username -d airbnb_clone -f database-adv-script/subqueries.sql
psql -U your_username -d airbnb_clone -f database-adv-script/aggregations_and_window_functions.sql
```

**Using PostgreSQL Client:**
Open the query files in your client and execute individual queries or the entire script.

## Related Resources

- Schema Definition: `../database-script-0x01/schema.sql`
- Sample Data: `../database-script-0x02/seed.sql`

---

**Author:** Billy Mwangi  
**Date:** October 26, 2025
