-- Table Partitioning Implementation
-- Database: PostgreSQL 13+
-- Purpose: Partition Booking table by start_date to improve query performance on large datasets

-- =============================================
-- STEP 1: CREATE PARTITIONED TABLE
-- =============================================
-- Create a new partitioned table with the same structure as Booking

CREATE TABLE IF NOT EXISTS Booking_partitioned (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints (defined at partition level)
    CONSTRAINT chk_dates_valid CHECK (end_date > start_date),
    CONSTRAINT chk_total_price_positive CHECK (total_price > 0),
    
    -- Primary key and foreign keys handled per partition
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Add comment
COMMENT ON TABLE Booking_partitioned IS 'Partitioned version of Booking table, partitioned by start_date';


-- =============================================
-- STEP 2: CREATE PARTITIONS BY YEAR
-- =============================================
-- Create partitions for different year ranges
-- Adjust date ranges based on your data distribution

-- Partition for bookings before 2024
CREATE TABLE IF NOT EXISTS Booking_partitioned_2023_and_prior
PARTITION OF Booking_partitioned
FOR VALUES FROM (MINVALUE) TO ('2024-01-01');

COMMENT ON TABLE Booking_partitioned_2023_and_prior IS 'Bookings with start_date before 2024';

-- Partition for 2024 bookings
CREATE TABLE IF NOT EXISTS Booking_partitioned_2024
PARTITION OF Booking_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

COMMENT ON TABLE Booking_partitioned_2024 IS 'Bookings with start_date in 2024';

-- Partition for 2025 bookings
CREATE TABLE IF NOT EXISTS Booking_partitioned_2025
PARTITION OF Booking_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

COMMENT ON TABLE Booking_partitioned_2025 IS 'Bookings with start_date in 2025';

-- Partition for 2026 bookings
CREATE TABLE IF NOT EXISTS Booking_partitioned_2026
PARTITION OF Booking_partitioned
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

COMMENT ON TABLE Booking_partitioned_2026 IS 'Bookings with start_date in 2026';

-- Partition for future bookings (2027 and beyond)
CREATE TABLE IF NOT EXISTS Booking_partitioned_future
PARTITION OF Booking_partitioned
FOR VALUES FROM ('2027-01-01') TO (MAXVALUE);

COMMENT ON TABLE Booking_partitioned_future IS 'Bookings with start_date in 2027 and beyond';


-- =============================================
-- STEP 3: CREATE FOREIGN KEY CONSTRAINTS
-- =============================================
-- Foreign key constraints need to be added to each partition individually
-- Note: This is a simplified approach. In production, you may want to use triggers.

ALTER TABLE Booking_partitioned_2024
ADD CONSTRAINT fk_booking_property_2024 FOREIGN KEY (property_id) 
    REFERENCES Property(property_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE Booking_partitioned_2024
ADD CONSTRAINT fk_booking_user_2024 FOREIGN KEY (user_id) 
    REFERENCES "User"(user_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

-- Repeat for other partitions as needed
-- For demonstration, we'll add to the most commonly used partition


-- =============================================
-- STEP 4: CREATE INDEXES ON PARTITIONS
-- =============================================
-- Create indexes on partitioned table (applies to all partitions)

CREATE INDEX IF NOT EXISTS idx_booking_partitioned_property 
ON Booking_partitioned(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_partitioned_user 
ON Booking_partitioned(user_id);

CREATE INDEX IF NOT EXISTS idx_booking_partitioned_status 
ON Booking_partitioned(status);

CREATE INDEX IF NOT EXISTS idx_booking_partitioned_created_at 
ON Booking_partitioned(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_booking_partitioned_dates 
ON Booking_partitioned(start_date, end_date);


-- =============================================
-- STEP 5: DATA MIGRATION (Optional)
-- =============================================
-- Migrate data from existing Booking table to partitioned table
-- WARNING: Only run this if you want to migrate existing data
-- Uncomment and modify as needed

/*
-- First, ensure the partitioned table structure matches
-- Then migrate data
INSERT INTO Booking_partitioned (
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    created_at
)
SELECT 
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    created_at
FROM Booking;

-- Verify data migration
SELECT 
    COUNT(*) AS total_bookings,
    MIN(start_date) AS earliest_booking,
    MAX(start_date) AS latest_booking
FROM Booking_partitioned;
*/


-- =============================================
-- STEP 6: PERFORMANCE TEST QUERIES
-- =============================================
-- Test queries to measure performance improvement

-- Query 1: Fetch bookings by date range (2024)
-- This should only scan the 2024 partition
EXPLAIN ANALYZE
SELECT 
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
FROM Booking_partitioned
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01'
ORDER BY start_date;


-- Query 2: Fetch bookings for specific month
-- Should efficiently scan only relevant partition
EXPLAIN ANALYZE
SELECT 
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
FROM Booking_partitioned
WHERE start_date >= '2024-06-01' 
  AND start_date < '2024-07-01'
ORDER BY start_date;


-- Query 3: Count bookings by date range
-- Demonstrates partition pruning
EXPLAIN ANALYZE
SELECT 
    DATE_TRUNC('month', start_date) AS month,
    COUNT(*) AS booking_count,
    SUM(total_price) AS total_revenue
FROM Booking_partitioned
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month;


-- Query 4: Join with other tables on partitioned table
-- Tests join performance with partitioning
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location
FROM Booking_partitioned b
INNER JOIN "User" u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date >= '2024-01-01' 
  AND b.start_date < '2025-01-01'
  AND b.status = 'confirmed'
ORDER BY b.start_date;


-- Query 5: Cross-partition query (multiple years)
-- Tests query across multiple partitions
EXPLAIN ANALYZE
SELECT 
    DATE_TRUNC('year', start_date) AS year,
    COUNT(*) AS booking_count,
    SUM(total_price) AS total_revenue
FROM Booking_partitioned
WHERE start_date >= '2024-01-01' 
  AND start_date < '2026-01-01'
GROUP BY DATE_TRUNC('year', start_date)
ORDER BY year;


-- =============================================
-- STEP 7: COMPARISON QUERIES
-- =============================================
-- Compare performance with original Booking table
-- Run these queries on both Booking and Booking_partitioned tables

-- Original Booking table query (for comparison)
EXPLAIN ANALYZE
SELECT 
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
FROM Booking
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01'
ORDER BY start_date;


-- Partitioned table query
EXPLAIN ANALYZE
SELECT 
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
FROM Booking_partitioned
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01'
ORDER BY start_date;


-- =============================================
-- STEP 8: VERIFY PARTITION PRUNING
-- =============================================
-- Check which partitions are being accessed

EXPLAIN (VERBOSE)
SELECT 
    booking_id,
    start_date,
    status
FROM Booking_partitioned
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01';

-- The EXPLAIN output should show only Booking_partitioned_2024 in the plan


-- =============================================
-- STEP 9: PARTITION INFORMATION QUERIES
-- =============================================

-- List all partitions
SELECT 
    schemaname,
    tablename,
    partitiontype,
    partitiondef
FROM pg_partitions
WHERE tablename = 'booking_partitioned';

-- Alternative method to view partition information
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE tablename LIKE 'booking_partitioned%'
ORDER BY tablename;

-- Get row counts per partition
SELECT 
    'Booking_partitioned_2023_and_prior' AS partition_name,
    COUNT(*) AS row_count
FROM Booking_partitioned_2023_and_prior
UNION ALL
SELECT 'Booking_partitioned_2024', COUNT(*) FROM Booking_partitioned_2024
UNION ALL
SELECT 'Booking_partitioned_2025', COUNT(*) FROM Booking_partitioned_2025
UNION ALL
SELECT 'Booking_partitioned_2026', COUNT(*) FROM Booking_partitioned_2026
UNION ALL
SELECT 'Booking_partitioned_future', COUNT(*) FROM Booking_partitioned_future;

