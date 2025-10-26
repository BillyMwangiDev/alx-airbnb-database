# Database Seeding - Sample Data
## AirBnB Clone Database

---

## Overview

This directory contains SQL scripts to populate the AirBnB Clone database with realistic sample data for testing and development purposes.

---

## Files

### `seed.sql`
Complete INSERT statements for all 6 database tables with realistic, interconnected sample data.

---

## Sample Data Summary

| Table | Record Count | Description |
|-------|--------------|-------------|
| **User** | 15 | 2 admins, 6 hosts, 7 guests |
| **Property** | 25 | Various property types across different locations |
| **Booking** | 35 | 15 confirmed, 10 pending, 10 canceled |
| **Payment** | 30 | Various payment methods and scenarios |
| **Review** | 45 | Ratings from 1-5 stars with comments |
| **Message** | 55 | Communication between users, hosts, and admins |

**Total Records:** 205

---

## Data Characteristics

### Users (15 total)

**Admins (2):**
- Alice Admin (alice.admin@airbnb.com)
- Bob Manager (bob.manager@airbnb.com)

**Hosts (6):**
- Charlie Host - 5 properties
- Diana Property - 4 properties
- Edward Rentals - 4 properties
- Fiona Homes - 4 properties
- George Estates - 4 properties
- Hannah Lodging - 4 properties

**Guests (7):**
- Ian Guest
- Julia Traveler
- Kevin Explorer
- Laura Wanderer
- Michael Nomad
- Nina Voyager
- Oscar Tourist

### Properties (25 total)

**Property Types:**
- Urban apartments and lofts
- Beachfront houses and condos
- Mountain cabins and chalets
- Luxury penthouses and villas
- Historic homes and B&Bs
- Countryside retreats

**Locations:**
- New York, Miami, Denver, Portland, San Francisco
- Boston, Austin, Phoenix, Chicago, Napa Valley
- Seattle, Nashville, Scottsdale, San Diego, Philadelphia
- And more...

**Price Range:**
- Budget: $75 - $120/night
- Mid-range: $140 - $220/night
- Luxury: $280 - $500/night

### Bookings (35 total)

**Status Distribution:**
- Confirmed: 15 bookings (43%)
- Pending: 10 bookings (29%)
- Canceled: 10 bookings (28%)

**Date Range:**
- Past bookings: October 2025
- Upcoming bookings: November 2025 - February 2026

### Payments (30 total)

**Payment Methods:**
- Credit Card: ~40%
- Stripe: ~30%
- PayPal: ~30%

**Payment Scenarios:**
- Full payments for confirmed bookings
- Deposit/partial payments for pending bookings
- Refund payments (reduced amounts) for cancellations

### Reviews (45 total)

**Rating Distribution:**
- 5 stars: 15 reviews (33%) - Excellent
- 4 stars: 15 reviews (33%) - Good
- 3 stars: 10 reviews (22%) - Average
- 2 stars: 3 reviews (7%) - Poor
- 1 star: 2 reviews (4%) - Terrible

**Average Rating:** ~3.8 stars

### Messages (55 total)

**Message Types:**
- Booking inquiries (10)
- Check-in coordination (5)
- During-stay support (6)
- Post-stay thank you (4)
- Cancellation communications (4)
- Special requests (6)
- Property questions (6)
- Guest recommendations (3)
- Admin communications (6)
- Support requests (4)
- General correspondence (1)

---

## Usage Instructions

### Prerequisites

1. Database must be created
2. Schema must be applied (run `database-script-0x01/schema.sql` first)
3. Database user must have INSERT permissions

### PostgreSQL

```bash
# Method 1: Using psql command line
psql -U your_username -d airbnb_clone -f seed.sql

# Method 2: Using psql interactive mode
psql -U your_username -d airbnb_clone
\i seed.sql

# Method 3: From within psql
psql -U your_username -d airbnb_clone
airbnb_clone=# \i /path/to/database-script-0x02/seed.sql
```

### MySQL

```bash
# Method 1: Using mysql command line
mysql -u your_username -p airbnb_clone < seed.sql

# Method 2: Using mysql interactive mode
mysql -u your_username -p airbnb_clone
source seed.sql;

# Method 3: Direct execution
mysql -u your_username -p
mysql> USE airbnb_clone;
mysql> source /path/to/database-script-0x02/seed.sql;
```

### Verification

After running the seed script, verify the data was inserted correctly:

```sql
-- Check record counts for all tables
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
```

**Expected Output:**
```
table_name   | record_count
-------------|-------------
Users        | 15
Properties   | 25
Bookings     | 35
Payments     | 30
Reviews      | 45
Messages     | 55
```

---

## Referential Integrity

The seed data maintains proper referential integrity:

1. **All foreign keys reference valid primary keys:**
   - Property.host_id → User.user_id
   - Booking.property_id → Property.property_id
   - Booking.user_id → User.user_id
   - Payment.booking_id → Booking.booking_id
   - Review.property_id → Property.property_id
   - Review.user_id → User.user_id
   - Message.sender_id → User.user_id
   - Message.recipient_id → User.user_id

2. **No orphaned records**
3. **All ENUM values are valid**
4. **All timestamps are realistic and chronological**

---

## Data Reset

To clear all sample data and start fresh:

```sql
-- Delete all data (respects foreign key constraints by order)
DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM "User";

-- Verify deletion
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
```

All counts should return 0.

---

## Sample Queries

### Find all 5-star properties
```sql
SELECT 
    p.name,
    p.location,
    p.pricepernight,
    AVG(r.rating) as avg_rating,
    COUNT(r.review_id) as review_count
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location, p.pricepernight
HAVING AVG(r.rating) = 5
ORDER BY review_count DESC;
```

