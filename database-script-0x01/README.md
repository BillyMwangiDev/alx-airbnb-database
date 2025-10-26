# Database Schema (DDL Scripts)
## AirBnB Clone - SQL Table Definitions

---

## 📖 Overview

This directory contains the **SQL Data Definition Language (DDL)** scripts to create the complete database schema for the AirBnB Clone application. The schema includes all tables, constraints, indexes, and relationships necessary for a production-ready rental platform.

---

## 📁 Files

### `schema.sql`
Complete SQL script containing:
- CREATE TABLE statements for all 6 entities
- Primary key, foreign key, and check constraints
- ENUM type definitions
- Index creation for performance optimization
- Trigger for automatic timestamp updates
- Verification queries

---

## 🗄️ Database Schema Summary

### Tables (6 Total)

| Table | Primary Key | Foreign Keys | Description |
|-------|-------------|--------------|-------------|
| **User** | user_id (UUID) | None | Platform users (guests, hosts, admins) |
| **Property** | property_id (UUID) | host_id → User | Rental property listings |
| **Booking** | booking_id (UUID) | property_id → Property<br>user_id → User | Reservation records |
| **Payment** | payment_id (UUID) | booking_id → Booking | Payment transactions |
| **Review** | review_id (UUID) | property_id → Property<br>user_id → User | Property reviews and ratings |
| **Message** | message_id (UUID) | sender_id → User<br>recipient_id → User | User-to-user messages |

---

## 🚀 Usage Instructions

### Prerequisites

- **PostgreSQL 13+** or **MySQL 8+**
- Database client (psql, MySQL Workbench, DBeaver, etc.)
- Appropriate database user permissions (CREATE TABLE, CREATE INDEX)

---

### PostgreSQL Setup

#### 1. Create Database
```sql
CREATE DATABASE airbnb_clone;
\c airbnb_clone
```

#### 2. Execute Schema Script
```bash
# Method 1: From command line
psql -U your_username -d airbnb_clone -f schema.sql

# Method 2: From psql shell
psql -U your_username -d airbnb_clone
\i schema.sql

# Method 3: Direct file path
psql -U your_username -d airbnb_clone
\i /path/to/database-script-0x01/schema.sql
```

#### 3. Verify Tables Created
```sql
-- List all tables
\dt

-- Describe specific table
\d "User"
\d Property

-- View all indexes
\di
```

---

### MySQL Setup

#### 1. Create Database
```sql
CREATE DATABASE airbnb_clone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airbnb_clone;
```

#### 2. Modify Schema for MySQL Compatibility

**Note:** The provided schema is optimized for PostgreSQL. For MySQL, you need to make these modifications:

**Replace:**
```sql
-- PostgreSQL ENUM types
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
...
```

**With:**
```sql
-- MySQL inline ENUM
-- (ENUM defined directly in table definition)
```

**Replace UUID generation:**
```sql
-- PostgreSQL
user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

-- MySQL 8.0+
user_id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
```

#### 3. Execute Modified Schema
```bash
# Method 1: From command line
mysql -u your_username -p airbnb_clone < schema_mysql.sql

# Method 2: From MySQL shell
mysql -u your_username -p
USE airbnb_clone;
source schema.sql;
```

#### 4. Verify Tables Created
```sql
-- List all tables
SHOW TABLES;

-- Describe specific table
DESCRIBE User;
DESCRIBE Property;

-- View all indexes
SHOW INDEX FROM User;
```

---

## 📊 Table Definitions

### 1. User Table

**Purpose:** Stores all platform users (guests, hosts, and administrators)

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| user_id | UUID | PRIMARY KEY | Unique user identifier |
| first_name | VARCHAR(255) | NOT NULL | User's first name |
| last_name | VARCHAR(255) | NOT NULL | User's last name |
| email | VARCHAR(255) | UNIQUE, NOT NULL | User's email (login) |
| password_hash | VARCHAR(255) | NOT NULL | Hashed password |
| phone_number | VARCHAR(20) | NULL | Contact number (optional) |
| role | ENUM | NOT NULL | guest, host, or admin |
| created_at | TIMESTAMP | DEFAULT NOW | Account creation date |

**Indexes:**
- PRIMARY KEY on user_id
- UNIQUE INDEX on email
- INDEX on role

**Constraints:**
- Email format validation (regex check)
- Role must be 'guest', 'host', or 'admin'

---

### 2. Property Table

**Purpose:** Stores rental property listings created by hosts

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| property_id | UUID | PRIMARY KEY | Unique property identifier |
| host_id | UUID | FOREIGN KEY, NOT NULL | Reference to User (host) |
| name | VARCHAR(255) | NOT NULL | Property title/name |
| description | TEXT | NOT NULL | Detailed description |
| location | VARCHAR(255) | NOT NULL | Property address/location |
| pricepernight | DECIMAL(10,2) | NOT NULL | Nightly rental rate |
| created_at | TIMESTAMP | DEFAULT NOW | Listing creation date |
| updated_at | TIMESTAMP | DEFAULT NOW | Last modification date |

