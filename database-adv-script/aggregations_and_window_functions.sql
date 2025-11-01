-- Aggregations and Window Functions
-- Database: PostgreSQL 13+

-- QUERY 1: Aggregation with COUNT and GROUP BY
-- Find the total number of bookings made by each user

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


-- QUERY 2: Window Functions - ROW_NUMBER and RANK
-- Rank properties based on the total number of bookings they have received

SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_value,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS dense_rank_value
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.host_id, p.name, p.location, p.pricepernight
ORDER BY 
    total_bookings DESC;


-- ADDITIONAL EXAMPLES

-- Example 1: Aggregation with SUM and AVG
-- Calculate total revenue and average booking price per user

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_revenue,
    AVG(b.total_price) AS average_booking_price,
    MIN(b.total_price) AS min_booking_price,
    MAX(b.total_price) AS max_booking_price
FROM 
    "User" u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
HAVING 
    COUNT(b.booking_id) > 0
ORDER BY 
    total_revenue DESC;


-- Example 2: Window Functions with PARTITION BY
-- Rank properties within each location based on booking count

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (
        PARTITION BY p.location 
        ORDER BY COUNT(b.booking_id) DESC
    ) AS rank_in_location
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.pricepernight
ORDER BY 
    p.location ASC, total_bookings DESC;


-- Example 3: Cumulative Sum using Window Functions
-- Calculate cumulative booking count per user over time

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.total_price,
    COUNT(b.booking_id) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_bookings,
    SUM(b.total_price) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM 
    "User" u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.created_at;


-- Example 4: Percentile Ranking
-- Rank properties by booking count and show percentile

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_value,
    PERCENT_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS percentile_rank,
    CUME_DIST() OVER (ORDER BY COUNT(b.booking_id) DESC) AS cumulative_distribution
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location
ORDER BY 
    total_bookings DESC;