### Find upcoming bookings by status
```sql
SELECT 
    b.booking_id,
    u.first_name || ' ' || u.last_name as guest_name,
    p.name as property_name,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date >= CURRENT_DATE
ORDER BY b.start_date;
```

### Host revenue summary
```sql
SELECT 
    u.first_name || ' ' || u.last_name as host_name,
    COUNT(DISTINCT p.property_id) as property_count,
    COUNT(b.booking_id) as total_bookings,
    SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) as confirmed_revenue,
    SUM(CASE WHEN b.status = 'pending' THEN b.total_price ELSE 0 END) as pending_revenue
FROM "User" u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE u.role = 'host'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY confirmed_revenue DESC;
```

### Message activity by user
```sql
SELECT 
    u.first_name || ' ' || u.last_name as user_name,
    u.role,
    COUNT(DISTINCT m_sent.message_id) as messages_sent,
    COUNT(DISTINCT m_received.message_id) as messages_received,
    COUNT(DISTINCT m_sent.message_id) + COUNT(DISTINCT m_received.message_id) as total_messages
FROM "User" u
LEFT JOIN Message m_sent ON u.user_id = m_sent.sender_id
LEFT JOIN Message m_received ON u.user_id = m_received.recipient_id
GROUP BY u.user_id, u.first_name, u.last_name, u.role
HAVING COUNT(DISTINCT m_sent.message_id) + COUNT(DISTINCT m_received.message_id) > 0
ORDER BY total_messages DESC;
```

### Property availability for date range
```sql
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight
FROM Property p
WHERE NOT EXISTS (
    SELECT 1 
    FROM Booking b
    WHERE b.property_id = p.property_id
    AND b.status IN ('confirmed', 'pending')
    AND (
        ('2025-12-20' BETWEEN b.start_date AND b.end_date)
        OR ('2025-12-25' BETWEEN b.start_date AND b.end_date)
        OR (b.start_date BETWEEN '2025-12-20' AND '2025-12-25')
    )
)
ORDER BY p.pricepernight;
```

---

## Testing Scenarios

The seed data supports testing of:

### User Management
- ✅ Different user roles (guest, host, admin)
- ✅ User authentication (email/password)
- ✅ Profile management

### Property Management
- ✅ Property listings by host
- ✅ Property search and filtering
- ✅ Property availability checking
- ✅ Price variations

### Booking System
- ✅ Booking creation and management
- ✅ Status transitions (pending → confirmed → canceled)
- ✅ Date range validation
- ✅ Double booking prevention

### Payment Processing
- ✅ Multiple payment methods
- ✅ Full and partial payments
- ✅ Refund processing
- ✅ Payment history tracking

### Review System
- ✅ Rating distribution (1-5 stars)
- ✅ Review comments
- ✅ Average rating calculations
- ✅ Review sorting and filtering

### Messaging System
- ✅ User-to-user communication
- ✅ Host-guest interaction
- ✅ Admin support messages
- ✅ Message threading

---

## Notes

### Password Hashing
All users have the same password hash: `$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYhKCNK1qqm`

**This is a bcrypt hash of:** `password123`

⚠️ **For development/testing only!** Never use in production.

### UUID Format
All UUIDs follow a consistent pattern for easy identification:
- Users: Start with role prefix (a0=admin, c2-11=hosts, 12-18=guests)
- Properties: Start with p + host number
- Bookings: Start with b + status prefix
- Payments: Start with pay
- Reviews: Start with rev + rating group
- Messages: Start with msg + category

### Timestamps
All timestamps are realistic and chronological:
- User accounts created: Jan 2023 - Jul 2023
- Properties listed: Feb 2023 - Jun 2023
- Bookings: Sep 2025 - Feb 2026
- Reviews: Match booking completion dates
- Messages: Context-appropriate timing

---

## Troubleshooting

### Error: Duplicate key value
**Cause:** Data already exists in the database

**Solution:** Clear existing data first or comment out DELETE statements in seed.sql

### Error: Foreign key constraint violation
**Cause:** Parent records don't exist or schema not applied

**Solution:** 
1. Ensure schema.sql has been run first
2. Verify tables exist: `\dt` (PostgreSQL) or `SHOW TABLES;` (MySQL)
3. Check foreign key constraints are enabled

### Error: Invalid input value for enum
**Cause:** Database is case-sensitive for ENUM values

**Solution:** Ensure ENUM values match exactly:
- User.role: `guest`, `host`, `admin`
- Booking.status: `pending`, `confirmed`, `canceled`
- Payment.payment_method: `credit_card`, `paypal`, `stripe`

### Error: Date format invalid
**Cause:** Database expects different date format

**Solution:** Seed script uses ISO format (YYYY-MM-DD) which is standard. Check database locale settings.

---

## Customization

To modify the seed data:

1. **Change UUIDs:** Update consistently across related tables
2. **Add more records:** Follow existing patterns and maintain referential integrity
3. **Modify data:** Keep realistic values and chronological timestamps
4. **Remove records:** Delete in reverse order (Message → Review → Payment → Booking → Property → User)

---

## Support

For issues or questions:
1. Verify schema is applied correctly
2. Check database user permissions
3. Review error messages for constraint violations
4. Ensure database version compatibility (PostgreSQL 13+ or MySQL 8+)

---

**Document Version:** 1.0  
**Last Updated:** October 26, 2025  
**Status:** Ready for Use  
**Compatible With:** PostgreSQL 13+, MySQL 8+

