-- Query Performance Optimization
-- Database: PostgreSQL 13+
-- This file contains initial query and optimized versions

-- =============================================
-- INITIAL QUERY (Inefficient Version)
-- =============================================
-- Query: Retrieve all bookings with user, property, and payment details
-- Issues: Multiple joins, potential for cartesian products, no specific filtering

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    u.role AS user_role,
    u.created_at AS user_created_at,
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.location AS property_location,
    p.pricepernight AS property_price_per_night,
    p.created_at AS property_created_at,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;


-- =============================================
-- OPTIMIZED QUERY 1: Filtered and Indexed
-- =============================================
-- Improvements:
-- 1. Added WHERE clause to filter confirmed bookings only
-- 2. Select only necessary columns
-- 3. Use indexes on created_at and foreign keys

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight AS property_price_per_night,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.created_at DESC
LIMIT 100;


-- =============================================
-- OPTIMIZED QUERY 2: Date Range Filter
-- =============================================
-- Improvements:
-- 1. Filter by date range to reduce dataset
-- 2. Use date index for faster filtering

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location AS property_location,
    host.first_name AS host_first_name,
    host.email AS host_email,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '6 months'
    AND b.status IN ('confirmed', 'pending')
ORDER BY 
    b.created_at DESC;


-- =============================================
-- OPTIMIZED QUERY 3: Aggregate Payment (if multiple payments per booking)
-- =============================================
-- Improvements:
-- 1. Aggregate payment data to avoid duplicate rows
-- 2. Use subquery for payment summary

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location AS property_location,
    host.first_name AS host_first_name,
    host.email AS host_email,
    payment_summary.total_paid,
    payment_summary.payment_count,
    payment_summary.last_payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN (
    SELECT 
        booking_id,
        SUM(amount) AS total_paid,
        COUNT(*) AS payment_count,
        MAX(payment_method) AS last_payment_method
    FROM 
        Payment
    GROUP BY 
        booking_id
) payment_summary ON b.booking_id = payment_summary.booking_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.created_at DESC;


-- =============================================
-- PERFORMANCE ANALYSIS QUERIES
-- =============================================

-- Analyze initial query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    u.role AS user_role,
    u.created_at AS user_created_at,
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.location AS property_location,
    p.pricepernight AS property_price_per_night,
    p.created_at AS property_created_at,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;


-- Analyze optimized query 1
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight AS property_price_per_night,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    "User" host ON p.host_id = host.user_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.created_at DESC
LIMIT 100;

