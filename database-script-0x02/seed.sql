-- =============================================
-- AirBnB Clone Database - Sample Data Seeding
-- =============================================
-- This script populates the database with realistic sample data
-- for testing and development purposes.
--
-- Execution Order (maintains referential integrity):
-- 1. USER (no dependencies)
-- 2. PROPERTY (depends on USER)
-- 3. BOOKING (depends on USER and PROPERTY)
-- 4. PAYMENT (depends on BOOKING)
-- 5. REVIEW (depends on USER and PROPERTY)
-- 6. MESSAGE (depends on USER)
-- =============================================

-- Clean existing data (optional - uncomment if needed)
-- DELETE FROM Message;
-- DELETE FROM Review;
-- DELETE FROM Payment;
-- DELETE FROM Booking;
-- DELETE FROM Property;
-- DELETE FROM "User";

-- =============================================
-- 1. INSERT USERS (15 users: guests, hosts, admins)
-- =============================================

INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins (2)
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Alice', 'Admin', 'alice.admin@airbnb.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-0001', 'admin', '2023-01-15 09:00:00'),
('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Bob', 'Manager', 'bob.manager@airbnb.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-0002', 'admin', '2023-01-20 10:30:00'),

-- Hosts (6)
('c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Charlie', 'Host', 'charlie.host@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1001', 'host', '2023-02-01 14:20:00'),
('d3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Diana', 'Property', 'diana.properties@yahoo.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1002', 'host', '2023-02-10 11:15:00'),
('e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Edward', 'Rentals', 'edward.rentals@outlook.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1003', 'host', '2023-03-05 16:45:00'),
('f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Fiona', 'Homes', 'fiona.homes@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1004', 'host', '2023-03-15 09:30:00'),
('10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'George', 'Estates', 'george.estates@hotmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1005', 'host', '2023-04-01 13:20:00'),
('11eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Hannah', 'Lodging', 'hannah.lodging@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-1006', 'host', '2023-04-10 10:00:00'),

-- Guests (7)
('12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Ian', 'Guest', 'ian.guest@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2001', 'guest', '2023-05-01 08:00:00'),
('13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Julia', 'Traveler', 'julia.traveler@yahoo.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2002', 'guest', '2023-05-10 12:30:00'),
('14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Kevin', 'Explorer', 'kevin.explorer@outlook.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2003', 'guest', '2023-05-15 15:45:00'),
('15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Laura', 'Wanderer', 'laura.wanderer@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2004', 'guest', '2023-06-01 09:15:00'),
('16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Michael', 'Nomad', 'michael.nomad@hotmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2005', 'guest', '2023-06-10 14:00:00'),
('17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'Nina', 'Voyager', 'nina.voyager@gmail.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2006', 'guest', '2023-06-20 11:30:00'),
('18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'Oscar', 'Tourist', 'oscar.tourist@yahoo.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm', '+1-555-2007', 'guest', '2023-07-01 16:20:00');

-- =============================================
-- 2. INSERT PROPERTIES (25 properties)
-- =============================================

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
-- Charlie's Properties (5)
('p1000001-0000-0000-0000-000000000001', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Cozy Downtown Loft', 'Modern loft in the heart of downtown with skyline views. Perfect for business travelers.', 'New York, NY', 150.00, '2023-02-05 10:00:00', '2023-02-05 10:00:00'),
('p1000001-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Beachfront Paradise', 'Stunning beach house with direct ocean access. Sleeps 8 comfortably.', 'Miami, FL', 350.00, '2023-02-10 14:30:00', '2023-02-10 14:30:00'),
('p1000001-0000-0000-0000-000000000003', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Mountain Cabin Retreat', 'Rustic cabin surrounded by nature. Great for hiking and relaxation.', 'Denver, CO', 120.00, '2023-02-15 09:15:00', '2023-02-15 09:15:00'),
('p1000001-0000-0000-0000-000000000004', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Urban Studio Apartment', 'Compact studio in trendy neighborhood with excellent restaurants nearby.', 'Portland, OR', 85.00, '2023-03-01 11:00:00', '2023-03-01 11:00:00'),
('p1000001-0000-0000-0000-000000000005', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Luxury Penthouse Suite', 'High-end penthouse with panoramic city views and premium amenities.', 'San Francisco, CA', 500.00, '2023-03-10 15:45:00', '2023-03-10 15:45:00'),

-- Diana's Properties (4)
('p2000001-0000-0000-0000-000000000001', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Historic Victorian Home', 'Beautifully restored Victorian with original features and modern comforts.', 'Boston, MA', 200.00, '2023-02-20 12:00:00', '2023-02-20 12:00:00'),
('p2000001-0000-0000-0000-000000000002', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Lakeside Cottage', 'Peaceful cottage on private lake. Includes kayaks and fishing gear.', 'Austin, TX', 180.00, '2023-03-05 10:30:00', '2023-03-05 10:30:00'),
('p2000001-0000-0000-0000-000000000003', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Desert Oasis Villa', 'Stunning desert property with pool and outdoor entertaining area.', 'Phoenix, AZ', 220.00, '2023-03-15 13:20:00', '2023-03-15 13:20:00'),
('p2000001-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'City Center Condo', 'Modern condo walking distance to major attractions and dining.', 'Chicago, IL', 140.00, '2023-04-01 09:00:00', '2023-04-01 09:00:00'),

-- Edward's Properties (4)
('p3000001-0000-0000-0000-000000000001', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Vineyard Guest House', 'Charming guest house on working vineyard. Wine tasting included.', 'Napa Valley, CA', 280.00, '2023-03-20 14:00:00', '2023-03-20 14:00:00'),
('p3000001-0000-0000-0000-000000000002', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Ski-In Ski-Out Chalet', 'Slope-side chalet with hot tub and fireplace. Perfect for winter getaways.', 'Aspen, CO', 450.00, '2023-04-05 11:30:00', '2023-04-05 11:30:00'),
('p3000001-0000-0000-0000-000000000003', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Tropical Bungalow', 'Private bungalow with garden and outdoor shower. Steps from beach.', 'Key West, FL', 190.00, '2023-04-15 10:15:00', '2023-04-15 10:15:00'),
('p3000001-0000-0000-0000-000000000004', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Downtown Artist Loft', 'Spacious loft in arts district. High ceilings and natural light.', 'Seattle, WA', 165.00, '2023-05-01 15:00:00', '2023-05-01 15:00:00'),

-- Fiona's Properties (4)
('p4000001-0000-0000-0000-000000000001', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Family-Friendly Farmhouse', 'Spacious farmhouse on 5 acres. Great for families with kids.', 'Nashville, TN', 175.00, '2023-03-25 09:45:00', '2023-03-25 09:45:00'),
('p4000001-0000-0000-0000-000000000002', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Riverside Retreat', 'Secluded home along peaceful river. Fishing and rafting available.', 'Portland, ME', 155.00, '2023-04-10 12:00:00', '2023-04-10 12:00:00'),
('p4000001-0000-0000-0000-000000000003', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Golf Course Villa', 'Luxury villa overlooking championship golf course.', 'Scottsdale, AZ', 320.00, '2023-04-20 14:30:00', '2023-04-20 14:30:00'),
('p4000001-0000-0000-0000-000000000004', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Minimalist Tiny Home', 'Eco-friendly tiny home with all essentials. Great for digital nomads.', 'Austin, TX', 75.00, '2023-05-05 10:00:00', '2023-05-05 10:00:00'),

-- George's Properties (4)
('p5000001-0000-0000-0000-000000000001', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Harborside Apartment', 'Waterfront apartment with marina views. Walking distance to shops.', 'San Diego, CA', 210.00, '2023-04-15 11:20:00', '2023-04-15 11:20:00'),
('p5000001-0000-0000-0000-000000000002', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Historic Brownstone', 'Elegant brownstone in prestigious neighborhood. 3 bedrooms, 2 baths.', 'Philadelphia, PA', 195.00, '2023-04-25 13:45:00', '2023-04-25 13:45:00'),
('p5000001-0000-0000-0000-000000000003', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Garden Studio', 'Ground floor studio with private garden patio.', 'Charleston, SC', 110.00, '2023-05-10 09:30:00', '2023-05-10 09:30:00'),
('p5000001-0000-0000-0000-000000000004', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Penthouse with Rooftop', 'Top floor unit with private rooftop deck and skyline views.', 'Atlanta, GA', 275.00, '2023-05-20 15:00:00', '2023-05-20 15:00:00'),

-- Hannah's Properties (4)
('p6000001-0000-0000-0000-000000000001', '11eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Countryside B&B Room', 'Cozy room in charming bed and breakfast. Breakfast included.', 'Savannah, GA', 95.00, '2023-04-30 10:15:00', '2023-04-30 10:15:00'),
('p6000001-0000-0000-0000-000000000002', '11eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Modern Townhouse', 'Contemporary townhouse in family-friendly neighborhood.', 'Raleigh, NC', 145.00, '2023-05-15 12:30:00', '2023-05-15 12:30:00'),
('p6000001-0000-0000-0000-000000000003', '11eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Beach Condo with Pool', 'Condo in resort complex. Pool, gym, and beach access included.', 'Myrtle Beach, SC', 160.00, '2023-06-01 14:00:00', '2023-06-01 14:00:00'),
('p6000001-0000-0000-0000-000000000004', '11eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Mountain View Lodge', 'Lodge with spectacular mountain views. Hot tub on deck.', 'Gatlinburg, TN', 185.00, '2023-06-15 11:45:00', '2023-06-15 11:45:00');

-- =============================================
-- 3. INSERT BOOKINGS (35 bookings with various statuses)
-- =============================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings (15)
('b1000001-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2025-11-15', '2025-11-18', 450.00, 'confirmed', '2025-10-01 09:00:00'),
('b1000001-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', '2025-12-20', '2025-12-27', 2450.00, 'confirmed', '2025-10-05 14:30:00'),
('b1000001-0000-0000-0000-000000000003', 'p2000001-0000-0000-0000-000000000001', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2025-11-10', '2025-11-12', 400.00, 'confirmed', '2025-10-08 11:15:00'),
('b1000001-0000-0000-0000-000000000004', 'p3000001-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2025-11-25', '2025-11-28', 840.00, 'confirmed', '2025-10-10 16:45:00'),
('b1000001-0000-0000-0000-000000000005', 'p1000001-0000-0000-0000-000000000003', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2025-12-01', '2025-12-05', 480.00, 'confirmed', '2025-10-12 10:00:00'),
('b1000001-0000-0000-0000-000000000006', 'p4000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2025-11-20', '2025-11-23', 525.00, 'confirmed', '2025-10-15 13:20:00'),
('b1000001-0000-0000-0000-000000000007', 'p2000001-0000-0000-0000-000000000002', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2025-12-10', '2025-12-13', 540.00, 'confirmed', '2025-10-18 09:30:00'),
('b1000001-0000-0000-0000-000000000008', 'p5000001-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2025-11-08', '2025-11-11', 630.00, 'confirmed', '2025-10-20 15:00:00'),
('b1000001-0000-0000-0000-000000000009', 'p3000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', '2025-12-15', '2025-12-20', 2250.00, 'confirmed', '2025-10-22 11:45:00'),
('b1000001-0000-0000-0000-000000000010', 'p1000001-0000-0000-0000-000000000004', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2025-11-05', '2025-11-07', 170.00, 'confirmed', '2025-10-24 14:15:00'),
('b1000001-0000-0000-0000-000000000011', 'p6000001-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2025-11-12', '2025-11-14', 190.00, 'confirmed', '2025-10-25 10:30:00'),
('b1000001-0000-0000-0000-000000000012', 'p4000001-0000-0000-0000-000000000003', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2025-12-05', '2025-12-08', 960.00, 'confirmed', '2025-10-26 12:00:00'),
('b1000001-0000-0000-0000-000000000013', 'p2000001-0000-0000-0000-000000000003', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2025-11-18', '2025-11-21', 660.00, 'confirmed', '2025-10-27 09:15:00'),
('b1000001-0000-0000-0000-000000000014', 'p5000001-0000-0000-0000-000000000002', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2025-12-22', '2025-12-26', 780.00, 'confirmed', '2025-10-28 15:45:00'),
('b1000001-0000-0000-0000-000000000015', 'p3000001-0000-0000-0000-000000000003', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2025-11-28', '2025-12-01', 570.00, 'confirmed', '2025-10-29 11:00:00'),

-- Pending bookings (10)
('b2000001-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000005', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', '2025-12-28', '2025-12-31', 1500.00, 'pending', '2025-10-30 10:00:00'),
('b2000001-0000-0000-0000-000000000002', 'p4000001-0000-0000-0000-000000000002', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2026-01-05', '2026-01-08', 465.00, 'pending', '2025-10-31 13:30:00'),
('b2000001-0000-0000-0000-000000000003', 'p6000001-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2026-01-10', '2026-01-13', 480.00, 'pending', '2025-11-01 09:45:00'),
('b2000001-0000-0000-0000-000000000004', 'p2000001-0000-0000-0000-000000000004', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2026-01-15', '2026-01-18', 420.00, 'pending', '2025-11-02 14:20:00'),
('b2000001-0000-0000-0000-000000000005', 'p3000001-0000-0000-0000-000000000004', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2026-01-20', '2026-01-23', 495.00, 'pending', '2025-11-03 11:00:00'),
('b2000001-0000-0000-0000-000000000006', 'p5000001-0000-0000-0000-000000000003', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2026-01-25', '2026-01-27', 220.00, 'pending', '2025-11-04 15:30:00'),
('b2000001-0000-0000-0000-000000000007', 'p4000001-0000-0000-0000-000000000004', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2026-02-01', '2026-02-03', 150.00, 'pending', '2025-11-05 10:15:00'),
('b2000001-0000-0000-0000-000000000008', 'p6000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', '2026-02-10', '2026-02-14', 580.00, 'pending', '2025-11-06 12:45:00'),
('b2000001-0000-0000-0000-000000000009', 'p5000001-0000-0000-0000-000000000004', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2026-02-15', '2026-02-18', 825.00, 'pending', '2025-11-07 09:00:00'),
('b2000001-0000-0000-0000-000000000010', 'p6000001-0000-0000-0000-000000000004', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2026-02-20', '2026-02-24', 740.00, 'pending', '2025-11-08 14:00:00'),

-- Canceled bookings (10)
('b3000001-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000001', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2025-10-15', '2025-10-18', 450.00, 'canceled', '2025-09-01 10:00:00'),
('b3000001-0000-0000-0000-000000000002', 'p2000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2025-10-20', '2025-10-22', 400.00, 'canceled', '2025-09-05 11:30:00'),
('b3000001-0000-0000-0000-000000000003', 'p3000001-0000-0000-0000-000000000001', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2025-10-25', '2025-10-28', 840.00, 'canceled', '2025-09-10 13:00:00'),
('b3000001-0000-0000-0000-000000000004', 'p1000001-0000-0000-0000-000000000003', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '2025-11-01', '2025-11-03', 240.00, 'canceled', '2025-09-15 14:45:00'),
('b3000001-0000-0000-0000-000000000005', 'p4000001-0000-0000-0000-000000000001', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', '2025-11-05', '2025-11-07', 350.00, 'canceled', '2025-09-20 09:20:00'),
('b3000001-0000-0000-0000-000000000006', 'p2000001-0000-0000-0000-000000000002', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2025-11-10', '2025-11-13', 540.00, 'canceled', '2025-09-25 15:00:00'),
('b3000001-0000-0000-0000-000000000007', 'p5000001-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2025-11-15', '2025-11-18', 630.00, 'canceled', '2025-09-28 10:30:00'),
('b3000001-0000-0000-0000-000000000008', 'p3000001-0000-0000-0000-000000000003', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2025-11-20', '2025-11-22', 380.00, 'canceled', '2025-09-30 12:00:00'),
('b3000001-0000-0000-0000-000000000009', 'p4000001-0000-0000-0000-000000000003', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2025-12-01', '2025-12-04', 960.00, 'canceled', '2025-10-02 13:45:00'),
('b3000001-0000-0000-0000-000000000010', 'p6000001-0000-0000-0000-000000000001', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2025-12-05', '2025-12-07', 190.00, 'canceled', '2025-10-04 11:15:00');

-- =============================================
-- 4. INSERT PAYMENTS (30 payments - for confirmed + some pending bookings)
-- =============================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('pay00001-0000-0000-0000-000000000001', 'b1000001-0000-0000-0000-000000000001', 450.00, '2025-10-01 09:15:00', 'credit_card'),
('pay00001-0000-0000-0000-000000000002', 'b1000001-0000-0000-0000-000000000002', 2450.00, '2025-10-05 14:45:00', 'stripe'),
('pay00001-0000-0000-0000-000000000003', 'b1000001-0000-0000-0000-000000000003', 400.00, '2025-10-08 11:30:00', 'paypal'),
('pay00001-0000-0000-0000-000000000004', 'b1000001-0000-0000-0000-000000000004', 840.00, '2025-10-10 17:00:00', 'credit_card'),
('pay00001-0000-0000-0000-000000000005', 'b1000001-0000-0000-0000-000000000005', 480.00, '2025-10-12 10:15:00', 'stripe'),
('pay00001-0000-0000-0000-000000000006', 'b1000001-0000-0000-0000-000000000006', 525.00, '2025-10-15 13:35:00', 'paypal'),
('pay00001-0000-0000-0000-000000000007', 'b1000001-0000-0000-0000-000000000007', 540.00, '2025-10-18 09:45:00', 'credit_card'),
('pay00001-0000-0000-0000-000000000008', 'b1000001-0000-0000-0000-000000000008', 630.00, '2025-10-20 15:15:00', 'stripe'),
('pay00001-0000-0000-0000-000000000009', 'b1000001-0000-0000-0000-000000000009', 2250.00, '2025-10-22 12:00:00', 'credit_card'),
('pay00001-0000-0000-0000-000000000010', 'b1000001-0000-0000-0000-000000000010', 170.00, '2025-10-24 14:30:00', 'paypal'),
('pay00001-0000-0000-0000-000000000011', 'b1000001-0000-0000-0000-000000000011', 190.00, '2025-10-25 10:45:00', 'stripe'),
('pay00001-0000-0000-0000-000000000012', 'b1000001-0000-0000-0000-000000000012', 960.00, '2025-10-26 12:15:00', 'credit_card'),
('pay00001-0000-0000-0000-000000000013', 'b1000001-0000-0000-0000-000000000013', 660.00, '2025-10-27 09:30:00', 'paypal'),
('pay00001-0000-0000-0000-000000000014', 'b1000001-0000-0000-0000-000000000014', 780.00, '2025-10-28 16:00:00', 'stripe'),
('pay00001-0000-0000-0000-000000000015', 'b1000001-0000-0000-0000-000000000015', 570.00, '2025-10-29 11:15:00', 'credit_card'),

-- Payments for some pending bookings (partial payments/deposits)
('pay00002-0000-0000-0000-000000000001', 'b2000001-0000-0000-0000-000000000001', 750.00, '2025-10-30 10:15:00', 'credit_card'),
('pay00002-0000-0000-0000-000000000002', 'b2000001-0000-0000-0000-000000000002', 232.50, '2025-10-31 13:45:00', 'paypal'),
('pay00002-0000-0000-0000-000000000003', 'b2000001-0000-0000-0000-000000000003', 240.00, '2025-11-01 10:00:00', 'stripe'),
('pay00002-0000-0000-0000-000000000004', 'b2000001-0000-0000-0000-000000000004', 210.00, '2025-11-02 14:35:00', 'credit_card'),
('pay00002-0000-0000-0000-000000000005', 'b2000001-0000-0000-0000-000000000005', 247.50, '2025-11-03 11:15:00', 'paypal'),

-- Refund payments for canceled bookings (negative amounts or reduced amounts)
('pay00003-0000-0000-0000-000000000001', 'b3000001-0000-0000-0000-000000000001', 405.00, '2025-09-01 10:15:00', 'credit_card'),
('pay00003-0000-0000-0000-000000000002', 'b3000001-0000-0000-0000-000000000002', 360.00, '2025-09-05 11:45:00', 'paypal'),
('pay00003-0000-0000-0000-000000000003', 'b3000001-0000-0000-0000-000000000003', 756.00, '2025-09-10 13:15:00', 'stripe'),
('pay00003-0000-0000-0000-000000000004', 'b3000001-0000-0000-0000-000000000004', 216.00, '2025-09-15 15:00:00', 'credit_card'),
('pay00003-0000-0000-0000-000000000005', 'b3000001-0000-0000-0000-000000000005', 315.00, '2025-09-20 09:35:00', 'paypal'),
('pay00003-0000-0000-0000-000000000006', 'b3000001-0000-0000-0000-000000000006', 486.00, '2025-09-25 15:15:00', 'stripe'),
('pay00003-0000-0000-0000-000000000007', 'b3000001-0000-0000-0000-000000000007', 567.00, '2025-09-28 10:45:00', 'credit_card'),
('pay00003-0000-0000-0000-000000000008', 'b3000001-0000-0000-0000-000000000008', 342.00, '2025-09-30 12:15:00', 'paypal'),
('pay00003-0000-0000-0000-000000000009', 'b3000001-0000-0000-0000-000000000009', 864.00, '2025-10-02 14:00:00', 'stripe'),
('pay00003-0000-0000-0000-000000000010', 'b3000001-0000-0000-0000-000000000010', 171.00, '2025-10-04 11:30:00', 'credit_card');

-- =============================================
-- 5. INSERT REVIEWS (45 reviews with varied ratings)
-- =============================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- 5-star reviews (15)
('rev00001-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 5, 'Absolutely perfect! The loft exceeded all expectations. Great location and stunning views.', '2025-11-19 10:00:00'),
('rev00001-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 5, 'Dream beach house! Waking up to ocean views was magical. Host was very responsive.', '2025-12-28 14:30:00'),
('rev00001-0000-0000-0000-000000000003', 'p2000001-0000-0000-0000-000000000001', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 5, 'Beautiful Victorian home with modern amenities. Felt like stepping back in time. Highly recommend!', '2025-11-13 11:15:00'),
('rev00001-0000-0000-0000-000000000004', 'p3000001-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 5, 'Wine country paradise! The guest house was charming and the wine tasting was excellent.', '2025-11-29 16:45:00'),
('rev00001-0000-0000-0000-000000000005', 'p3000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 5, 'Perfect ski vacation! True ski-in/ski-out access. Hot tub was amazing after a day on the slopes.', '2025-12-21 09:30:00'),
('rev00001-0000-0000-0000-000000000006', 'p4000001-0000-0000-0000-000000000003', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 5, 'Luxury golf getaway! Villa was stunning and the golf course was championship quality.', '2025-12-09 13:20:00'),
('rev00001-0000-0000-0000-000000000007', 'p5000001-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 5, 'Best harbor views in San Diego! Walking distance to everything. Would stay again in a heartbeat.', '2025-11-12 15:00:00'),
('rev00001-0000-0000-0000-000000000008', 'p5000001-0000-0000-0000-000000000002', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 5, 'Elegant brownstone in perfect neighborhood. Felt very safe and comfortable. Top-notch property!', '2025-12-27 11:45:00'),
('rev00001-0000-0000-0000-000000000009', 'p1000001-0000-0000-0000-000000000003', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 5, 'Mountain cabin was exactly what we needed for a relaxing getaway. So peaceful!', '2025-12-06 14:15:00'),
('rev00001-0000-0000-0000-000000000010', 'p2000001-0000-0000-0000-000000000002', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 5, 'Lakeside cottage was perfect for our fishing trip. Kayaks were a great bonus!', '2025-12-14 10:30:00'),
('rev00001-0000-0000-0000-000000000011', 'p4000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 5, 'Family farmhouse was amazing! Kids loved the space to run around. Very family-friendly.', '2025-11-24 12:00:00'),
('rev00001-0000-0000-0000-000000000012', 'p2000001-0000-0000-0000-000000000003', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 5, 'Desert oasis was spectacular! Pool area was perfect for entertaining. Loved it!', '2025-11-22 09:15:00'),
('rev00001-0000-0000-0000-000000000013', 'p3000001-0000-0000-0000-000000000003', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 5, 'Tropical bungalow exceeded expectations! Private and peaceful. Beach was amazing.', '2025-12-02 15:45:00'),
('rev00001-0000-0000-0000-000000000014', 'p6000001-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 5, 'Charming B&B with wonderful hosts. Breakfast was delicious! Perfect countryside retreat.', '2025-11-15 11:00:00'),
('rev00001-0000-0000-0000-000000000015', 'p5000001-0000-0000-0000-000000000004', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 5, 'Penthouse with rooftop was incredible! Skyline views were breathtaking. Worth every penny.', '2026-02-19 16:30:00'),

-- 4-star reviews (15)
('rev00002-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000004', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 4, 'Great studio in trendy area. Only complaint is it was a bit small for two people.', '2025-11-08 09:45:00'),
('rev00002-0000-0000-0000-000000000002', 'p2000001-0000-0000-0000-000000000004', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 4, 'Nice condo with good location. A bit noisy from street traffic but otherwise great.', '2026-01-19 13:20:00'),
('rev00002-0000-0000-0000-000000000003', 'p3000001-0000-0000-0000-000000000004', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 4, 'Artist loft had great character. WiFi was a bit slow but space was wonderful.', '2026-01-24 10:15:00'),
('rev00002-0000-0000-0000-000000000004', 'p4000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 4, 'Riverside retreat was lovely and peaceful. Could use some furniture updates.', '2026-02-15 14:30:00'),
('rev00002-0000-0000-0000-000000000005', 'p4000001-0000-0000-0000-000000000004', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 4, 'Tiny home was cute and functional. Perfect for one person but cozy for two.', '2026-02-04 11:00:00'),
('rev00002-0000-0000-0000-000000000006', 'p5000001-0000-0000-0000-000000000003', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 4, 'Garden studio was nice and quiet. Garden was beautiful. Bathroom could be updated.', '2026-01-28 15:45:00'),
('rev00002-0000-0000-0000-000000000007', 'p6000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 4, 'Modern townhouse in good neighborhood. Kitchen was well-equipped. Minor cleanliness issues.', '2026-02-15 12:30:00'),
('rev00002-0000-0000-0000-000000000008', 'p6000001-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 4, 'Beach condo was nice with good amenities. Pool was great but unit needed repairs.', '2026-01-14 09:00:00'),
('rev00002-0000-0000-0000-000000000009', 'p6000001-0000-0000-0000-000000000004', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 4, 'Mountain lodge with beautiful views. Hot tub was wonderful. A bit far from town.', '2026-02-25 14:00:00'),
('rev00002-0000-0000-0000-000000000010', 'p1000001-0000-0000-0000-000000000005', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 4, 'Luxury penthouse was impressive. Great amenities but pricey for what you get.', '2026-01-02 10:30:00'),
('rev00002-0000-0000-0000-000000000011', 'p1000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 4, 'Downtown loft was convenient and modern. Street noise was noticeable at night.', '2025-10-19 11:20:00'),
('rev00002-0000-0000-0000-000000000012', 'p2000001-0000-0000-0000-000000000001', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 4, 'Victorian home was charming with historical character. Some modern updates needed.', '2025-10-23 13:45:00'),
('rev00002-0000-0000-0000-000000000013', 'p3000001-0000-0000-0000-000000000001', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 4, 'Vineyard guest house was delightful. Wine tasting was excellent. A bit isolated.', '2025-10-29 15:00:00'),
('rev00002-0000-0000-0000-000000000014', 'p4000001-0000-0000-0000-000000000001', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 4, 'Farmhouse was spacious and family-friendly. Great for kids. WiFi was weak.', '2025-10-08 09:30:00'),
('rev00002-0000-0000-0000-000000000015', 'p5000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 4, 'Harborside apartment had great views. Location was perfect. Parking was challenging.', '2025-11-16 12:00:00'),

-- 3-star reviews (10)
('rev00003-0000-0000-0000-000000000001', 'p1000001-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 3, 'Mountain cabin was okay. Beautiful location but cabin needs maintenance and updates.', '2025-11-04 10:45:00'),
('rev00003-0000-0000-0000-000000000002', 'p2000001-0000-0000-0000-000000000002', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 3, 'Lakeside cottage was decent but showing its age. Kayaks were in poor condition.', '2025-11-14 14:20:00'),
('rev00003-0000-0000-0000-000000000003', 'p1000001-0000-0000-0000-000000000004', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 3, 'Studio was functional but nothing special. Good location but small and dated.', '2025-09-02 11:30:00'),
('rev00003-0000-0000-0000-000000000004', 'p2000001-0000-0000-0000-000000000004', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 3, 'Condo was average. Walking distance to attractions but unit needed deep cleaning.', '2025-09-06 13:00:00'),
('rev00003-0000-0000-0000-000000000005', 'p3000001-0000-0000-0000-000000000003', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 3, 'Tropical bungalow was nice but not as private as advertised. Neighbors were very close.', '2025-11-23 15:30:00'),
('rev00003-0000-0000-0000-000000000006', 'p4000001-0000-0000-0000-000000000003', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 3, 'Golf villa was nice but overpriced. Expected more for the cost. Location was good.', '2025-12-05 09:45:00'),
('rev00003-0000-0000-0000-000000000007', 'p5000001-0000-0000-0000-000000000002', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 3, 'Brownstone had character but several maintenance issues. Host was slow to respond.', '2025-09-26 12:15:00'),
('rev00003-0000-0000-0000-000000000008', 'p2000001-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 3, 'Desert villa had nice pool but property was not as clean as expected. Disappointing.', '2025-09-11 14:30:00'),
('rev00003-0000-0000-0000-000000000009', 'p3000001-0000-0000-0000-000000000004', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 3, 'Artist loft was interesting but uncomfortable bed and poor heating. Not great value.', '2025-09-21 10:00:00'),
('rev00003-0000-0000-0000-000000000010', 'p6000001-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 3, 'B&B room was quaint but outdated. Breakfast was good but room needs renovation.', '2025-12-08 11:45:00'),

-- 2-star reviews (3)
('rev00004-0000-0000-0000-000000000001', 'p4000001-0000-0000-0000-000000000002', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 2, 'Riverside retreat was disappointing. Many advertised amenities were unavailable. Not recommended.', '2025-09-16 15:20:00'),
('rev00004-0000-0000-0000-000000000002', 'p5000001-0000-0000-0000-000000000003', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 2, 'Garden studio had cleanliness issues and broken fixtures. Garden was overgrown.', '2025-10-01 09:30:00'),
('rev00004-0000-0000-0000-000000000003', 'p4000001-0000-0000-0000-000000000004', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 2, 'Tiny home was cramped and uncomfortable. Not suitable for two people despite listing.', '2025-10-03 13:00:00'),

-- 1-star reviews (2)
('rev00005-0000-0000-0000-000000000001', 'p6000001-0000-0000-0000-000000000002', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 1, 'Modern townhouse was dirty and had pest problem. Host was unresponsive. Very disappointed.', '2025-09-29 16:00:00'),
('rev00005-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000002', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 1, 'Beach house photos were misleading. Property was in poor condition. Would not recommend to anyone.', '2025-10-05 10:15:00');

-- =============================================
-- 6. INSERT MESSAGES (55 messages between users)
-- =============================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Booking inquiries from guests to hosts
('msg00001-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hi! Is your downtown loft available for Nov 15-18? I am interested in booking.', '2025-09-25 10:00:00'),
('msg00001-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Yes, its available! Feel free to book. Let me know if you have any questions.', '2025-09-25 14:30:00'),
('msg00001-0000-0000-0000-000000000003', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hello! Does the beach house have parking? We will have 2 cars.', '2025-09-30 11:15:00'),
('msg00001-0000-0000-0000-000000000004', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Yes, there is parking for 2 vehicles. The driveway is spacious.', '2025-09-30 16:45:00'),
('msg00001-0000-0000-0000-000000000005', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Is your Victorian home pet-friendly? We have a small dog.', '2025-10-01 09:30:00'),
('msg00001-0000-0000-0000-000000000006', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Unfortunately, we dont allow pets. Sorry about that!', '2025-10-01 13:20:00'),
('msg00001-0000-0000-0000-000000000007', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'What time is check-in for the vineyard guest house?', '2025-10-03 10:00:00'),
('msg00001-0000-0000-0000-000000000008', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Check-in is 3 PM. I can accommodate early check-in if property is ready.', '2025-10-03 15:45:00'),
('msg00001-0000-0000-0000-000000000009', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Does the mountain cabin have WiFi? I need to work remotely.', '2025-10-05 11:00:00'),
('msg00001-0000-0000-0000-000000000010', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Yes, there is high-speed WiFi. Perfect for remote work!', '2025-10-05 14:30:00'),

-- Check-in instructions and coordination
('msg00002-0000-0000-0000-000000000001', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Hi Ian! Your check-in is tomorrow. The lockbox code is 1234. Key is by the front door.', '2025-11-14 16:00:00'),
('msg00002-0000-0000-0000-000000000002', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Thank you! What time can we check in?', '2025-11-14 16:30:00'),
('msg00002-0000-0000-0000-000000000003', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Anytime after 3 PM works. Enjoy your stay!', '2025-11-14 17:00:00'),
('msg00002-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Check-in is at 3 PM. Ill meet you at the property to show you around!', '2025-11-09 10:00:00'),
('msg00002-0000-0000-0000-000000000005', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Perfect! See you at 3 PM. Looking forward to it!', '2025-11-09 14:20:00'),

// During stay - questions and support
('msg00003-0000-0000-0000-000000000001', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'The WiFi password isnt working. Can you help?', '2025-12-21 09:00:00'),
('msg00003-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Sorry about that! The password is BeachHouse2025. Let me know if you need anything else.', '2025-12-21 09:30:00'),
('msg00003-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'The heater isnt working. Its quite cold in here.', '2025-11-26 19:00:00'),
('msg00003-0000-0000-0000-000000000004', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Im so sorry! Ill have maintenance come first thing tomorrow morning.', '2025-11-26 19:30:00'),
('msg00003-0000-0000-0000-000000000005', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Where can we find extra towels?', '2025-12-02 11:00:00'),
('msg00003-0000-0000-0000-000000000006', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Extra towels are in the hallway closet on the second shelf!', '2025-12-02 11:15:00'),

-- Post-stay thank you messages
('msg00004-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Thank you for a wonderful stay! The loft was perfect for my business trip.', '2025-11-19 10:30:00'),
('msg00004-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'So glad you enjoyed it! Thanks for being a great guest. Come back anytime!', '2025-11-19 15:00:00'),
('msg00004-0000-0000-0000-000000000003', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Thanks for your hospitality! The Victorian home was beautiful.', '2025-11-13 12:00:00'),
('msg00004-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Thank you for the kind words! Hope to host you again soon.', '2025-11-13 16:30:00'),

-- Cancellation communications
('msg00005-0000-0000-0000-000000000001', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Unfortunately I need to cancel my booking. Family emergency came up.', '2025-09-01 08:00:00'),
('msg00005-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Im so sorry to hear that. I understand completely. Canceling now with full refund.', '2025-09-01 09:30:00'),
('msg00005-0000-0000-0000-000000000003', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Need to cancel my reservation due to work conflict. Sorry for inconvenience.', '2025-09-05 10:00:00'),
('msg00005-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'No problem! Ill process the cancellation. Hope you can visit another time.', '2025-09-05 11:00:00'),

-- Special requests
('msg00006-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Can we arrange early check-in? Our flight arrives at 10 AM.', '2025-11-15 14:00:00'),
('msg00006-0000-0000-0000-000000000002', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'Yes, early check-in at 11 AM should work! Ill confirm closer to date.', '2025-11-15 16:30:00'),
('msg00006-0000-0000-0000-000000000003', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Is late checkout possible? Our flight is at 6 PM.', '2025-12-05 09:00:00'),
('msg00006-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'Late checkout until 2 PM is fine. Have a safe flight!', '2025-12-05 10:30:00'),

-- Property questions
('msg00007-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Is the harborside apartment walking distance to restaurants?', '2025-10-15 11:00:00'),
('msg00007-0000-0000-0000-000000000002', '10eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Yes! Dozens of restaurants within 5-minute walk. Great dining scene!', '2025-10-15 14:20:00'),
('msg00007-0000-0000-0000-000000000003', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'How far is the ski chalet from the main lift?', '2025-10-18 10:30:00'),
('msg00007-0000-0000-0000-000000000004', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '13eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Its truly ski-in/ski-out! Youre 100 feet from the lift. Cant get closer!', '2025-10-18 15:00:00'),
('msg00007-0000-0000-0000-000000000005', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Does the golf villa have a full kitchen?', '2025-10-20 09:00:00'),
('msg00007-0000-0000-0000-000000000006', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', '14eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Yes! Fully equipped gourmet kitchen with all appliances and cookware.', '2025-10-20 12:30:00'),

-- Guest to guest recommendations (previous guests)
('msg00008-0000-0000-0000-000000000001', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Hey! I saw you booked the mountain cabin. I stayed there last month - its amazing!', '2025-10-28 11:00:00'),
('msg00008-0000-0000-0000-000000000002', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Thanks for the tip! Any restaurant recommendations nearby?', '2025-10-28 14:30:00'),
('msg00008-0000-0000-0000-000000000003', '15eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '16eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Yes! The Summit Restaurant is 10 minutes away. Amazing steaks!', '2025-10-28 16:00:00'),

-- Admin to Host communications
('msg00009-0000-0000-0000-000000000001', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hi Charlie, please update your property photos for the beach house. Thanks!', '2025-10-10 09:00:00'),
('msg00009-0000-0000-0000-000000000002', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Will do! Ill have new photos uploaded by end of week.', '2025-10-10 14:00:00'),
('msg00009-0000-0000-0000-000000000003', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Diana, we received a complaint about cleanliness at the lakeside cottage. Please address.', '2025-10-15 10:30:00'),
('msg00009-0000-0000-0000-000000000004', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Im very sorry about that. Ive switched to a new cleaning service. Wont happen again.', '2025-10-15 15:00:00'),

-- Admin to Guest support
('msg00010-0000-0000-0000-000000000001', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'I had a terrible experience at a property. How do I file a complaint?', '2025-09-29 10:00:00'),
('msg00010-0000-0000-0000-000000000002', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '17eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'Im sorry to hear that! Please provide details and well investigate immediately.', '2025-09-29 11:30:00'),
('msg00010-0000-0000-0000-000000000003', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'I didnt receive my refund yet. Its been 2 weeks since cancellation.', '2025-10-05 14:00:00'),
('msg00010-0000-0000-0000-000000000004', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '18eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'Let me check on that for you. Refunds usually take 5-7 business days. Ill escalate this.', '2025-10-05 15:30:00'),

-- More guest-host interactions
('msg00011-0000-0000-0000-000000000001', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'The tropical bungalow was fantastic! Thank you for a memorable stay.', '2025-12-02 16:00:00'),
('msg00011-0000-0000-0000-000000000002', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '12eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Wonderful to hear! You were a fantastic guest. Hope to see you again!', '2025-12-02 18:30:00');

-- =============================================
-- END OF SEED DATA
-- =============================================

-- Verify record counts
SELECT 'Users' AS table_name, COUNT(*) AS record_count FROM "User"
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL
SELECT 'Messages', COUNT(*) FROM Message;

