# AirBnB Clone - Text-Based Entity-Relationship Diagram

## Visual ASCII Representation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AIRBNB CLONE DATABASE ERD                            │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────┐
│         USER             │
├──────────────────────────┤
│ PK user_id (UUID)       │◄─────┐
│    first_name (VARCHAR)  │      │
│    last_name (VARCHAR)   │      │
│    email (VARCHAR) UK    │      │
│    password_hash (VAR)   │      │
│    phone_number (VAR)    │      │
│    role (ENUM)           │      │
│    created_at (TS)       │      │
└──────────────────────────┘      │
         │                         │
         │ 1:N (owns)              │
         │                         │
         ▼                         │
┌──────────────────────────┐      │
│       PROPERTY           │      │
├──────────────────────────┤      │
│ PK property_id (UUID)   │      │
│ FK host_id (UUID)       │──────┘
│    name (VARCHAR)        │
│    description (TEXT)    │
│    location (VARCHAR)    │
│    pricepernight (DEC)   │
│    created_at (TS)       │
│    updated_at (TS)       │
└──────────────────────────┘
         │
         │ 1:N (has bookings)
         │
         ▼
┌──────────────────────────┐      ┌──────────────────────────┐
│       BOOKING            │      │         USER             │
├──────────────────────────┤      │    (as guest)            │
│ PK booking_id (UUID)    │◄─────┤                          │
│ FK property_id (UUID)   │      │ FK user_id references    │
│ FK user_id (UUID)       │──────┤    User.user_id          │
│    start_date (DATE)     │      └──────────────────────────┘
│    end_date (DATE)       │
│    total_price (DEC)     │
│    status (ENUM)         │
│    created_at (TS)       │
└──────────────────────────┘
         │
         │ 1:1 (has payment)
         │
         ▼
┌──────────────────────────┐
│       PAYMENT            │
├──────────────────────────┤
│ PK payment_id (UUID)    │
│ FK booking_id (UUID)    │
│    amount (DECIMAL)      │
│    payment_date (TS)     │
│    payment_method (ENUM) │
└──────────────────────────┘


┌──────────────────────────┐
│       PROPERTY           │◄─────┐
└──────────────────────────┘      │
         │                         │
         │ 1:N (receives reviews)  │
         │                         │
         ▼                         │
┌──────────────────────────┐      │
│       REVIEW             │      │
├──────────────────────────┤      │
│ PK review_id (UUID)     │      │
│ FK property_id (UUID)   │──────┘
│ FK user_id (UUID)       │──────┐
│    rating (INTEGER 1-5)  │      │
│    comment (TEXT)        │      │
│    created_at (TS)       │      │
└──────────────────────────┘      │
                                   │
┌──────────────────────────┐      │
│         USER             │      │
│    (as reviewer)         │◄─────┘
└──────────────────────────┘


┌──────────────────────────┐
│         USER             │◄─────┐
│    (as sender)           │      │
└──────────────────────────┘      │
         │                         │
         │ 1:N (sends messages)    │
         │                         │
         ▼                         │
┌──────────────────────────┐      │
│       MESSAGE            │      │
├──────────────────────────┤      │
│ PK message_id (UUID)    │      │
│ FK sender_id (UUID)     │──────┘
│ FK recipient_id (UUID)  │──────┐
│    message_body (TEXT)   │      │
│    sent_at (TIMESTAMP)   │      │
└──────────────────────────┘      │
                                   │
