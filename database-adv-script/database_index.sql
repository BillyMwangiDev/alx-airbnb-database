-- Database Indexes for Performance Optimization
-- Database: PostgreSQL 13+
-- Purpose: Create additional indexes to improve query performance

-- =============================================
-- USER TABLE INDEXES
-- =============================================

-- Index on created_at for sorting by creation date
CREATE INDEX IF NOT EXISTS idx_user_created_at ON "User"(created_at DESC);

-- Composite index for user queries with name sorting
CREATE INDEX IF NOT EXISTS idx_user_name_sort ON "User"(last_name ASC, first_name ASC);


-- =============================================
-- BOOKING TABLE INDEXES
-- =============================================

-- Index on created_at for sorting booking by creation date
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON Booking(created_at DESC);

-- Composite index for user bookings with date sorting
CREATE INDEX IF NOT EXISTS idx_booking_user_created ON Booking(user_id, created_at DESC);

-- Composite index for property bookings with date sorting
CREATE INDEX IF NOT EXISTS idx_booking_property_created ON Booking(property_id, created_at DESC);

-- Composite index for status filtering with date sorting
CREATE INDEX IF NOT EXISTS idx_booking_status_created ON Booking(status, created_at DESC);

-- Composite index for date range queries
CREATE INDEX IF NOT EXISTS idx_booking_dates_range ON Booking(start_date, end_date);


-- =============================================
-- PROPERTY TABLE INDEXES
-- =============================================

-- Index on created_at for sorting properties by creation date
CREATE INDEX IF NOT EXISTS idx_property_created_at ON Property(created_at DESC);

-- Index on name for sorting properties alphabetically
CREATE INDEX IF NOT EXISTS idx_property_name ON Property(name ASC);

-- Composite index for location and price filtering
CREATE INDEX IF NOT EXISTS idx_property_location_price ON Property(location, pricepernight);

-- Composite index for host properties with sorting
CREATE INDEX IF NOT EXISTS idx_property_host_created ON Property(host_id, created_at DESC);


-- =============================================
-- REVIEW TABLE INDEXES (for completeness)
-- =============================================

-- Index on created_at for sorting reviews by date
CREATE INDEX IF NOT EXISTS idx_review_created_at ON Review(created_at DESC);

-- Composite index for property reviews with rating
CREATE INDEX IF NOT EXISTS idx_review_property_rating ON Review(property_id, rating DESC);

-- Composite index for property reviews with date
CREATE INDEX IF NOT EXISTS idx_review_property_created ON Review(property_id, created_at DESC);


-- =============================================
-- PERFORMANCE MEASUREMENT WITH EXPLAIN ANALYZE
-- =============================================
-- Note: Run these queries BEFORE and AFTER creating indexes
-- Compare execution plans and timing to measure performance improvements

-- =============================================
-- QUERY 1: Bookings with Users (ORDER BY created_at)
-- =============================================
-- This query benefits from idx_booking_created_at and idx_booking_user_created

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


-- =============================================
-- QUERY 2: User Booking Count (GROUP BY with ORDER BY)
-- =============================================
-- This query benefits from idx_booking_user_created and idx_user_name_sort

EXPLAIN ANALYZE
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


-- =============================================
-- QUERY 3: Properties with Reviews (ORDER BY name)
-- =============================================
-- This query benefits from idx_property_name

EXPLAIN ANALYZE
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


-- =============================================
-- QUERY 4: User Bookings Filtered by Status
-- =============================================
-- This query benefits from idx_booking_status_created

EXPLAIN ANALYZE
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


-- =============================================
-- QUERY 5: Properties by Location and Price
-- =============================================
-- This query benefits from idx_property_location_price

EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.created_at
FROM 
    Property p
WHERE 
    p.location = 'New York' 
    AND p.pricepernight BETWEEN 100 AND 300
ORDER BY 
    p.pricepernight ASC;


-- =============================================
-- QUERY 6: Property Rankings by Booking Count
-- =============================================
-- This query benefits from idx_booking_property_created

EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(b.booking_id) AS total_bookings
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location
ORDER BY 
    total_bookings DESC;


-- =============================================
-- QUERY 7: Users Sorted by Creation Date
-- =============================================
-- This query benefits from idx_user_created_at

EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at
FROM 
    "User" u
ORDER BY 
    u.created_at DESC;


-- =============================================
-- QUERY 8: Bookings by Date Range
-- =============================================
-- This query benefits from idx_booking_dates_range

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.property_id,
    b.user_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM 
    Booking b
WHERE 
    b.start_date >= '2024-01-01' 
    AND b.end_date <= '2024-12-31'
ORDER BY 
    b.start_date ASC;


-- =============================================
-- VERIFY INDEXES CREATED
-- =============================================

-- List all indexes for User, Booking, and Property tables
SELECT 
    schemaname,
    tablename,
    indexname,
    indexdef
FROM 
    pg_indexes
WHERE 
    schemaname = 'public'
    AND tablename IN ('User', 'Booking', 'Property', 'Review')
ORDER BY 
    tablename, indexname;