**Indexes:**
- PRIMARY KEY on property_id
- INDEX on host_id (foreign key)
- INDEX on location (search queries)
- INDEX on pricepernight (filtering)

**Constraints:**
- host_id REFERENCES User(user_id)
- pricepernight must be positive (> 0)

**Trigger:**
- Auto-update updated_at on modification

---

### 3. Booking Table

**Purpose:** Stores reservation/booking records for properties

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| booking_id | UUID | PRIMARY KEY | Unique booking identifier |
| property_id | UUID | FOREIGN KEY, NOT NULL | Reference to Property |
| user_id | UUID | FOREIGN KEY, NOT NULL | Reference to User (guest) |
| start_date | DATE | NOT NULL | Check-in date |
| end_date | DATE | NOT NULL | Check-out date |
| total_price | DECIMAL(10,2) | NOT NULL | Total booking cost |
| status | ENUM | NOT NULL | pending, confirmed, canceled |
| created_at | TIMESTAMP | DEFAULT NOW | Booking creation date |

**Indexes:**
- PRIMARY KEY on booking_id
- INDEX on property_id (foreign key)
- INDEX on user_id (foreign key)
- INDEX on status (filtering)
- COMPOSITE INDEX on (start_date, end_date) (date range queries)

**Constraints:**
- property_id REFERENCES Property(property_id)
- user_id REFERENCES User(user_id)
- end_date must be after start_date
- total_price must be positive (> 0)
- status must be 'pending', 'confirmed', or 'canceled'

---

### 4. Payment Table

**Purpose:** Stores payment transaction records for bookings

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| payment_id | UUID | PRIMARY KEY | Unique payment identifier |
| booking_id | UUID | FOREIGN KEY, NOT NULL | Reference to Booking |
| amount | DECIMAL(10,2) | NOT NULL | Payment amount |
| payment_date | TIMESTAMP | DEFAULT NOW | Transaction timestamp |
| payment_method | ENUM | NOT NULL | credit_card, paypal, stripe |

**Indexes:**
- PRIMARY KEY on payment_id
- INDEX on booking_id (foreign key)
- INDEX on payment_method (analytics)

**Constraints:**
- booking_id REFERENCES Booking(booking_id)
- amount must be positive (> 0)
- payment_method must be 'credit_card', 'paypal', or 'stripe'

---

### 5. Review Table

**Purpose:** Stores user reviews and ratings for properties

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| review_id | UUID | PRIMARY KEY | Unique review identifier |
| property_id | UUID | FOREIGN KEY, NOT NULL | Reference to Property |
| user_id | UUID | FOREIGN KEY, NOT NULL | Reference to User (reviewer) |
| rating | INTEGER | NOT NULL, CHECK | Rating value (1-5) |
| comment | TEXT | NOT NULL | Review text/feedback |
| created_at | TIMESTAMP | DEFAULT NOW | Review creation date |

**Indexes:**
- PRIMARY KEY on review_id
- INDEX on property_id (foreign key)
- INDEX on user_id (foreign key)
- INDEX on rating (filtering/sorting)

**Constraints:**
- property_id REFERENCES Property(property_id)
- user_id REFERENCES User(user_id)
- rating must be between 1 and 5 (inclusive)

---

### 6. Message Table

**Purpose:** Stores messages between users (guest-host communication)

**Columns:**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| message_id | UUID | PRIMARY KEY | Unique message identifier |
| sender_id | UUID | FOREIGN KEY, NOT NULL | Reference to User (sender) |
| recipient_id | UUID | FOREIGN KEY, NOT NULL | Reference to User (recipient) |
| message_body | TEXT | NOT NULL | Message content |
| sent_at | TIMESTAMP | DEFAULT NOW | Message send timestamp |

**Indexes:**
- PRIMARY KEY on message_id
- INDEX on sender_id (foreign key)
- INDEX on recipient_id (foreign key)
- INDEX on sent_at (chronological queries)

**Constraints:**
- sender_id REFERENCES User(user_id)
- recipient_id REFERENCES User(user_id)
- sender_id must be different from recipient_id (no self-messaging)

---

## 🔒 Constraints Summary

### Primary Keys
✅ All tables use **UUID** primary keys for global uniqueness

### Foreign Keys
✅ **Referential integrity** enforced with CASCADE rules:
- ON DELETE CASCADE: Deleting parent deletes children
- ON UPDATE CASCADE: Updating parent updates children

### Unique Constraints
✅ **User.email** - Prevents duplicate accounts

