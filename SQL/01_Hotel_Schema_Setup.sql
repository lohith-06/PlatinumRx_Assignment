USE platinumrx_assignment;

--  01_Hotel_Schema_Setup.sql
--  Create tables and insert sample data for Hotel Management
 
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

INSERT INTO users VALUES
('21wrcxuy-67erfn', 'John Doe' ,'97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('21wrcxuy-001', 'miller', '9717284612', 'miller123@example.com', 'AA Street,england'),
('21wrcxuy-002', 'kane ', '91074926947', 'kane123@example.com', 'BB Street,newzealand'),
('21wrcxuy-003', 'virat ', '96435452244', 'virat18@example.com', 'CC Street,delhi'),
('21wrcxuy-004', 'rohit', '9556546162', 'rohit45@example.com', 'DD Street,mumbai'),
('21wrcxuy-005', 'brewis', '96545132646', 'brewis@example.com', 'EE Street,SA'),
('21wrcxuy-006', 'head', '9565446162', 'head@example.com', 'FF Street,aus'),
('21wrcxuy-007', 'gayle', '94635343234', 'gayle333@example.com', 'GG Street,WI'),
('21wrcxuy-008', 'dhoni', '777777777', 'dhoni@example.com', ' HH Street,india');

SELECT * FROM users;

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings VALUES
('bk-001', '2021-09-23 07:36:48', 'rm-101', '21wrcxuy-67erfn'),
('bk-002', '2021-10-05 10:15:00', 'rm-102', '21wrcxuy-001'),
('bk-003', '2021-10-20 14:45:00', 'rm-103', '21wrcxuy-002'),
('bk-004', '2021-11-02 09:20:00', 'rm-104', '21wrcxuy-003'),
('bk-005', '2021-11-18 18:30:00', 'rm-105', '21wrcxuy-004'),
('bk-006', '2021-12-01 11:00:00', 'rm-106', '21wrcxuy-005');


CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),

    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials VALUES
('bc-001', 'bk-001', 'bill-001', '2021-09-23 12:03:22', 'itm-001', 2),
('bc-002', 'bk-001', 'bill-001', '2021-09-23 12:03:22', 'itm-004', 1),

('bc-003', 'bk-002', 'bill-002', '2021-10-05 14:20:00', 'itm-005', 2),
('bc-004', 'bk-002', 'bill-002', '2021-10-05 14:20:00', 'itm-006', 1),

('bc-005', 'bk-003', 'bill-003', '2021-10-20 16:00:00', 'itm-003', 2),
('bc-006', 'bk-003', 'bill-003', '2021-10-20 16:00:00', 'itm-007', 3),

('bc-007', 'bk-004', 'bill-004', '2021-11-02 10:30:00', 'itm-004', 1),
('bc-008', 'bk-004', 'bill-004', '2021-11-02 10:30:00', 'itm-002', 2),

('bc-009', 'bk-005', 'bill-005', '2021-11-18 20:00:00', 'itm-005', 1),
('bc-010', 'bk-005', 'bill-005', '2021-11-18 20:00:00', 'itm-006', 2),

('bc-011', 'bk-006', 'bill-006', '2021-12-01 13:00:00', 'itm-003', 1);


CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

INSERT INTO items VALUES
('itm-001', 'Tea', 50),
('itm-002', 'Coffee', 80),
('itm-003', 'Breakfast', 250),
('itm-004', 'Lunch', 500),
('itm-005', 'Dinner', 700),
('itm-006', 'Laundry', 300),
('itm-007', 'Room Service', 150);

SELECT * FROM users;
SELECT * FROM bookings;
SELECT * FROM items;
SELECT * FROM booking_commercials;
