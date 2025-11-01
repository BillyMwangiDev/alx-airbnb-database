-- =============================================
-- AirBnB Clone - Complex SQL Joins Queries
-- =============================================
-- This script contains complex SQL queries demonstrating
-- different types of JOIN operations.
--
-- Database: PostgreSQL 13+ or MySQL 8+
-- Author: Billy Mwangi
-- Date: November 1, 2025
-- =============================================

-- =============================================
-- QUERY 1: INNER JOIN
-- =============================================
-- Objective: Retrieve all bookings and the respective users who made those bookings
-- 
-- Description: An INNER JOIN returns only the rows that have matching values
--              in both tables. This query shows only bookings that have an
--              associated user, and only users who have made bookings.
-- =============================================

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
    u.email,
    u.phone_number,
    u.role
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;

-- Alternative: More detailed query with property information
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name || ' ' || u.last_name AS user_full_name,
    u.email,
    u.role AS user_role,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
ORDER BY 
    b.created_at DESC;

-- =============================================
-- QUERY 2: LEFT JOIN
-- =============================================
-- Objective: Retrieve all properties and their reviews, including properties 
--            that have no reviews
-- 
-- Description: A LEFT JOIN returns all rows from the left table (Property)
--              and matching rows from the right table (Review). If there is
--              no match, NULL values are returned for Review columns.
-- =============================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at,
    u.user_id AS reviewer_id,
    u.first_name || ' ' || u.last_name AS reviewer_name,
    u.email AS reviewer_email
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
LEFT JOIN 
    "User" u ON r.user_id = u.user_id
ORDER BY 
    p.created_at DESC, 
    r.created_at DESC;

-- Alternative: Count reviews per property (including properties with 0 reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    COUNT(r.review_id) AS total_reviews,
    COALESCE(AVG(r.rating), 0) AS average_rating,
    COALESCE(MIN(r.rating), NULL) AS min_rating,
    COALESCE(MAX(r.rating), NULL) AS max_rating
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, 
    p.name, 
    p.location, 
    p.pricepernight
ORDER BY 
    total_reviews DESC, 
    p.name ASC;

-- =============================================
-- QUERY 3: FULL OUTER JOIN
-- =============================================
-- Objective: Retrieve all users and all bookings, even if the user has no 
--            booking or a booking is not linked to a user
-- 
-- Description: A FULL OUTER JOIN returns all rows from both tables, matching
--              them where possible. If there is no match, NULL values are
--              returned for the missing side.
--
-- Note: MySQL does not support FULL OUTER JOIN natively. Use UNION of 
--       LEFT JOIN and RIGHT JOIN for MySQL compatibility.
-- =============================================

-- PostgreSQL version (using FULL OUTER JOIN)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at
FROM 
    "User" u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    COALESCE(b.created_at, u.created_at) DESC;

-- MySQL-compatible version (using UNION of LEFT and RIGHT JOIN)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at
FROM 
    "User" u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at
FROM 
    Booking b
LEFT JOIN 
    "User" u ON b.user_id = u.user_id
WHERE 
    u.user_id IS NULL

ORDER BY 
    COALESCE(booking_created_at, user_created_at) DESC;

-- =============================================
-- BONUS QUERIES: Additional JOIN Examples
-- =============================================

-- BONUS 1: Multiple table joins with aggregations
-- Retrieve all properties with their host info, booking counts, and review stats
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    u.user_id AS host_id,
    u.first_name || ' ' || u.last_name AS host_name,
    u.email AS host_email,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    COUNT(DISTINCT r.review_id) AS total_reviews,
    COALESCE(AVG(r.rating), 0) AS average_rating
FROM 
    Property p
INNER JOIN 
    "User" u ON p.host_id = u.user_id
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, 
    p.name, 
    p.location, 
    p.pricepernight,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
ORDER BY 
    total_bookings DESC, 
    average_rating DESC;

-- BONUS 2: Self-join example (users who have messaged each other)
SELECT 
    sender.first_name || ' ' || sender.last_name AS sender_name,
    sender.email AS sender_email,
    recipient.first_name || ' ' || recipient.last_name AS recipient_name,
    recipient.email AS recipient_email,
    m.message_body,
    m.sent_at
FROM 
    Message m
INNER JOIN 
    "User" sender ON m.sender_id = sender.user_id
INNER JOIN 
    "User" recipient ON m.recipient_id = recipient.user_id
ORDER BY 
    m.sent_at DESC;

-- =============================================
-- END OF JOINS QUERIES
-- =============================================

