USE platinumrx_assignment;

-- 1 Revenue generated from each sales channel in 2021

SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE datetime >= '2021-01-01'
  AND datetime < '2022-01-01'
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- 2 Top 10 customers based on total purchase value in 2021

SELECT
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c
    ON cs.uid = c.uid
WHERE cs.datetime >= '2021-01-01'
  AND cs.datetime < '2022-01-01'
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


-- 3 Monthly revenue, expense, profit/loss status for 2021

WITH revenue_data AS (
    SELECT
        MONTH(datetime) AS month_no,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE datetime >= '2021-01-01'
      AND datetime < '2022-01-01'
    GROUP BY MONTH(datetime)
),

expense_data AS (
    SELECT
        MONTH(datetime) AS month_no,
        SUM(amount) AS expense
    FROM expenses
    WHERE datetime >= '2021-01-01'
      AND datetime < '2022-01-01'
    GROUP BY MONTH(datetime)
)

SELECT
    r.month_no,
    r.revenue,
    COALESCE(e.expense, 0) AS expense,
    (r.revenue - COALESCE(e.expense, 0)) AS profit,
    CASE
        WHEN (r.revenue - COALESCE(e.expense, 0)) > 0
            THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM revenue_data r
LEFT JOIN expense_data e
    ON r.month_no = e.month_no
ORDER BY r.month_no;


-- 4 Most profitable clinic in each city for November 2021

WITH clinic_profit AS (
    SELECT
        cl.city,
        cl.cid,
        cl.clinic_name,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
        ON cl.cid = cs.cid
       AND MONTH(cs.datetime) = 11
       AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e
        ON cl.cid = e.cid
       AND MONTH(e.datetime) = 11
       AND YEAR(e.datetime) = 2021
    GROUP BY cl.city, cl.cid, cl.clinic_name
),

ranked_clinics AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY city
            ORDER BY profit DESC
        ) AS profit_rank
    FROM clinic_profit
)

SELECT
    city,
    cid,
    clinic_name,
    profit
FROM ranked_clinics
WHERE profit_rank = 1
ORDER BY city;


-- 5 Second least profitable clinic in each state for November 2021

WITH clinic_profit AS (
    SELECT
        cl.state,
        cl.cid,
        cl.clinic_name,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
        ON cl.cid = cs.cid
       AND MONTH(cs.datetime) = 11
       AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e
        ON cl.cid = e.cid
       AND MONTH(e.datetime) = 11
       AND YEAR(e.datetime) = 2021
    GROUP BY cl.state, cl.cid, cl.clinic_name
),

ranked_state_clinics AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY state
            ORDER BY profit ASC
        ) AS profit_rank
    FROM clinic_profit
)

SELECT
    state,
    cid,
    clinic_name,
    profit
FROM ranked_state_clinics
WHERE profit_rank = 2
ORDER BY state;