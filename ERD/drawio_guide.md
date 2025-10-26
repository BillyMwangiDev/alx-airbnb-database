# Draw.io ERD Creation Guide
## Complete Step-by-Step Tutorial for AirBnB Clone Database

---

## 📌 Prerequisites

- Web browser (Chrome, Firefox, Safari, or Edge)
- Internet connection
- Access to https://app.diagrams.net/ (Draw.io)

---

## 🚀 Quick Start: Creating Your ERD

### Step 1: Open Draw.io

1. Navigate to **https://app.diagrams.net/**
2. Click **"Create New Diagram"**
3. Choose where to save:
   - **Device** (save locally)
   - **Google Drive**
   - **OneDrive**
   - **GitHub** (recommended for version control)
4. Name your diagram: `airbnb_database_erd`
5. Click **"Create"**

### Step 2: Select a Template (Optional)

- Choose **"Blank Diagram"** for full control
- Or select **"Entity Relation"** template under "Software" section
- Click **"Create"** to start

---

## 🎨 Setting Up Your Canvas

### Canvas Configuration

1. **Set Page Size:**
   - Click **File → Page Setup**
   - Choose **A4 Landscape** or **Letter Landscape**
   - Set orientation to **Landscape**

2. **Enable Grid and Guidelines:**
   - Click **View → Grid** (or press `Ctrl+Shift+G`)
   - Click **View → Guides** (or press `Ctrl+Shift+H`)
   - This helps align entities perfectly

3. **Customize Background (Optional):**
   - Right-click canvas → **Properties**
   - Select a background color (light blue or white recommended)

---

## 📦 Adding Entities

### Method 1: Using Entity Relation Shapes

1. **Open Entity Relation Library:**
   - Left sidebar → Click **"More Shapes"**
   - Find and check **"Entity Relation"**
   - Click **"Apply"**

2. **Add Entity Box:**
   - Drag **"Entity"** shape from left sidebar to canvas
   - Double-click to rename (e.g., "User")

3. **Customize Entity Appearance:**
   - Right-click entity → **Edit Style**
   - Set fill color, border, and font
   - Recommended: Distinct colors per entity group

### Method 2: Using Rectangles

1. **Draw Rectangle:**
   - Click rectangle tool in toolbar
   - Draw on canvas
   - Double-click to add title

2. **Add Title Section:**
   - Draw another rectangle inside
   - Add entity name (e.g., "USER")
   - Make it bold and centered

3. **Add Attributes:**
   - Use text tool to add attributes list
   - Format with proper alignment

---

## 🏗️ Creating the 6 Entities

### Entity 1: USER

