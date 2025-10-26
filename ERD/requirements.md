# Entity-Relationship Diagram (ERD) Requirements
## AirBnB Clone Database Design

### Project Overview
This document outlines the complete Entity-Relationship diagram requirements for the AirBnB Clone database system. The ERD visualizes the structure, relationships, and constraints of six core entities that power the platform's functionality.

---

## 📋 Entities and Their Attributes

### 1. **User Entity**
Represents all users of the platform (guests, hosts, and administrators).

**Attributes:**
- `user_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each user

- `first_name`
  - Type: VARCHAR(255)
  - Constraints: NOT NULL
  - Description: User's first name

- `last_name`
  - Type: VARCHAR(255)
  - Constraints: NOT NULL
  - Description: User's last name

- `email`
  - Type: VARCHAR(255)
  - Constraints: UNIQUE, NOT NULL, Indexed
  - Description: User's email address for authentication

- `password_hash`
  - Type: VARCHAR(255)
  - Constraints: NOT NULL
  - Description: Hashed password for secure authentication

- `phone_number`
  - Type: VARCHAR(20)
  - Constraints: NULL
  - Description: Optional contact number

- `role`
  - Type: ENUM('guest', 'host', 'admin')
  - Constraints: NOT NULL
  - Description: User's role in the system

- `created_at`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Account creation timestamp

---

### 2. **Property Entity**
Represents rental listings created by hosts.

**Attributes:**
- `property_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each property

