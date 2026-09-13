-- =========================================================================
-- LEETCODE PROBLEM: 1113. Reported Posts
-- DIFFICULTY: Easy
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Actions
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| user_id       | int     |
| post_id       | int     |
| action_date   | date    |
| action        | enum    |
| extra         | varchar |
+---------------+---------+

GOAL:
Write an SQL query that reports the number of posts reported yesterday (Assume today is '2019-07-05') 
for each report reason. Assume yesterday is '2019-07-04'.
Note: Each post should be counted only once per reason.
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL)
-- =========================================================================

SELECT 
    extra AS report_reason, 
    COUNT(DISTINCT post_id) AS report_count 
FROM Actions  
WHERE action = 'report' 
  AND action_date = '2019-07-04' 
GROUP BY extra;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. Index / Stream Scan filters logs down using precise constants ('report' and '2019-07-04').
-- 2. `GROUP BY extra` dynamically bundles strings tracking specific validation reasons.
-- 3. `COUNT(DISTINCT post_id)` enforces algorithmic constraints by filtering multi-user 
--    and multi-action spam, logging strictly atomic interactions.
-- =========================================================================
