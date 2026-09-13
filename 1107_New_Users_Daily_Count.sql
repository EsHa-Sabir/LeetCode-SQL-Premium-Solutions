-- =========================================================================
-- LEETCODE PROBLEM: 1107. New Users Daily Count
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Traffic
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| user_id       | int     |
| activity      | enum    |
| activity_date | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.

GOAL:
Write an SQL query to report for every date within the last 90 days from today 
(Assume today is '2019-06-30'), the number of users that logged in for the 
first time on that date. 

Note: Output dates only if the user_count is greater than 0.
The result table can be returned in any order.
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL using CTE)
-- =========================================================================

WITH FilterTrafficTable AS (
    -- Step 1: Isolate the absolute first 'login' date for every unique user
    SELECT 
        user_id, 
        MIN(activity_date) AS login_date 
    FROM Traffic 
    WHERE activity = 'login' 
    GROUP BY user_id
) 

-- Step 2: Extract and aggregate records falling inside the exact rolling 90-day window
SELECT 
    login_date, 
    COUNT(user_id) AS user_count 
FROM FilterTrafficTable 
WHERE login_date BETWEEN '2019-04-02' AND '2019-06-30' 
GROUP BY login_date;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `FilterTrafficTable` creates an indexed/grouped memory state filtering out 
--    non-login traffic types and computing true base account activations.
-- 2. Main execution checks the date parameters directly. The inclusion bounds 
--    accounting for May's 31-day cycle maps precisely to '2019-04-02'.
-- 3. `COUNT(user_id)` sums active conversions per date segment, completely 
--    omitting any inactive dates from rendering in the final stream.
-- =========================================================================
