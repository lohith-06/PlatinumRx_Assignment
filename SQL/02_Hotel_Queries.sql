USE platinumrx_assignment;

-- 1 : For every user, get user_id and last booked room_no

WITH ranked_bookings AS (
    SELECT
        user_id,
        room_no,
        booking_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY booking_date DESC
        ) AS rn
    FROM bookings
)

SELECT
    user_id,
    room_no AS last_booked_room
FROM ranked_bookings
WHERE rn = 1;


-- 2: booking_id and total billing for bookings created in November 2021

SELECT
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc
    ON b.booking_id = bc.booking_id
JOIN items i
    ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11
  AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;


-- 3: Bills raised in October 2021 with total bill amount greater than 1000

SELECT
    bc.bill_id,
    SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials AS bc
INNER JOIN items AS i
    ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-10-01'
  AND bc.bill_date < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(i.item_rate * bc.item_quantity) > 1000;


-- 4: Most and least ordered item for each month in 2021

WITH item_summary AS (
    SELECT 
        MONTH(bc.bill_date) AS month_no,
        i.item_name,
        SUM(bc.item_quantity) AS qty_ordered
    FROM booking_commercials bc
    JOIN items i 
        ON bc.item_id = i.item_id
    WHERE bc.bill_date >= '2021-01-01'
      AND bc.bill_date < '2022-01-01'
    GROUP BY MONTH(bc.bill_date), i.item_name
),

item_ranks AS (
    SELECT 
        month_no,
        item_name,
        qty_ordered,
        RANK() OVER (
            PARTITION BY month_no 
            ORDER BY qty_ordered DESC
        ) AS top_rank,
        RANK() OVER (
            PARTITION BY month_no 
            ORDER BY qty_ordered
        ) AS bottom_rank
    FROM item_summary
)

SELECT 
    month_no,
    item_name,
    qty_ordered,
    CASE
        WHEN top_rank = 1 THEN 'Most Ordered'
        ELSE 'Least Ordered'
    END AS category
FROM item_ranks
WHERE top_rank = 1
   OR bottom_rank = 1
ORDER BY month_no, category;


-- 5: Customers with second highest bill of each month in 2021

WITH monthly_bills AS (
    SELECT
        MONTH(bc.bill_date) AS month_no,
        u.user_id,
        u.name,
        bc.bill_id,
        SUM(i.item_rate * bc.item_quantity) AS bill_value
    FROM booking_commercials bc
    JOIN bookings b
        ON bc.booking_id = b.booking_id
    JOIN users u
        ON b.user_id = u.user_id
    JOIN items i
        ON bc.item_id = i.item_id
    WHERE bc.bill_date >= '2021-01-01'
      AND bc.bill_date < '2022-01-01'
    GROUP BY 
        MONTH(bc.bill_date),
        u.user_id,
        u.name,
        bc.bill_id
),

ranked_bills AS (
    SELECT
        month_no,
        user_id,
        name,
        bill_id,
        bill_value,
        RANK() OVER (
            PARTITION BY month_no
            ORDER BY bill_value DESC
        ) AS bill_rank
    FROM monthly_bills
)

SELECT
    month_no,
    user_id,
    name,
    bill_id,
    bill_value
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY month_no;
