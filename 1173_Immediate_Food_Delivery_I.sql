-- 🔒 LeetCode Premium Problem 1173: Immediate Food Delivery I
-- Difficulty: Easy
-- Category: Database (SQL)

/*
================================================================================
📌 PROBLEM STATEMENT
================================================================================
Table: Delivery
+-----------------------------+---------+

| Column Name                 | Type    |
+-----------------------------+---------+

| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
- delivery_id is the primary key of this table.
- The table holds information about food delivery to customers who make orders 
  at some date and specify a preferred delivery date (which is the same as the 
  order date or after it).

--------------------------------------------------------------------------------
💡 BUSINESS LOGIC & CORE TASK:
--------------------------------------------------------------------------------
- Immediate Order: If the customer's preferred delivery date is the SAME as 
  the order date (order_date = customer_pref_delivery_date).
- Scheduled Order: If the preferred delivery date is AFTER the order date.

Task: Write an SQL query to find the percentage of immediate orders in the table, 
      rounded to 2 decimal places.

================================================================================
📊 EXAMPLE DATASET & DRY RUN VIA EXECUTION TRACE
================================================================================
Input `Delivery` Table:
+-------------+-------------+------------+-----------------------------+--------+

| delivery_id | customer_id | order_date | customer_pref_delivery_date | Type   |
+-------------+-------------+------------+-----------------------------+--------+

| 1           | 1           | 2019-08-01 | 2019-08-01                  | IMMED  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  | IMMED  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  | SCHED  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  | IMMED  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  | SCHED  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  | SCHED  |
+-------------+-------------+------------+-----------------------------+--------+

Expected Output Table:
+----------------------+

| immediate_percentage |
+----------------------+

| 50.00                |
+----------------------+

Explanation & Breakdown:
- Total Orders Count = 6
- Immediate Orders (delivery_id: 1, 2, 4) = 3
- Mathematical Formula = (3 / 6) * 100 = 50.00%

================================================================================
🧠 STRUCTURAL APPROACH & OPTIMIZATION NOTES
================================================================================
1. Avoiding Intermittent Subqueries/CTEs:
   Instead of running multiple scans via separate CTE counts for total and filtered 
   subsets, we compute the percentage inline within a single table pass.

2. Preventing Implicit Integer Division Truncation:
   Many SQL dialects (like SQL Server/PostgreSQL) perform strict integer division 
   if whole values are processed. Using conditional flag floating multipliers 
   (1.0 instead of 1) implicitly casts types to decimal vectors before evaluation.

3. AVG() Shortcut Vector Optimization:
   Taking the AVG() of a boolean condition evaluated as 1.0 or 0.0 intrinsically 
   calculates (Sum of Matches / Count of Rows) in one unified operation.
*/

-- =============================================================================
-- 🚀 OPTIMIZED HIGH-PERFORMANCE SQL SOLUTION
-- =============================================================================
SELECT 
    ROUND(
        AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1.0 ELSE 0.0 END) * 100, 
        2
    ) AS immediate_percentage
FROM Delivery;
