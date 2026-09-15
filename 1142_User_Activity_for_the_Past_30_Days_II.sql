-- =========================================================================
-- LEETCODE PROBLEM: 1142. User Activity for the Past 30 Days II
-- DIFFICULTY: Easy
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Activity
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+

GOAL:
Write an SQL query to find the average number of sessions per user for a period 
of 30 days ending 2019-07-27 inclusive. Round the result to 2 decimal places. 
If there are no users in the time period, return 0.00.
*/

-- =========================================================================
-- HIGHLY OPTIMIZED SOLUTION (MySQL)
-- =========================================================================

SELECT 
    IFNULL(
        ROUND(COUNT(DISTINCT session_id) / COUNT(DISTINCT user_id), 2), 
        0.00
    ) AS average_sessions_per_user   
FROM Activity 
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27';

-- =========================================================================
-- INTERNAL EXECUTION LOGIC & PERFORMANCE INSIGHTS:
-- 1. The `WHERE` filter isolates rows belonging strictly to the targeted 30-day window early.
-- 2. `COUNT(DISTINCT session_id)` captures unique system activities while preventing duplicate logs.
-- 3. Direct aggregate scaling processes the calculation in a single scan without heavy table sub-joins.
-- 4. `IFNULL(..., 0.00)` ensures fallback verification for empty datasets.
-- =========================================================================