### Check Constraints
✅ **Review.rating** - Must be 1-5  
✅ **Booking dates** - end_date > start_date  
✅ **Prices/amounts** - Must be positive (> 0)  
✅ **Message** - sender_id ≠ recipient_id  

### NOT NULL Constraints
✅ All critical fields enforce NOT NULL

### ENUM Constraints
✅ **User.role** - guest | host | admin  
✅ **Booking.status** - pending | confirmed | canceled  
✅ **Payment.payment_method** - credit_card | paypal | stripe  

---

## ⚡ Indexing Strategy

### Performance Optimization

**Automatic Indexes:**
- All PRIMARY KEYs are automatically indexed

**Foreign Key Indexes:**
- Indexes on all foreign key columns for efficient JOIN operations

**Search Indexes:**
- User.email - Fast authentication lookups
- Property.location - Location-based searches
- Booking.status - Status filtering
- Review.rating - Rating filtering

**Composite Indexes:**
- Booking(start_date, end_date) - Date range availability queries

**Timestamp Indexes:**
- Message.sent_at - Chronological message retrieval

---

## 🧪 Verification

After running the schema script, verify the setup:

### Check Tables Created
```sql
-- PostgreSQL
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- MySQL
SHOW TABLES;
```

**Expected Output:** 6 tables (User, Property, Booking, Payment, Review, Message)

### Check Constraints
```sql
-- PostgreSQL
SELECT 
    tc.table_name, 
    tc.constraint_name, 
    tc.constraint_type 
FROM information_schema.table_constraints tc
WHERE tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_type;

-- MySQL
SELECT 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE 
FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_SCHEMA = 'airbnb_clone';
```

### Check Indexes
```sql
-- PostgreSQL
SELECT 
    tablename, 
    indexname, 
    indexdef 
FROM pg_indexes 
WHERE schemaname = 'public' 
ORDER BY tablename, indexname;

-- MySQL
SELECT 
    TABLE_NAME, 
    INDEX_NAME, 
    COLUMN_NAME 
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = 'airbnb_clone' 
ORDER BY TABLE_NAME, INDEX_NAME;
```

---

## 🛠️ Troubleshooting

### Issue 1: "relation already exists"
**Solution:** Drop existing tables first
```sql
DROP TABLE IF EXISTS Message CASCADE;
DROP TABLE IF EXISTS Review CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Booking CASCADE;
DROP TABLE IF EXISTS Property CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;
```

### Issue 2: "type already exists" (PostgreSQL)
**Solution:** Types are created with error handling in the script. If issues persist:
```sql
DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS booking_status CASCADE;
DROP TYPE IF EXISTS payment_method CASCADE;
```

### Issue 3: MySQL UUID compatibility
**Solution:** Use BINARY(16) instead of UUID type and appropriate UUID functions

### Issue 4: Permission denied
**Solution:** Ensure database user has CREATE privileges
```sql
-- PostgreSQL
GRANT CREATE ON SCHEMA public TO your_username;

-- MySQL
GRANT CREATE ON airbnb_clone.* TO 'your_username'@'localhost';
```

---

## 📚 Additional Resources

- **ERD Documentation:** [../ERD/requirements.md](../ERD/requirements.md)
- **Normalization Analysis:** [../normalization.md](../normalization.md)
- **Sample Data:** [../database-script-0x02/seed.sql](../database-script-0x02/seed.sql)

---

## 🔄 Schema Modifications

If you need to modify the schema after creation:

### Add Column
```sql
ALTER TABLE Property ADD COLUMN amenities TEXT[];
```

### Add Index
```sql
CREATE INDEX idx_property_amenities ON Property USING GIN (amenities);
```

### Modify Column
```sql
ALTER TABLE User ALTER COLUMN phone_number TYPE VARCHAR(30);
```

### Add Constraint
```sql
ALTER TABLE Property ADD CONSTRAINT chk_name_length CHECK (LENGTH(name) >= 3);
```

---

## ✅ Schema Checklist

After running the schema script, verify:

- [ ] All 6 tables created successfully
- [ ] All primary keys defined (UUID type)
- [ ] All foreign keys established with CASCADE rules
- [ ] All UNIQUE constraints in place (User.email)
- [ ] All CHECK constraints working (rating 1-5, dates, positive amounts)
- [ ] All NOT NULL constraints enforced
- [ ] All ENUM types created (PostgreSQL) or inline (MySQL)
- [ ] All indexes created for performance
- [ ] Trigger for Property.updated_at working
- [ ] No errors in verification queries

---

**Document Version:** 1.0  
**Last Updated:** October 26, 2025  
**Compatible With:** PostgreSQL 13+, MySQL 8+ (with modifications)  
**Status:** Production Ready