1. **Create Entity Box:**
   - Add entity shape or rectangle
   - Title: **USER**
   - Background color: Light Blue (#E3F2FD)

2. **Add Attributes:**
   ```
   PK  user_id: UUID
       first_name: VARCHAR(255)
       last_name: VARCHAR(255)
   UK  email: VARCHAR(255)
       password_hash: VARCHAR(255)
       phone_number: VARCHAR(20)
       role: ENUM(guest, host, admin)
       created_at: TIMESTAMP
   ```

3. **Format Attributes:**
   - **Bold** the entity name at top
   - **Underline** or prefix **"PK"** for Primary Key
   - Prefix **"UK"** for Unique Key
   - Left-align attribute names
   - Use monospace font for field names

### Entity 2: PROPERTY

1. **Create Entity Box:**
   - Title: **PROPERTY**
   - Background color: Light Green (#E8F5E9)

2. **Add Attributes:**
   ```
   PK  property_id: UUID
   FK  host_id: UUID → User.user_id
       name: VARCHAR(255)
       description: TEXT
       location: VARCHAR(255)
       pricepernight: DECIMAL(10,2)
       created_at: TIMESTAMP
       updated_at: TIMESTAMP
   ```

3. **Highlight Foreign Key:**
   - Prefix **"FK"** for Foreign Key
   - Add arrow notation (→) showing reference

### Entity 3: BOOKING

1. **Create Entity Box:**
   - Title: **BOOKING**
   - Background color: Light Yellow (#FFF9C4)

2. **Add Attributes:**
   ```
   PK  booking_id: UUID
   FK  property_id: UUID → Property.property_id
   FK  user_id: UUID → User.user_id
       start_date: DATE
       end_date: DATE
       total_price: DECIMAL(10,2)
       status: ENUM(pending, confirmed, canceled)
       created_at: TIMESTAMP
   ```

### Entity 4: PAYMENT

1. **Create Entity Box:**
   - Title: **PAYMENT**
   - Background color: Light Orange (#FFE0B2)

2. **Add Attributes:**
   ```
   PK  payment_id: UUID
   FK  booking_id: UUID → Booking.booking_id
       amount: DECIMAL(10,2)
       payment_date: TIMESTAMP
       payment_method: ENUM(credit_card, paypal, stripe)
   ```

### Entity 5: REVIEW

1. **Create Entity Box:**
   - Title: **REVIEW**
   - Background color: Light Purple (#E1BEE7)

2. **Add Attributes:**
   ```
   PK  review_id: UUID
   FK  property_id: UUID → Property.property_id
   FK  user_id: UUID → User.user_id
       rating: INTEGER (CHECK: 1-5)
       comment: TEXT
       created_at: TIMESTAMP
   ```

### Entity 6: MESSAGE

1. **Create Entity Box:**
   - Title: **MESSAGE**
   - Background color: Light Cyan (#B2EBF2)

2. **Add Attributes:**
   ```
   PK  message_id: UUID
   FK  sender_id: UUID → User.user_id
   FK  recipient_id: UUID → User.user_id
       message_body: TEXT
       sent_at: TIMESTAMP
   ```

---

## 🔗 Drawing Relationships

### Understanding Crow's Foot Notation

| Symbol | Meaning |
|--------|---------|
| **│** | Exactly One (Mandatory) |
| **○│** | Zero or One (Optional) |
| **├** | Exactly Many (Mandatory) |
| **├○** | Zero or Many (Optional) |

### Creating Relationship Lines

1. **Select Connector Tool:**
   - Click the connector icon in toolbar
   - Or click on an entity edge (connection point appears)

2. **Draw Connection:**
   - Click on source entity
   - Click on target entity
   - Line appears between them

3. **Set Line Style:**
   - Right-click line → **Edit Style**
   - Choose **"Entity Relation"** or **"Straight"**
   - Set appropriate cardinality markers

4. **Add Relationship Label:**
   - Double-click on line
   - Add verb (e.g., "owns", "makes", "has")
   - Position label above or beside line

---

## 📊 All 8 Relationships to Draw

### Relationship 1: User → Property (Owns)
- **Type:** One-to-Many (1:N)
- **Line:** USER (│) ──owns──> (├○) PROPERTY
- **Label:** "owns (as host)"
- **From:** USER entity
- **To:** PROPERTY entity (point to host_id FK)

### Relationship 2: User → Booking (Makes)
- **Type:** One-to-Many (1:N)
- **Line:** USER (│) ──makes──> (├○) BOOKING
- **Label:** "makes (as guest)"
- **From:** USER entity
- **To:** BOOKING entity (point to user_id FK)

### Relationship 3: Property → Booking (Has)
- **Type:** One-to-Many (1:N)
- **Line:** PROPERTY (│) ──has──> (├○) BOOKING
- **Label:** "has bookings"
- **From:** PROPERTY entity
- **To:** BOOKING entity (point to property_id FK)

### Relationship 4: Booking → Payment (Has)
- **Type:** One-to-One (1:1)
- **Line:** BOOKING (│) ──has──> (○│) PAYMENT
- **Label:** "has payment"
- **From:** BOOKING entity
- **To:** PAYMENT entity (point to booking_id FK)

### Relationship 5: Property → Review (Receives)
- **Type:** One-to-Many (1:N)
- **Line:** PROPERTY (│) ──receives──> (├○) REVIEW
- **Label:** "receives reviews"
- **From:** PROPERTY entity
- **To:** REVIEW entity (point to property_id FK)

### Relationship 6: User → Review (Writes)
- **Type:** One-to-Many (1:N)
- **Line:** USER (│) ──writes──> (├○) REVIEW
- **Label:** "writes reviews"
- **From:** USER entity
- **To:** REVIEW entity (point to user_id FK)

### Relationship 7: User → Message (Sends)
- **Type:** One-to-Many (1:N)
- **Line:** USER (│) ──sends──> (├○) MESSAGE
- **Label:** "sends"
- **From:** USER entity
- **To:** MESSAGE entity (point to sender_id FK)

### Relationship 8: User → Message (Receives)
- **Type:** One-to-Many (1:N)
- **Line:** USER (│) ──receives──> (├○) MESSAGE
- **Label:** "receives"
- **From:** USER entity
- **To:** MESSAGE entity (point to recipient_id FK)

---

## 🎨 Styling and Formatting

### Recommended Color Scheme

```
USER:     Light Blue    (#E3F2FD)
PROPERTY: Light Green   (#E8F5E9)
BOOKING:  Light Yellow  (#FFF9C4)
PAYMENT:  Light Orange  (#FFE0B2)
REVIEW:   Light Purple  (#E1BEE7)
MESSAGE:  Light Cyan    (#B2EBF2)
```

### Typography Guidelines

1. **Entity Names:**
   - Font: Arial or Helvetica
   - Size: 14pt
   - Weight: Bold
   - Alignment: Center

2. **Attributes:**
   - Font: Courier New or Monaco (monospace)
   - Size: 10pt
   - Weight: Regular
   - Alignment: Left

3. **Relationship Labels:**
   - Font: Arial
   - Size: 10pt
   - Style: Italic
   - Color: Dark Gray (#424242)

### Layout Recommendations

1. **Entity Placement:**
   ```
   USER (Center Top)
   │
   ├── PROPERTY (Left Middle)
   │   │
   │   └── BOOKING (Center Middle)
   │       │
   │       ├── PAYMENT (Right Middle)
   │       └── REVIEW (Left Bottom)
   │
   └── MESSAGE (Right Top)
   ```

2. **Spacing:**
   - Leave 100-150px between entities
   - Keep relationship lines as straight as possible
   - Minimize line crossings

3. **Alignment:**
   - Use grid snap (View → Snap to Grid)
   - Align entities horizontally or vertically
   - Group related entities together

---

## 🔧 Advanced Techniques

### Adding Indexes Notation

Add a small note/annotation box for indexes:
```
INDEXES:
- PK: All primary keys (auto)
- User.email (UNIQUE)
- Booking.status
- Property.host_id
```

### Adding Constraints Box

Create a separate box listing constraints:
```
CONSTRAINTS:
✓ Review.rating: 1-5
✓ Booking.end_date > start_date
✓ User.email UNIQUE
✓ All FKs enforce referential integrity
```

### Creating a Legend

Add a legend box in corner:
```
LEGEND:
PK = Primary Key
FK = Foreign Key
UK = Unique Key
│  = One (mandatory)
○│ = Zero or One
├  = Many (mandatory)
├○ = Zero or Many
```

---

## 💾 Saving and Exporting

### Saving Your Work

1. **Save to Device:**
   - Click **File → Save As**
   - Choose **"Device"**
   - Save as `.drawio` file

2. **Save to GitHub:**
   - Click **File → Save As**
   - Choose **"GitHub"**
   - Select repository and branch
   - Commit message: "Add AirBnB Clone ERD"

### Exporting for Submission

1. **Export as PNG (Recommended for viewing):**
   - Click **File → Export As → PNG**
   - Set zoom to **100%** or **200%** for clarity
   - Check **"Transparent Background"** if desired
   - Save as `airbnb_erd.png` in `ERD/` directory

2. **Export as PDF (Best for printing):**
   - Click **File → Export As → PDF**
   - Save as `airbnb_erd.pdf`

3. **Export as SVG (Best for scalability):**
   - Click **File → Export As → SVG**
   - Save as `airbnb_erd.svg`

4. **Keep Source File:**
   - Always keep the `.drawio` source file
   - This allows future edits
   - Save as `airbnb_erd.drawio`

---

## ✅ Quality Checklist

Before finalizing, ensure:

- [ ] All 6 entities are present and labeled
- [ ] All entity attributes are listed with data types
- [ ] Primary keys are clearly marked (PK)
- [ ] Foreign keys are clearly marked (FK) with arrows
- [ ] Unique keys are marked (UK)
- [ ] All 8 relationships are drawn
- [ ] Relationship cardinality is correct (1:1, 1:N)
- [ ] Relationship labels are descriptive
- [ ] No overlapping text or lines
- [ ] Color scheme is consistent and professional
- [ ] Layout is clean and easy to read
- [ ] Legend or key is included
- [ ] Diagram title is present
- [ ] Your name/date is included
- [ ] Exported as PNG/PDF in high quality
- [ ] Source .drawio file is saved

---

## 🎓 Pro Tips

1. **Use Layers:**
   - Create separate layers for entities and relationships
   - Makes editing easier

2. **Group Related Items:**
   - Select multiple shapes → Right-click → Group
   - Move grouped items together

3. **Align Tools:**
   - Use **Arrange → Align** tools for perfect alignment
   - Use **Arrange → Distribute** for even spacing

4. **Snap to Guides:**
   - Drag from rulers to create guidelines
   - Entities snap to guides automatically

5. **Keyboard Shortcuts:**
   - `Ctrl+C` / `Ctrl+V`: Copy/Paste
   - `Ctrl+D`: Duplicate
   - `Ctrl+G`: Group selection
   - `Ctrl+Shift+G`: Ungroup
   - `Arrow Keys`: Move selected shape
   - `Shift+Arrow`: Move in larger steps

6. **Save Frequently:**
   - Auto-save is enabled, but manual saves are safer
   - `Ctrl+S` to save

---

## 📚 Additional Resources

### Draw.io Documentation
- Official Guide: https://www.diagrams.net/doc/
- Video Tutorials: https://www.youtube.com/c/drawio

### ERD Best Practices
- Database Design Tutorial: https://www.lucidchart.com/pages/database-diagram/database-design
- ER Diagram Symbols: https://www.smartdraw.com/entity-relationship-diagram/

### Example ERDs
- Sample Diagrams: https://dbdiagram.io/d
- E-commerce ERD Examples
- Social Media ERD Examples

---

## 🎯 Final Deliverable

Your completed ERD should include:

1. **Visual Diagram:**
   - File: `ERD/airbnb_erd.png` (or .pdf)
   - High resolution (1920px width minimum)
   - Clear and readable

2. **Source File:**
   - File: `ERD/airbnb_erd.drawio`
   - For future modifications

3. **Documentation:**
   - File: `ERD/requirements.md` (already provided)
   - Explains all entities, attributes, and relationships

---

**Good luck creating your ERD! Take your time to make it professional and accurate.**

**Estimated Time:** 1-2 hours for a complete, polished ERD

**Remember:** The ERD is the foundation of your entire database design. A clear, well-organized diagram will make all subsequent tasks (normalization, SQL DDL, data seeding) much easier.

