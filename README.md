# alx-airbnb-database

**ALX Airbnb Database Module**  
Database design, normalization analysis, SQL schema, and sample data for the AirBnB Clone project.

---

## 📖 About the Project

This project is part of the comprehensive **ALX Airbnb Database Module**, focusing on database design, normalization, schema creation, and seeding. By working through these tasks, learners will design and build a robust relational database for an Airbnb-like application, ensuring scalability, efficiency, and real-world functionality. 

The project simulates a **production-level database system**, emphasizing high standards of design, development, and data handling.

---

## 🎯 Learning Objectives

As a professional developer, completing these tasks will empower you to:

✅ **Apply advanced principles of database design** to model complex systems  
✅ **Master the art of normalization** to optimize database efficiency and minimize redundancy  
✅ **Use SQL DDL** to define database schema with appropriate constraints, keys, and indexing for performance optimization  
✅ **Write and execute SQL DML scripts** to seed databases with realistic sample data, simulating real-world scenarios  
✅ **Enhance collaboration skills** by managing repositories, documenting processes, and adhering to professional submission standards

---

## 📋 Requirements

To successfully complete these tasks, you must:

- Have a **strong foundation in relational databases and SQL**
- Be proficient in using **Draw.io or similar tools** for visual modeling
- Possess a good understanding of **data normalization principles**, particularly up to 3NF
- Have experience with **GitHub repositories** for documentation and project submission
- Follow **industry best practices** for database design and scripting

---

## 🔑 Key Highlights

### Task 1: Entity-Relationship Diagram (ERD)
Craft a detailed Entity-Relationship Diagram (ERD) to visualize the database design, ensuring clear relationships and properly defined entities.

### Task 2: Database Normalization
Apply normalization principles to refine your database design, optimizing data integrity and minimizing redundancy.

### Task 3: SQL DDL Schema Scripts
Create SQL scripts to define the database schema, incorporating primary keys, foreign keys, and indexes for optimal query performance.

### Task 4: Sample Data Seeding
Populate the database with real-world sample data, simulating an Airbnb-like environment with users, properties, bookings, and payments.

---

## 📂 Repository Structure

```
alx-airbnb-database/
│
├── README.md                          # This file
├── .gitignore                         # Git ignore rules
│
├── ERD/                               # Task 1: Entity-Relationship Diagram
│   ├── requirements.md                # Complete entity specifications
│   ├── erd_mermaid_diagram.md         # Mermaid ERD (GitHub-compatible)
│   ├── erd_text_representation.md     # ASCII ERD visualization
│   └── drawio_guide.md                # Draw.io creation tutorial
│
├── normalization.md                   # Task 2: 3NF compliance analysis
│
├── database-script-0x01/              # Task 3: SQL DDL Scripts
│   ├── schema.sql                     # Table creation script
│   └── README.md                      # Schema documentation
│
└── database-script-0x02/              # Task 4: Sample Data Seeding
    ├── seed.sql                       # INSERT statements
    └── README.md                      # Seeding documentation
```

---

## 🗄️ Database Schema

### Entities (6 Total)

| Entity | Description | Primary Key | Sample Records |
|--------|-------------|-------------|----------------|
| **User** | Platform users (guests, hosts, admins) | user_id (UUID) | 15 |
| **Property** | Rental listings | property_id (UUID) | 25 |
| **Booking** | Reservations with status tracking | booking_id (UUID) | 35 |
| **Payment** | Transaction records | payment_id (UUID) | 30 |
| **Review** | User ratings and comments | review_id (UUID) | 45 |
| **Message** | User communication | message_id (UUID) | 55 |

**Total Sample Records:** 205

### Key Design Features

✨ **UUID Primary Keys** - Global uniqueness and distributed system scalability  
✨ **ENUM Types** - Controlled vocabularies (role, status, payment methods)  
✨ **Referential Integrity** - Foreign key constraints ensure data consistency  
✨ **Strategic Indexing** - Performance optimization for frequent queries  
✨ **Timestamp Tracking** - Audit trails with created_at and updated_at fields  

---

## 🚀 Quick Start

### Prerequisites

- PostgreSQL 13+ or MySQL 8+
- Database client (psql, MySQL Workbench, DBeaver, etc.)
- Git

### Installation

#### 1. Clone the repository
```bash
git clone https://github.com/BillyMwangiDev/alx-airbnb-database.git
cd alx-airbnb-database
```

#### 2. Create database
```sql
-- PostgreSQL
CREATE DATABASE airbnb_clone;

-- MySQL
CREATE DATABASE airbnb_clone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 3. Apply schema (Task 3)
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x01/schema.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x01/schema.sql
```

