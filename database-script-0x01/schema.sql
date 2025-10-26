-- =============================================
-- AirBnB Clone Database Schema (DDL)
-- =============================================
-- This script creates all tables for the AirBnB Clone application
-- with proper constraints, indexes, and relationships.
--
-- Database: PostgreSQL 13+ or MySQL 8+
-- Encoding: UTF-8
-- Author: Billy Mwangi
-- Date: October 26, 2025
-- =============================================

-- =============================================
-- SECTION 1: CREATE ENUM TYPES (PostgreSQL)
-- =============================================
-- Note: For MySQL, ENUM is defined inline in table creation

-- User role enumeration
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Booking status enumeration
DO $$ BEGIN
    CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Payment method enumeration
DO $$ BEGIN
    CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- =============================================
-- SECTION 2: CREATE TABLES
-- =============================================

-- ---------------------------------------------
-- Table: User
-- Description: Stores all platform users (guests, hosts, and admins)
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS "User" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role user_role NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Add comment
COMMENT ON TABLE "User" IS 'Stores all platform users including guests, hosts, and administrators';
COMMENT ON COLUMN "User".user_id IS 'Unique identifier for each user (UUID)';
COMMENT ON COLUMN "User".email IS 'User email address, must be unique across the platform';
COMMENT ON COLUMN "User".password_hash IS 'Hashed password using bcrypt or argon2';
COMMENT ON COLUMN "User".role IS 'User role: guest, host, or admin';

-- ---------------------------------------------
-- Table: Property
-- Description: Stores rental property listings
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_price_positive CHECK (pricepernight > 0)
);

-- Add comment
COMMENT ON TABLE Property IS 'Stores rental property listings created by hosts';
COMMENT ON COLUMN Property.property_id IS 'Unique identifier for each property (UUID)';
COMMENT ON COLUMN Property.host_id IS 'Foreign key reference to the host (User)';
COMMENT ON COLUMN Property.pricepernight IS 'Nightly rental rate in decimal format';

-- ---------------------------------------------
-- Table: Booking
-- Description: Stores reservation records
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) 
        REFERENCES Property(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_dates_valid CHECK (end_date > start_date),
    CONSTRAINT chk_total_price_positive CHECK (total_price > 0)
);

-- Add comment
COMMENT ON TABLE Booking IS 'Stores booking/reservation records for properties';
COMMENT ON COLUMN Booking.booking_id IS 'Unique identifier for each booking (UUID)';
COMMENT ON COLUMN Booking.status IS 'Booking status: pending, confirmed, or canceled';
COMMENT ON COLUMN Booking.total_price IS 'Total price for the entire booking period';

-- ---------------------------------------------
-- Table: Payment
-- Description: Stores payment transaction records
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS Payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method NOT NULL,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) 
        REFERENCES Booking(booking_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_amount_positive CHECK (amount > 0)
);

-- Add comment
COMMENT ON TABLE Payment IS 'Stores payment transaction records for bookings';
COMMENT ON COLUMN Payment.payment_id IS 'Unique identifier for each payment (UUID)';
COMMENT ON COLUMN Payment.payment_method IS 'Payment method: credit_card, paypal, or stripe';

-- ---------------------------------------------
-- Table: Review
-- Description: Stores user reviews for properties
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS Review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) 
        REFERENCES Property(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_rating_range CHECK (rating >= 1 AND rating <= 5)
);

-- Add comment
COMMENT ON TABLE Review IS 'Stores user reviews and ratings for properties';
COMMENT ON COLUMN Review.review_id IS 'Unique identifier for each review (UUID)';
COMMENT ON COLUMN Review.rating IS 'Rating value between 1 and 5 stars';

-- ---------------------------------------------
-- Table: Message
-- Description: Stores messages between users
-- ---------------------------------------------
CREATE TABLE IF NOT EXISTS Message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_different_users CHECK (sender_id != recipient_id)
);

-- Add comment
COMMENT ON TABLE Message IS 'Stores messages between users (guest-host communication)';
COMMENT ON COLUMN Message.message_id IS 'Unique identifier for each message (UUID)';
COMMENT ON COLUMN Message.sender_id IS 'Foreign key reference to the message sender (User)';
COMMENT ON COLUMN Message.recipient_id IS 'Foreign key reference to the message recipient (User)';

-- =============================================
-- SECTION 3: CREATE INDEXES
-- =============================================

-- User table indexes
CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);
CREATE INDEX IF NOT EXISTS idx_user_role ON "User"(role);

-- Property table indexes
CREATE INDEX IF NOT EXISTS idx_property_host ON Property(host_id);
CREATE INDEX IF NOT EXISTS idx_property_location ON Property(location);
CREATE INDEX IF NOT EXISTS idx_property_price ON Property(pricepernight);

-- Booking table indexes
CREATE INDEX IF NOT EXISTS idx_booking_property ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_user ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_status ON Booking(status);
CREATE INDEX IF NOT EXISTS idx_booking_dates ON Booking(start_date, end_date);

-- Payment table indexes
CREATE INDEX IF NOT EXISTS idx_payment_booking ON Payment(booking_id);
CREATE INDEX IF NOT EXISTS idx_payment_method ON Payment(payment_method);

-- Review table indexes
CREATE INDEX IF NOT EXISTS idx_review_property ON Review(property_id);
CREATE INDEX IF NOT EXISTS idx_review_user ON Review(user_id);
CREATE INDEX IF NOT EXISTS idx_review_rating ON Review(rating);

-- Message table indexes
CREATE INDEX IF NOT EXISTS idx_message_sender ON Message(sender_id);
CREATE INDEX IF NOT EXISTS idx_message_recipient ON Message(recipient_id);
CREATE INDEX IF NOT EXISTS idx_message_sent_at ON Message(sent_at);

-- =============================================
-- SECTION 4: CREATE TRIGGERS (Optional)
-- =============================================

-- Trigger to update Property.updated_at on modification
CREATE OR REPLACE FUNCTION update_property_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_property_timestamp
    BEFORE UPDATE ON Property
    FOR EACH ROW
    EXECUTE FUNCTION update_property_timestamp();

-- =============================================
-- SECTION 5: VERIFICATION QUERIES
-- =============================================

-- Verify all tables were created
SELECT 
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'public'
    AND table_name IN ('User', 'Property', 'Booking', 'Payment', 'Review', 'Message')
ORDER BY table_name;

-- Verify all indexes were created
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
    AND tablename IN ('User', 'Property', 'Booking', 'Payment', 'Review', 'Message')
ORDER BY tablename, indexname;

-- Display table structure summary
SELECT
    t.table_name,
    COUNT(c.column_name) as column_count,
    COUNT(DISTINCT tc.constraint_type) as constraint_types
FROM information_schema.tables t
LEFT JOIN information_schema.columns c ON t.table_name = c.table_name AND t.table_schema = c.table_schema
LEFT JOIN information_schema.table_constraints tc ON t.table_name = tc.table_name AND t.table_schema = tc.table_schema
WHERE t.table_schema = 'public'
    AND t.table_name IN ('User', 'Property', 'Booking', 'Payment', 'Review', 'Message')
GROUP BY t.table_name
ORDER BY t.table_name;

-- =============================================
-- END OF SCHEMA SCRIPT
-- =============================================