- `host_id` (Foreign Key → User.user_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the host who owns the property

- `name`
  - Type: VARCHAR(255)
  - Constraints: NOT NULL
  - Description: Property title/name

- `description`
  - Type: TEXT
  - Constraints: NOT NULL
  - Description: Detailed property description

- `location`
  - Type: VARCHAR(255)
  - Constraints: NOT NULL
  - Description: Property address/location

- `pricepernight`
  - Type: DECIMAL(10, 2)
  - Constraints: NOT NULL
  - Description: Nightly rental rate

- `created_at`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Property listing creation date

- `updated_at`
  - Type: TIMESTAMP
  - Constraints: ON UPDATE CURRENT_TIMESTAMP
  - Description: Last modification timestamp

---

### 3. **Booking Entity**
Represents reservations made by guests for properties.

**Attributes:**
- `booking_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each booking

- `property_id` (Foreign Key → Property.property_id)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: References the booked property

- `user_id` (Foreign Key → User.user_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the guest making the booking

- `start_date`
  - Type: DATE
  - Constraints: NOT NULL
  - Description: Check-in date

- `end_date`
  - Type: DATE
  - Constraints: NOT NULL
  - Description: Check-out date

- `total_price`
  - Type: DECIMAL(10, 2)
  - Constraints: NOT NULL
  - Description: Total booking cost

- `status`
  - Type: ENUM('pending', 'confirmed', 'canceled')
  - Constraints: NOT NULL
  - Description: Current booking status

- `created_at`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Booking creation timestamp

---

### 4. **Payment Entity**
Records payment transactions for bookings.

**Attributes:**
- `payment_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each payment

- `booking_id` (Foreign Key → Booking.booking_id)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: References the associated booking

- `amount`
  - Type: DECIMAL(10, 2)
  - Constraints: NOT NULL
  - Description: Payment amount

- `payment_date`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Payment transaction timestamp

- `payment_method`
  - Type: ENUM('credit_card', 'paypal', 'stripe')
  - Constraints: NOT NULL
  - Description: Payment processing method

---

### 5. **Review Entity**
Represents user feedback and ratings for properties.

**Attributes:**
- `review_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each review

- `property_id` (Foreign Key → Property.property_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the reviewed property

- `user_id` (Foreign Key → User.user_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the reviewer

- `rating`
  - Type: INTEGER
  - Constraints: NOT NULL, CHECK (rating >= 1 AND rating <= 5)
  - Description: Numeric rating (1-5 scale)

- `comment`
  - Type: TEXT
  - Constraints: NOT NULL
  - Description: Written review feedback

- `created_at`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Review creation timestamp

---

### 6. **Message Entity**
Facilitates communication between users.

**Attributes:**
- `message_id` (Primary Key)
  - Type: UUID
  - Constraints: NOT NULL, Indexed
  - Description: Unique identifier for each message

- `sender_id` (Foreign Key → User.user_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the message sender

- `recipient_id` (Foreign Key → User.user_id)
  - Type: UUID
  - Constraints: NOT NULL
  - Description: References the message recipient

- `message_body`
  - Type: TEXT
  - Constraints: NOT NULL
  - Description: Message content

- `sent_at`
  - Type: TIMESTAMP
  - Constraints: DEFAULT CURRENT_TIMESTAMP
  - Description: Message sending timestamp

---

## 🔗 Entity Relationships

### User ↔ Property
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A user (as a host) can own multiple properties
- **Foreign Key:** `Property.host_id` → `User.user_id`
- **Cardinality:** 1 User : 0..* Properties

### User ↔ Booking
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A user (as a guest) can make multiple bookings
- **Foreign Key:** `Booking.user_id` → `User.user_id`
- **Cardinality:** 1 User : 0..* Bookings

### Property ↔ Booking
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A property can have multiple bookings
- **Foreign Key:** `Booking.property_id` → `Property.property_id`
- **Cardinality:** 1 Property : 0..* Bookings

### Booking ↔ Payment
- **Relationship Type:** One-to-One (1:1)
- **Description:** Each booking has exactly one payment record
- **Foreign Key:** `Payment.booking_id` → `Booking.booking_id`
- **Cardinality:** 1 Booking : 0..1 Payment

### Property ↔ Review
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A property can have multiple reviews
- **Foreign Key:** `Review.property_id` → `Property.property_id`
- **Cardinality:** 1 Property : 0..* Reviews

### User ↔ Review
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A user can write multiple reviews
- **Foreign Key:** `Review.user_id` → `User.user_id`
- **Cardinality:** 1 User : 0..* Reviews

### User ↔ Message (Sender)
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A user can send multiple messages
- **Foreign Key:** `Message.sender_id` → `User.user_id`
- **Cardinality:** 1 User : 0..* Messages (sent)

### User ↔ Message (Recipient)
- **Relationship Type:** One-to-Many (1:N)
- **Description:** A user can receive multiple messages
- **Foreign Key:** `Message.recipient_id` → `User.user_id`
- **Cardinality:** 1 User : 0..* Messages (received)

---

## 🔒 Constraints and Business Rules

### Primary Key Constraints
- All primary keys use UUID type for global uniqueness and scalability
- All primary keys are automatically indexed
- Primary keys cannot be NULL

### Foreign Key Constraints
- All foreign keys enforce referential integrity
- Cascade rules should be defined based on business logic:
  - `User` deletion: Consider soft delete or reassignment
  - `Property` deletion: CASCADE to related bookings/reviews or restrict
  - `Booking` deletion: CASCADE to payment or restrict if payment exists
  
### Unique Constraints
- `User.email`: Must be unique across all users
- Prevents duplicate account registration

### Check Constraints
- `Review.rating`: Must be between 1 and 5 (inclusive)
- `Booking.end_date`: Must be greater than `start_date` (application level)
- `Payment.amount`: Must be positive (> 0)

### NOT NULL Constraints
- All entity IDs, names, and critical business fields are NOT NULL
- Optional fields: `User.phone_number`

### ENUM Constraints
- `User.role`: Limited to 'guest', 'host', 'admin'
- `Booking.status`: Limited to 'pending', 'confirmed', 'canceled'
- `Payment.payment_method`: Limited to 'credit_card', 'paypal', 'stripe'

---

## 📊 Indexing Strategy

### Automatic Indexes (Primary Keys)
- `User.user_id`
- `Property.property_id`
- `Booking.booking_id`
- `Payment.payment_id`
- `Review.review_id`
- `Message.message_id`

### Additional Recommended Indexes
- `User.email` (UNIQUE index for fast authentication lookups)
- `Property.host_id` (Foreign key index for property listings by host)
- `Booking.property_id` (Foreign key index for property availability queries)
- `Booking.user_id` (Foreign key index for user booking history)
- `Booking.status` (For filtering bookings by status)
- `Payment.booking_id` (Foreign key index for payment lookups)
- `Review.property_id` (Foreign key index for property reviews)
- `Review.user_id` (Foreign key index for user review history)
- `Message.sender_id` (Foreign key index for sent messages)
- `Message.recipient_id` (Foreign key index for received messages)

### Composite Indexes (Optional Performance Optimization)
- `Booking(property_id, start_date, end_date)` for availability searches
- `Review(property_id, created_at)` for recent reviews by property

---

## 🎨 ERD Diagram Instructions

### Tools for Creating the ERD
1. **Draw.io (diagrams.net)** - Recommended
   - Free, web-based diagramming tool
   - URL: https://app.diagrams.net/
   - Supports export to PNG, SVG, PDF, and XML

2. **Lucidchart** - Professional alternative
3. **dbdiagram.io** - Code-based ERD tool
4. **MySQL Workbench** - For MySQL-specific ERDs

### ERD Diagram Requirements

Your ERD must include:

1. **All Six Entities** as rectangles/boxes:
   - User
   - Property
   - Booking
   - Payment
   - Review
   - Message

2. **Entity Attributes** listed inside each entity box:
   - Mark Primary Keys with **PK** or underline
   - Mark Foreign Keys with **FK**
   - Include data types next to attribute names
   - Show constraints (NOT NULL, UNIQUE)

3. **Relationship Lines** connecting entities:
   - Use crow's foot notation or similar to show cardinality
   - Label relationships with verbs (e.g., "owns", "makes", "has")
   - Show relationship types (1:1, 1:N, M:N)

4. **Cardinality Notation:**
   - One-to-One: 1:1
   - One-to-Many: 1:N (crow's foot)
   - Many-to-Many: M:N (if applicable)

5. **Clear Layout:**
   - Arrange entities logically to minimize crossing lines
   - Group related entities together
   - Use consistent formatting and colors

### Recommended Draw.io Steps

1. Open https://app.diagrams.net/
2. Select "Blank Diagram" or use the "Entity Relation" template
3. Use "Entity Relation" shapes from the left sidebar
4. Create entity boxes for each of the 6 entities
5. Add attributes inside each entity
6. Draw relationship lines with appropriate cardinality
7. Add labels to describe relationships
8. Export as PNG or PDF and save to the `ERD/` directory

### Naming Convention
- Save your ERD file as: `airbnb_erd.png` or `airbnb_erd.pdf`
- Keep a source file (`.drawio` or `.xml`) for future edits

---

## ✅ Validation Checklist

Before submitting your ERD, ensure:

- [ ] All 6 entities are represented
- [ ] All attributes are listed with correct data types
- [ ] Primary keys are clearly marked
- [ ] Foreign keys are clearly marked
- [ ] All 8 relationships are drawn and labeled
- [ ] Cardinality is correctly shown (1:1, 1:N)
- [ ] Constraints are documented (UNIQUE, NOT NULL, CHECK)
- [ ] Diagram is clean, readable, and professionally formatted
- [ ] File is saved in `ERD/` directory
- [ ] This requirements.md file is included in the submission

---

## 📚 References and Resources

- **Database Normalization:** Review 1NF, 2NF, and 3NF principles
- **ERD Best Practices:** Use consistent notation (Crow's Foot or Chen notation)
- **UUID vs INT Primary Keys:** UUIDs provide better scalability for distributed systems
- **Indexing Strategy:** Index foreign keys and frequently queried columns

---

## 🎯 Deliverables

1. **ERD Diagram File:**
   - Format: PNG, PDF, or SVG
   - Location: `ERD/airbnb_erd.{png|pdf}`
   - High resolution and clearly labeled

2. **This Requirements Document:**
   - Location: `ERD/requirements.md`
   - Complete and properly formatted

3. **Optional: Source File:**
   - Format: `.drawio` or `.xml`
   - Location: `ERD/airbnb_erd.drawio`
   - Allows future modifications

---

## 👨‍💻 Author Notes

This ERD serves as the foundation for the AirBnB Clone database implementation. The design follows industry best practices:

- **Scalability:** UUID primary keys support distributed systems
- **Integrity:** Foreign key constraints ensure data consistency
- **Performance:** Strategic indexing optimizes common queries
- **Flexibility:** ENUM types control data validity while allowing extensions
- **Security:** Password hashing and role-based access control built-in

The next steps after ERD approval:
1. Normalization review (Task 2)
2. SQL DDL script creation (Task 3)
3. Sample data seeding (Task 4)

---

**Document Version:** 1.0  
**Last Updated:** October 26, 2025  
**Status:** Ready for ERD Creation