┌──────────────────────────┐      │
│         USER             │      │
│    (as recipient)        │◄─────┘
└──────────────────────────┘
```

---

## Relationship Summary

### 1. User → Property (Host Relationship)
- **Type:** One-to-Many (1:N)
- **Description:** A user acting as a host can own multiple properties
- **Foreign Key:** `Property.host_id` references `User.user_id`
- **Business Rule:** A property must have exactly one host

### 2. User → Booking (Guest Relationship)
- **Type:** One-to-Many (1:N)
- **Description:** A user acting as a guest can make multiple bookings
- **Foreign Key:** `Booking.user_id` references `User.user_id`
- **Business Rule:** A booking must be associated with exactly one guest

### 3. Property → Booking
- **Type:** One-to-Many (1:N)
- **Description:** A property can have multiple bookings over time
- **Foreign Key:** `Booking.property_id` references `Property.property_id`
- **Business Rule:** A booking must be for exactly one property

### 4. Booking → Payment
- **Type:** One-to-One (1:1)
- **Description:** Each booking has at most one payment record
- **Foreign Key:** `Payment.booking_id` references `Booking.booking_id`
- **Business Rule:** A payment must be linked to exactly one booking

### 5. Property → Review
- **Type:** One-to-Many (1:N)
- **Description:** A property can receive multiple reviews from different users
- **Foreign Key:** `Review.property_id` references `Property.property_id`
- **Business Rule:** A review must be for exactly one property

### 6. User → Review (Reviewer Relationship)
- **Type:** One-to-Many (1:N)
- **Description:** A user can write multiple reviews for different properties
- **Foreign Key:** `Review.user_id` references `User.user_id`
- **Business Rule:** A review must be written by exactly one user

### 7. User → Message (Sender Relationship)
- **Type:** One-to-Many (1:N)
- **Description:** A user can send multiple messages to different recipients
- **Foreign Key:** `Message.sender_id` references `User.user_id`
- **Business Rule:** A message must have exactly one sender

### 8. User → Message (Recipient Relationship)
- **Type:** One-to-Many (1:N)
- **Description:** A user can receive multiple messages from different senders
- **Foreign Key:** `Message.recipient_id` references `User.user_id`
- **Business Rule:** A message must have exactly one recipient

---

## Entity Dependency Chain

```
                    ┌─────────┐
                    │  USER   │ (Root entity)
                    └────┬────┘
                         │
         ┌───────────────┼───────────────┬──────────────┐
         │               │               │              │
         ▼               ▼               ▼              ▼
    ┌─────────┐    ┌──────────┐    ┌─────────┐   ┌─────────┐
    │PROPERTY │    │ BOOKING  │    │ REVIEW  │   │ MESSAGE │
    └────┬────┘    └────┬─────┘    └─────────┘   └─────────┘
         │               │
         │               ▼
         │          ┌─────────┐
         │          │ PAYMENT │
         │          └─────────┘
         │
         ├──────► BOOKING (via property_id)
         │
         └──────► REVIEW (via property_id)
```

---

## Cardinality Notation Legend

- **1:1** - One-to-One (e.g., Booking:Payment)
- **1:N** - One-to-Many (e.g., User:Property, Property:Booking)
- **M:N** - Many-to-Many (none in this design - properly normalized)
- **PK** - Primary Key
- **FK** - Foreign Key
- **UK** - Unique Key
- **TS** - Timestamp
- **VAR** - VARCHAR
- **DEC** - DECIMAL
- **ENUM** - Enumerated Type

---

## Integrity Rules

### Referential Integrity
All foreign keys must reference valid primary keys in parent tables:
- Cannot create a Property without a valid User (host)
- Cannot create a Booking without valid Property and User
- Cannot create a Payment without a valid Booking
- Cannot create a Review without valid Property and User
- Cannot create a Message without valid sender and recipient Users

### Domain Integrity
- `User.role` must be one of: 'guest', 'host', 'admin'
- `Booking.status` must be one of: 'pending', 'confirmed', 'canceled'
- `Payment.payment_method` must be one of: 'credit_card', 'paypal', 'stripe'
- `Review.rating` must be between 1 and 5 (inclusive)

### Entity Integrity
- All primary keys must be unique and NOT NULL
- All primary keys use UUID for global uniqueness

### User-Defined Integrity
- `Booking.end_date` must be after `Booking.start_date`
- `Payment.amount` must match `Booking.total_price`
- Users can only review properties they have booked (application-level)
- Users cannot message themselves (`sender_id` ≠ `recipient_id`)

---

## Indexing Strategy Summary

### Primary Indexes (Automatic)
- All `*_id` primary keys are automatically indexed

### Foreign Key Indexes (Recommended)
- `Property.host_id`
- `Booking.property_id`
- `Booking.user_id`
- `Payment.booking_id`
- `Review.property_id`
- `Review.user_id`
- `Message.sender_id`
- `Message.recipient_id`

### Unique Indexes
- `User.email` (enforces unique constraint + fast lookup)

### Performance Indexes
- `Booking.status` (for filtering by status)
- `Booking(property_id, start_date, end_date)` composite for availability

---

## Database Statistics (Estimated Cardinalities)

For a mature AirBnB-like platform:

| Entity     | Estimated Records | Growth Rate    |
|------------|------------------|----------------|
| User       | 100K - 10M       | High           |
| Property   | 10K - 1M         | Medium         |
| Booking    | 1M - 100M        | Very High      |
| Payment    | 1M - 100M        | Very High      |
| Review     | 500K - 50M       | High           |
| Message    | 5M - 500M        | Very High      |

This influences our design decisions:
- UUID primary keys for distributed scalability
- Strategic indexing on high-volume tables (Booking, Payment, Message)
- Timestamp fields for temporal queries and analytics
- ENUM types to constrain values and save space

---

**Note:** This text representation should be accompanied by a visual ERD diagram created in Draw.io for better clarity and professional presentation.

