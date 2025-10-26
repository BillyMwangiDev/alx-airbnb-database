# alx-airbnb-database

Database design, normalization analysis, SQL schema, and sample data for the AirBnB Clone project.

---

## 📋 Project Overview

This repository contains the complete database architecture for an AirBnB Clone platform, including:
- Entity-Relationship Diagram (ERD)
- Normalization analysis (3NF compliance)
- SQL DDL schema scripts
- Sample data seeding scripts

---

## 📂 Repository Structure

```
alx-airbnb-database/
│
├── README.md                          # This file
├── .gitignore                         # Git ignore rules
│
├── ERD/                               # Entity-Relationship Diagram
│   ├── requirements.md                # Complete entity specifications
│   ├── erd_mermaid_diagram.md         # Mermaid ERD (GitHub-compatible)
│   ├── erd_text_representation.md     # ASCII ERD visualization
│   └── drawio_guide.md                # Draw.io creation tutorial
│
├── normalization.md                   # 3NF compliance analysis
│
├── database-script-0x01/              # SQL DDL Scripts
│   ├── schema.sql                     # Table creation script
│   └── README.md                      # Schema documentation
│
└── database-script-0x02/              # Sample Data Seeding
    ├── seed.sql                       # INSERT statements
    └── README.md                      # Seeding documentation
```

---

## 🗄️ Database Schema

### Entities (6 Total)

| Entity | Description | Records (Sample Data) |
|--------|-------------|----------------------|
| **User** | Platform users (guests, hosts, admins) | 15 |
| **Property** | Rental listings | 25 |
| **Booking** | Reservations with status tracking | 35 |
| **Payment** | Transaction records | 30 |
| **Review** | User ratings and comments | 45 |
| **Message** | User communication | 55 |

### Key Design Features

- **UUID Primary Keys** for global uniqueness and scalability
- **ENUM Types** for controlled vocabularies (role, status, payment methods)
- **Referential Integrity** enforced through foreign key constraints
- **Strategic Indexing** for performance optimization
- **Timestamp Tracking** for audit trails

---

## 🚀 Quick Start

### Prerequisites

- PostgreSQL 13+ or MySQL 8+
- Database client (psql, MySQL Workbench, DBeaver, etc.)
- Git

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/YOUR_USERNAME/alx-airbnb-database.git
cd alx-airbnb-database
```

2. **Create database:**
```sql
-- PostgreSQL
CREATE DATABASE airbnb_clone;

-- MySQL
CREATE DATABASE airbnb_clone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

3. **Apply schema:**
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x01/schema.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x01/schema.sql
```

4. **Seed sample data:**
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x02/seed.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x02/seed.sql
```

5. **Verify installation:**
```sql
SELECT 'Users' AS table_name, COUNT(*) FROM "User"
UNION ALL SELECT 'Properties', COUNT(*) FROM Property
UNION ALL SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL SELECT 'Messages', COUNT(*) FROM Message;
```

---

## 📊 Entity-Relationship Diagram

View the complete ERD:
- **Mermaid diagram:** [ERD/erd_mermaid_diagram.md](ERD/erd_mermaid_diagram.md) (renders on GitHub)
- **Text representation:** [ERD/erd_text_representation.md](ERD/erd_text_representation.md)
- **Complete specifications:** [ERD/requirements.md](ERD/requirements.md)

### Relationships Summary

```
USER (1) ──hosts──> (N) PROPERTY
USER (1) ──makes──> (N) BOOKING
PROPERTY (1) ──has──> (N) BOOKING
BOOKING (1) ──triggers──> (1) PAYMENT
PROPERTY (1) ──receives──> (N) REVIEW
USER (1) ──writes──> (N) REVIEW
USER (1) ──sends/receives──> (N) MESSAGE
```

---

## 🔍 Normalization Analysis

The database schema is fully compliant with **Third Normal Form (3NF)**.

See detailed analysis: [normalization.md](normalization.md)

**Summary:**
- ✅ All tables in 1NF (atomic values, no repeating groups)
- ✅ All tables in 2NF (no partial dependencies)
- ✅ All tables in 3NF (no transitive dependencies)
- ✅ Justified business denormalization documented

---

## 🛠️ Database Scripts

### Schema (DDL)
Location: `database-script-0x01/schema.sql`

Creates all 6 tables with:
- Primary key constraints (UUID)
- Foreign key constraints (referential integrity)
- CHECK constraints (data validation)
- UNIQUE constraints
- ENUM types
- Indexes for performance

**Documentation:** [database-script-0x01/README.md](database-script-0x01/README.md)

### Sample Data (DML)
Location: `database-script-0x02/seed.sql`

Inserts 205 realistic records:
- 15 users (admins, hosts, guests)
- 25 properties (various locations and prices)
- 35 bookings (confirmed, pending, canceled)
- 30 payments (multiple methods)
- 45 reviews (ratings 1-5 stars)
- 55 messages (various scenarios)

**Documentation:** [database-script-0x02/README.md](database-script-0x02/README.md)

---

## 🔒 Security Considerations

- **Password Hashing:** Use bcrypt or argon2 in application layer
- **Input Validation:** Parameterized queries to prevent SQL injection
- **Role-Based Access:** User roles (guest, host, admin) for authorization
- **Audit Trails:** Timestamps on all entities
- **Data Encryption:** Implement in application and transport layers

---

## ⚡ Performance Optimization

### Indexing Strategy

**Automatic Indexes:**
- All primary keys (UUID)

**Foreign Key Indexes:**
- Property.host_id
- Booking.property_id, Booking.user_id
- Payment.booking_id
- Review.property_id, Review.user_id
- Message.sender_id, Message.recipient_id

**Unique Indexes:**
- User.email (authentication)

**Status Indexes:**
- Booking.status (filtering)

---

## 📚 Documentation

- **ERD Requirements:** [ERD/requirements.md](ERD/requirements.md)
- **Normalization Analysis:** [normalization.md](normalization.md)
- **Schema Documentation:** [database-script-0x01/README.md](database-script-0x01/README.md)
- **Seeding Documentation:** [database-script-0x02/README.md](database-script-0x02/README.md)
- **Draw.io Guide:** [ERD/drawio_guide.md](ERD/drawio_guide.md)

---

## 🧪 Testing

The sample data supports testing of:

- User authentication and authorization
- Property CRUD operations
- Booking workflows (pending → confirmed → canceled)
- Payment processing (full, partial, refunds)
- Review system (ratings and comments)
- Messaging between users

---

## 🤝 Contributing

This is an educational project for learning database design principles.

If you find issues or have suggestions:
1. Check existing documentation
2. Review normalization analysis
3. Open an issue with detailed description

---

## 📄 License

This project is part of the ALX Software Engineering program.

---

## 👨‍💻 Author

**Your Name**  
- GitHub: [@your-username](https://github.com/your-username)
- Project: Part of ALX AirBnB Clone

---

## 🔗 Related Repositories

- **Main Application:** [AirBnB-CLONE-PROJECT](https://github.com/your-username/AirBnB-CLONE-PROJECT)
- **Database Design:** [alx-airbnb-database](https://github.com/your-username/alx-airbnb-database) (this repo)

---

## ✅ Project Status

- [x] Entity-Relationship Diagram
- [x] Normalization Analysis (3NF)
- [x] SQL DDL Schema Scripts
- [x] Sample Data Seeding
- [ ] Database Migrations (future)
- [ ] Performance Tuning (future)
- [ ] Backup/Recovery Scripts (future)

---

**Last Updated:** October 26, 2025  
**Version:** 1.0.0  
**Status:** Complete - Ready for Application Integration

