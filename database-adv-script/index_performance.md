# Index Performance Analysis

## Overview

This document analyzes query performance before and after adding indexes to improve database query execution speed.

## High-Usage Columns Identified

### User Table
- `user_id` - Primary key, used in JOINs
- `email` - Already indexed (unique constraint), used for authentication
- `role` - Already indexed, used in filtering
- `created_at` - Used in ORDER BY clauses for sorting users by creation date

### Booking Table
- `user_id` - Foreign key, used in JOINs with User table
- `property_id` - Foreign key, used in JOINs with Property table
- `status` - Already indexed, used in WHERE clauses for filtering
- `created_at` - Used in ORDER BY clauses for sorting bookings by date
- `start_date`, `end_date` - Already indexed, used in date range queries
- Composite queries: (user_id, created_at), (property_id, created_at)

### Property Table
- `property_id` - Primary key, used in JOINs
- `host_id` - Already indexed, used in JOINs with User table
- `location` - Already indexed, used in WHERE and GROUP BY clauses
- `pricepernight` - Already indexed, used in filtering
- `name` - Used in ORDER BY clauses for alphabetical sorting
- `created_at` - Used in ORDER BY clauses for sorting by creation date

## Existing Indexes

The base schema already includes these indexes:

**User Table:**
- `idx_user_email` on `email`
- `idx_user_role` on `role`

**Booking Table:**
- `idx_booking_property` on `property_id`
- `idx_booking_user` on `user_id`
- `idx_booking_status` on `status`
- `idx_booking_dates` on `(start_date, end_date)`

**Property Table:**
- `idx_property_host` on `host_id`
- `idx_property_location` on `location`
- `idx_property_price` on `pricepernight`

## New Indexes Created

### User Table
```sql
CREATE INDEX idx_user_created_at ON "User"(created_at DESC);
CREATE INDEX idx_user_name_sort ON "User"(last_name ASC, first_name ASC);
```

### Booking Table
```sql
CREATE INDEX idx_booking_created_at ON Booking(created_at DESC);
CREATE INDEX idx_booking_user_created ON Booking(user_id, created_at DESC);
CREATE INDEX idx_booking_property_created ON Booking(property_id, created_at DESC);
CREATE INDEX idx_booking_status_created ON Booking(status, created_at DESC);
CREATE INDEX idx_booking_dates_range ON Booking(start_date, end_date);
```

### Property Table
```sql
CREATE INDEX idx_property_created_at ON Property(created_at DESC);
CREATE INDEX idx_property_name ON Property(name ASC);
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);
CREATE INDEX idx_property_host_created ON Property(host_id, created_at DESC);
```

## Performance Testing Queries

### Test Query 1: Bookings with Users (ORDER BY created_at)

**Query:**
```sql
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
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

**Before Index:**
```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
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

**Expected Result (Before):**
- Sequential scan on Booking table
- Sort operation on created_at
- Estimated execution time: Higher

**After Index (idx_booking_created_at):**
```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
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

**Expected Result (After):**
- Index scan on idx_booking_created_at (DESC order)
- Faster join using existing idx_booking_user
- Estimated execution time: Lower

### Test Query 2: User Booking Count (GROUP BY with ORDER BY)

**Query:**
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM 
    "User" u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.role
ORDER BY 
    total_bookings DESC, u.last_name ASC;
```

**Before Index:**
- Full table scan on User
- Hash join with Booking
- Sort operation for ORDER BY

**After Index (idx_user_name_sort, idx_booking_user_created):**
- Index scan for name sorting
- More efficient join with composite index
- Faster GROUP BY and ORDER BY operations

### Test Query 3: Properties with Reviews (ORDER BY name)

**Query:**
```sql
SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
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
    p.name ASC, r.created_at DESC;
```

**Before Index:**
- Sequential scan on Property
- Sort operation on name

**After Index (idx_property_name):**
- Index scan on idx_property_name (ASC order)
- Faster sorting and joining

### Test Query 4: User Bookings Filtered by Status

**Query:**
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.status,
    b.created_at
FROM 
    "User" u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.created_at DESC;
```

**Before Index:**
- Filter on status (idx_booking_status exists)
- Sort operation on created_at

**After Index (idx_booking_status_created):**
- Index scan using composite index (status, created_at)
- Faster filtering and sorting in single operation

## Performance Measurement Commands

### Before Creating Indexes

1. Run EXPLAIN ANALYZE on test queries:
```sql
EXPLAIN ANALYZE
-- Your query here
```

2. Record execution time and plan:
```sql
EXPLAIN (FORMAT JSON, ANALYZE, BUFFERS, TIMING)
-- Your query here
```

### After Creating Indexes

1. Apply indexes:
```sql
\i database-adv-script/database_index.sql
```

2. Update table statistics:
```sql
ANALYZE "User";
ANALYZE Booking;
ANALYZE Property;
ANALYZE Review;
```

3. Re-run EXPLAIN ANALYZE:
```sql
EXPLAIN ANALYZE
-- Your query here
```

4. Compare execution plans:
- Check for Index Scan vs Sequential Scan
- Compare execution time
- Check buffer usage

## Expected Performance Improvements

### Query Performance Gains

1. **Sort Operations**: 50-90% faster with indexes on ORDER BY columns
2. **JOIN Operations**: 30-70% faster with composite indexes on join keys
3. **Filter Operations**: 40-80% faster with indexes on WHERE clause columns
4. **GROUP BY Operations**: 20-50% faster with appropriate indexes

### Specific Improvements

- **Booking queries with date sorting**: 60-80% improvement
- **User queries with name sorting**: 50-70% improvement
- **Property queries with name/location filtering**: 40-60% improvement
- **Composite queries (user + booking + sorting)**: 50-75% improvement

## Index Maintenance

### Monitor Index Usage

```sql
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM 
    pg_stat_user_indexes
WHERE 
    schemaname = 'public'
    AND tablename IN ('User', 'Booking', 'Property', 'Review')
ORDER BY 
    idx_scan DESC;
```

### Identify Unused Indexes

```sql
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan
FROM 
    pg_stat_user_indexes
WHERE 
    schemaname = 'public'
    AND idx_scan = 0
ORDER BY 
    tablename, indexname;
```

### Update Statistics Regularly

```sql
ANALYZE "User";
ANALYZE Booking;
ANALYZE Property;
ANALYZE Review;
```

## Notes

- Indexes improve read performance but slightly impact write performance (INSERT, UPDATE, DELETE)
- Monitor index bloat and rebuild when necessary: `REINDEX TABLE table_name;`
- Use EXPLAIN ANALYZE regularly to verify index usage
- Adjust indexes based on actual query patterns in production