#### 4. Seed sample data (Task 4)
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x02/seed.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x02/seed.sql
```

#### 5. Verify installation
```sql
SELECT 'Users' AS table_name, COUNT(*) FROM "User"
UNION ALL SELECT 'Properties', COUNT(*) FROM Property
UNION ALL SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL SELECT 'Messages', COUNT(*) FROM Message;
```

**Expected Output:** 15 users, 25 properties, 35 bookings, 30 payments, 45 reviews, 55 messages

---

## 📊 Entity-Relationship Diagram (Task 1)

### View the ERD

- **Mermaid Diagram:** [ERD/erd_mermaid_diagram.md](ERD/erd_mermaid_diagram.md) ✨ (renders automatically on GitHub)
- **Text Representation:** [ERD/erd_text_representation.md](ERD/erd_text_representation.md)
- **Complete Specifications:** [ERD/requirements.md](ERD/requirements.md)
- **Draw.io Guide:** [ERD/drawio_guide.md](ERD/drawio_guide.md)

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

## 🔍 Normalization Analysis (Task 2)

The database schema is **fully compliant with Third Normal Form (3NF)**.

📄 **See detailed analysis:** [normalization.md](normalization.md)

### Summary

| Normal Form | Status | Description |
|-------------|--------|-------------|
| **1NF** | ✅ Pass | All columns contain atomic values, no repeating groups |
| **2NF** | ✅ Pass | No partial dependencies (all tables use single-column primary keys) |
| **3NF** | ✅ Pass | No transitive dependencies, all non-key attributes depend only on primary key |

**Conclusion:** All 6 tables meet 3NF requirements with justified business denormalization where applicable.

---

## 🛠️ SQL Scripts

### Task 3: Schema (DDL)

**Location:** `database-script-0x01/schema.sql`

Creates all 6 tables with:
- ✅ UUID primary keys
- ✅ Foreign key constraints (referential integrity)
- ✅ CHECK constraints (data validation)
- ✅ UNIQUE constraints
- ✅ ENUM types for controlled vocabularies
- ✅ Strategic indexes for performance

**Documentation:** [database-script-0x01/README.md](database-script-0x01/README.md)

### Task 4: Sample Data (DML)

**Location:** `database-script-0x02/seed.sql`

Inserts **205 realistic, interconnected records:**
- 15 users (2 admins, 6 hosts, 7 guests)
- 25 properties (various locations, $75-$500/night)
- 35 bookings (confirmed, pending, canceled)
- 30 payments (credit_card, paypal, stripe)
- 45 reviews (ratings 1-5 stars with comments)
- 55 messages (guest-host communication, support, etc.)

**Documentation:** [database-script-0x02/README.md](database-script-0x02/README.md)

---

## 🔒 Security & Constraints

### Data Integrity

✅ **Primary Keys:** UUID type, automatically indexed  
✅ **Foreign Keys:** Enforce referential integrity across all relationships  
✅ **Unique Constraints:** User.email prevents duplicate accounts  
✅ **CHECK Constraints:** Review.rating must be 1-5  
✅ **NOT NULL Constraints:** Critical fields cannot be empty  
✅ **ENUM Constraints:** Limited, valid values for role, status, payment_method  

### Security Best Practices

- Password hashing (bcrypt/argon2) in application layer
- Role-based access control (guest, host, admin)
- Input validation and sanitization
- Parameterized queries to prevent SQL injection
- Audit trails with timestamps

---

## ⚡ Performance Optimization

### Indexing Strategy

**Automatic Indexes:**
- All primary keys (user_id, property_id, booking_id, etc.)

**Foreign Key Indexes:**
- Property.host_id
- Booking.property_id, Booking.user_id
- Payment.booking_id
- Review.property_id, Review.user_id
- Message.sender_id, Message.recipient_id

**Unique Indexes:**
- User.email (fast authentication lookups)

**Status Indexes:**
- Booking.status (efficient filtering)

---

## 📚 Documentation

| Document | Description | Location |
|----------|-------------|----------|
| **ERD Requirements** | Complete entity specifications | [ERD/requirements.md](ERD/requirements.md) |
| **Mermaid ERD** | GitHub-renderable diagram | [ERD/erd_mermaid_diagram.md](ERD/erd_mermaid_diagram.md) |
| **Normalization Analysis** | 3NF compliance documentation | [normalization.md](normalization.md) |
| **Schema Documentation** | SQL DDL guide | [database-script-0x01/README.md](database-script-0x01/README.md) |
| **Seeding Documentation** | Sample data guide | [database-script-0x02/README.md](database-script-0x02/README.md) |
| **Draw.io Tutorial** | Visual ERD creation guide | [ERD/drawio_guide.md](ERD/drawio_guide.md) |

---

## 🧪 Testing & Validation

The sample data supports comprehensive testing:

✅ User authentication and role-based access  
✅ Property CRUD operations  
✅ Booking workflows (pending → confirmed → canceled)  
✅ Payment processing (full payments, deposits, refunds)  
✅ Review system (ratings 1-5 with comments)  
✅ Messaging between users  
✅ Multi-user scenarios and edge cases  

---

## ✅ Tasks Completed

| Task | Status | Deliverables |
|------|--------|--------------|
| **Task 1: ERD** | ✅ Complete | requirements.md, Mermaid diagram, Draw.io guide |
| **Task 2: Normalization** | ✅ Complete | normalization.md with 3NF analysis |
| **Task 3: Schema** | 🔲 Pending | schema.sql, documentation |
| **Task 4: Seeding** | ✅ Complete | seed.sql with 205 records, documentation |

---

## 🤝 Contributing

This is an educational project for the ALX Software Engineering program. 

For improvements or corrections:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request with clear description

---

## 📄 License

This project is part of the ALX Software Engineering program.

---

## 👨‍💻 Author

**Billy Mwangi**  
- GitHub: [@BillyMwangiDev](https://github.com/BillyMwangiDev)
- Project: ALX Airbnb Database Module

---

## 🔗 Related Repositories

- **Main Application:** [AirBnB-Clone-project](https://github.com/BillyMwangiDev/AirBnB-Clone-project)
- **Database Design:** [alx-airbnb-database](https://github.com/BillyMwangiDev/alx-airbnb-database) (this repo)

---

## 🎓 ALX Software Engineering Program

This project is part of the ALX Africa Software Engineering curriculum, focusing on professional database design, normalization principles, and industry best practices for building scalable, production-ready database systems.

---

**Last Updated:** October 26, 2025  
**Version:** 1.0.0  
**Status:** Tasks 1, 2, and 4 Complete | Task 3 Pending
