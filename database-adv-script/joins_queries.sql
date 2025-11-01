-- Complex SQL Queries with Joins
-- Database: PostgreSQL 13+

-- QUERY 1: INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings

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
    u.role,
    u.created_at AS user_created_at
FROM 
    Booking b
INNER JOIN 
    "User" u ON b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;


-- QUERY 2: LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews

SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    p.updated_at AS property_updated_at,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.name ASC, r.created_at DESC;


-- QUERY 3: FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at
FROM 
    "User" u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.created_at DESC, b.created_at DESC;


-- ADDITIONAL EXAMPLES

-- COUNT reviews per property using LEFT JOIN
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(r.review_id) AS total_reviews,
    COALESCE(AVG(r.rating), 0) AS average_rating
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.location
ORDER BY 
    total_reviews DESC, average_rating DESC;


-- Identify users with no bookings using LEFT JOIN
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at
FROM 
    "User" u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    b.booking_id IS NULL
ORDER BY 
    u.created_at DESC;


