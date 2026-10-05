-- 🔒 LeetCode Premium Problem 1205: Monthly Transactions II
-- Difficulty: Medium
-- Category: Database (SQL)

/*
================================================================================
📌 LEETCODE ACTUAL PROBLEM STATEMENT
================================================================================
Table: Transactions
+----------------+---------+

| Column Name    | Type    |
+----------------+---------+

| id             | int     |
| country        | varchar |
| state          | enum    |
| amount         | int     |
| trans_date     | date    |
+----------------+---------+
- id is the primary key of this table.
- The table has information about incoming transactions.
- The state column is an enum of type ["approved", "declined"].

Table: Chargebacks
+----------------+---------+

| Column Name    | Type    |
+----------------+---------+

| trans_id       | int     |
| trans_date     | date    |
+----------------+---------+
- trans_id is a foreign key to the id column of the Transactions table.
- Each chargeback corresponds to a transaction that happened in the past, but the 
  chargeback date might be different from the original transaction date.

--------------------------------------------------------------------------------
💡 BUSINESS LOGIC & CORE TASK:
--------------------------------------------------------------------------------
Write an SQL query to find for each month and country: the number of approved 
transactions and their total amount, the number of chargebacks and their total amount.

Note: If in any month there are no approved transactions and no chargebacks for 
      a country, you must ignore that row (do not output rows with all zeros).

Return the result table in ANY order.

================================================================================
📊 ACTUAL LEETCODE EXAMPLE DOCK
================================================================================
Input `Transactions` Table:
+-----+---------+----------+--------+------------+

| id  | country | state    | amount | trans_date |
+-----+---------+----------+--------+------------+

| 101 | US      | approved | 1000   | 2019-05-18 |
| 102 | FR      | approved | 2000   | 2019-05-19 |
| 103 | US      | approved | 3000   | 2019-06-10 |
| 104 | US      | declined | 4000   | 2019-06-13 |
| 105 | FR      | approved | 5000   | 2019-06-15 |
+-----+---------+----------+--------+------------+

Input `Chargebacks` Table:
+----------+------------+

| trans_id | trans_date |
+----------+------------+

| 102      | 2019-05-29 |
| 101      | 2019-06-30 |
| 105      | 2019-06-20 |
+----------+------------+

Expected Output Table:
+---------+---------+----------------+-----------------+------------------+-------------------+

| month   | country | approved_count | approved_amount | chargeback_count | chargeback_amount |
+---------+---------+----------------+-----------------+------------------+-------------------+

| 2019-05 | US      | 1              | 1000            | 0                | 0                 |
| 2019-05 | FR      | 1              | 2000            | 1                | 2000              |
| 2019-06 | US      | 1              | 3000            | 1                | 1000              |
| 2019-06 | FR      | 1              | 5000            | 1                | 5000              |
+---------+---------+----------------+-----------------+------------------+-------------------+

--------------------------------------------------------------------------------
🔎 STEP-BY-STEP EXPLANATION DEEP DIVE:
--------------------------------------------------------------------------------
- For '2019-05' (US): Transaction 101 was approved (\$1000). No chargebacks occurred in May for US.
- For '2019-05' (FR): Transaction 102 was approved (\$2000) and also chargebacked (\$2000) 
                      within the same month.
- For '2019-06' (US): Transaction 103 was approved (\$3000). Transaction 101 (from May) 
                      was chargebacked in June (\$1000). Both merge into the June US bucket.
- For '2019-06' (FR): Transaction 105 was approved (\$5000) and chargebacked (\$5000) in June.
                      Transaction 104 was declined, so it is completely ignored.

================================================================================
🧠 STRUCTURAL APPROACH & OPTIMIZATION NOTES
================================================================================
1. Unified Stream Synthesis over Full Joins:
   Instead of using cross-dialect outer joins (which fail in MySQL native engines), 
   we align columns structurally into a single dataset using UNION ALL.
2. Chronological Alignment:
   Approved records map to trans_date from Transactions, while Chargeback records 
   map to trans_date from Chargebacks.
3. Post-Aggregation Zero Elimination:
   The HAVING clause drops empty buckets to ensure strict conformance with the problem rules.
*/

-- =============================================================================
-- 🚀 OPTIMIZED HIGH-PERFORMANCE SQL SOLUTION (Cross-Engine Compliant)
-- =============================================================================
WITH CombinedData AS (
    -- Subset A: Extract Approved Transactions
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        1 AS approved_count,
        amount AS approved_amount,
        0 AS chargeback_count,
        0 AS chargeback_amount
    FROM Transactions
    WHERE state = 'approved'

    UNION ALL

    -- Subset B: Extract Valid Chargebacks
    SELECT 
        DATE_FORMAT(c.trans_date, '%Y-%m') AS month,
        t.country,
        0 AS approved_count,
        0 AS approved_amount,
        1 AS chargeback_count,
        t.amount AS chargeback_amount
    FROM Chargebacks c
    JOIN Transactions t ON c.trans_id = t.id
)
-- Aggregate both streams by Chronological Month and Spatial Country Nodes
SELECT 
    month,
    country,
    SUM(approved_count) AS approved_count,
    SUM(approved_amount) AS approved_amount,
    SUM(chargeback_count) AS chargeback_count,
    SUM(chargeback_amount) AS chargeback_amount
FROM CombinedData
GROUP BY month, country
HAVING approved_count > 0 
    OR approved_amount > 0 
    OR chargeback_count > 0 
    OR chargeback_amount > 0;
