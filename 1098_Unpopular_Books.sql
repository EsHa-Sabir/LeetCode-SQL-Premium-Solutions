-- =========================================================================
-- LEETCODE PROBLEM: 1098. Unpopular Books
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Books
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| book_id       | int     |
| name          | varchar |
| available_from| date    |
+---------------+---------+
book_id is the primary key of this table.

Table: Orders
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| order_id      | int     |
| book_id       | int     |
| quantity      | int     |
| dispatch_date | date    |
+---------------+---------+
order_id is the primary key of this table.

GOAL:
Write an SQL query that reports all books that have sold LESS THAN 10 copies 
in the last year, excluding books that have been available for less than 
1 month from today. 

Assume today's date is '2019-06-23'.
Return the result table in any order.

EXAMPLE WALKTHROUGH:
Input Books Table:
+---------+--------------------+----------------+

| book_id | name               | available_from |
+---------+--------------------+----------------+

| 1       | "Kalila wa Dimna"  | 2010-01-01     |
| 2       | "28 Days Later"    | 2016-08-01     |
| 3       | "The Hunger Games" | 2019-06-03     |
| 4       | "Super Powered"    | 2019-06-02     |
| 5       | "The Words of Way" | 2018-07-26     |
+---------+--------------------+----------------+

Input Orders Table:
+----------+---------+----------+---------------+

| order_id | book_id | quantity | dispatch_date |
+----------+---------+----------+---------------+

| 1        | 1       | 2        | 2018-07-26    |
| 2        | 1       | 7        | 2018-11-05    |
| 3        | 3       | 8        | 2019-06-11    |
| 4        | 4       | 6        | 2019-06-05    |
| 5        | 1       | 2        | 2018-01-02    |
| 6        | 5       | 9        | 2019-02-02    |
| 7        | 5       | 8        | 2019-05-01    |
+----------+---------+----------+---------------+

Output:
+---------+--------------------+

| book_id | name               |
+---------+--------------------+

| 1       | "Kalila wa Dimna"  |
| 2       | "28 Days Later"    |
+---------+--------------------+
*/

-- =========================================================================
-- HIGHLY OPTIMIZED SOLUTION (MySQL)
-- =========================================================================

SELECT 
    b.book_id, 
    b.name
FROM Books b
LEFT JOIN Orders o 
    ON b.book_id = o.book_id 
    -- Optimization: Direct conditional join fully utilizes B-Tree indexes
    AND o.dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
-- Filter: Instantly drops books published less than 1 month ago before grouping
WHERE b.available_from <= '2019-05-23'
GROUP BY b.book_id, b.name
-- Check: Catches low performing books (IFNULL ensures 0-sale records are matched)
HAVING IFNULL(SUM(o.quantity), 0) < 10;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC & PERFORMANCE INSIGHTS:
-- 1. `WHERE b.available_from <= '2019-05-23'` executes first, shrinking the base 
--    Books volume and optimizing memory footprint early on.
-- 2. Instead of building temporary structures (like CTEs/Subqueries) in RAM, 
--    injecting the date condition straight into the `LEFT JOIN ... AND` clause 
--    allows the query optimizer to scan physical indexes directly.
-- 3. Books without matching sales records retain active rows via NULL placeholders.
-- 4. `IFNULL(SUM(o.quantity), 0)` converts empty/unordered products securely into a 
--    0 numeric state, ensuring they safely pass the `< 10` execution barrier.
-- =========================================================================
