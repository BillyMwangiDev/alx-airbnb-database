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

