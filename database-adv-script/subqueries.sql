-- Practice Subqueries
-- Database: PostgreSQL 13+

-- QUERY 1: Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0

SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at,
    (
        SELECT AVG(r.rating)
        FROM Review r
        WHERE r.property_id = p.property_id
    ) AS average_rating
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT r.property_id
        FROM Review r
        GROUP BY r.property_id
        HAVING AVG(r.rating) > 4.0
    )
ORDER BY 
    average_rating DESC;


-- QUERY 2: Correlated Subquery
-- Find users who have made more than 3 bookings

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at,
    (
        SELECT COUNT(*)
        FROM Booking b
        WHERE b.user_id = u.user_id
    ) AS total_bookings
FROM 
    "User" u
WHERE 
    (
        SELECT COUNT(*)
        FROM Booking b
        WHERE b.user_id = u.user_id
    ) > 3
ORDER BY 
    total_bookings DESC;


-- ALTERNATIVE QUERY 1: Using HAVING clause with GROUP BY
-- More efficient approach for finding properties with average rating > 4.0

SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at,
    AVG(r.rating) AS average_rating
FROM 
    Property p
INNER JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.host_id, p.name, p.description, p.location, p.pricepernight, p.created_at
HAVING 
    AVG(r.rating) > 4.0
ORDER BY 
    average_rating DESC;


-- ALTERNATIVE QUERY 2: Using EXISTS clause
-- Alternative correlated subquery approach for users with more than 3 bookings

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at,
    (
        SELECT COUNT(*)
        FROM Booking b
        WHERE b.user_id = u.user_id
    ) AS total_bookings
FROM 
    "User" u
WHERE 
    EXISTS (
        SELECT 1
        FROM Booking b
        WHERE b.user_id = u.user_id
        GROUP BY b.user_id
        HAVING COUNT(*) > 3
    )
ORDER BY 
    total_bookings DESC;

