USE platinumrx_assignment;

--  03_Clinic_Schema_Setup.sql
--  Create tables and insert sample data for Clinic Management

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

INSERT INTO clinics VALUES
('cnc-0100001', 'XYZ Clinic', 'Hyderabad', 'Telangana', 'India'),
('cnc-0100002', 'Health First', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100003', 'Care Plus', 'Bangalore', 'Karnataka', 'India'),
('cnc-0100004', 'MediHub', 'Pune', 'Maharashtra', 'India'),
('cnc-0100005', 'Wellness Point', 'Warangal', 'Telangana', 'India');

SELECT * FROM clinics;

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

INSERT INTO customer VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('bk-09f3e-001', 'Virat', '9643545224'),
('bk-09f3e-002', 'Rohit', '9556546162'),
('bk-09f3e-003', 'Dhoni', '7777777777'),
('bk-09f3e-004', 'Kane', '9107492694');


SELECT * FROM customer;

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),

    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinic_sales VALUES
('ord-001', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'Walk-In'),
('ord-002', 'bk-09f3e-001', 'cnc-0100002', 18000, '2021-10-10 11:00:00', 'Online'),
('ord-003', 'bk-09f3e-002', 'cnc-0100001', 32000, '2021-10-15 15:30:00', 'Referral'),
('ord-004', 'bk-09f3e-003', 'cnc-0100003', 15000, '2021-11-05 10:45:00', 'Walk-In'),
('ord-005', 'bk-09f3e-004', 'cnc-0100004', 40000, '2021-11-18 14:20:00', 'Online'),
('ord-006', 'bk-09f3e-001', 'cnc-0100005', 22000, '2021-12-01 09:00:00', 'Referral');



SELECT * FROM clinic_sales;

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10,2),
    datetime DATETIME,

    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses VALUES
('exp-001', 'cnc-0100001', 'First Aid Supplies', 557, '2021-09-23 07:36:48'),
('exp-002', 'cnc-0100001', 'Equipment Repair', 5000, '2021-10-05 12:00:00'),
('exp-003', 'cnc-0100002', 'Rent', 10000, '2021-10-10 09:00:00'),
('exp-004', 'cnc-0100003', 'Medicines', 7000, '2021-11-01 08:00:00'),
('exp-005', 'cnc-0100004', 'Staff Salary', 15000, '2021-11-15 18:00:00'),
('exp-006', 'cnc-0100005', 'Electricity', 3000, '2021-12-01 20:00:00');

SELECT * FROM expenses;