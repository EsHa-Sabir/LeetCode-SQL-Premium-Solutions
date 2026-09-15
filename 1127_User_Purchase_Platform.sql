-- =========================================================================
-- LEETCODE PROBLEM: 1127. User Purchase Platform
-- DIFFICULTY: Hard
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Spending
+-------------+---------+

| Column Name | Type    |
+-------------+---------+

| user_id     | int     |
| spend_date  | date    |
| platform    | enum    |
| amount      | int     |
+-------------+---------+
There is no primary key for this table. It may contain duplicate rows.
The platform column is an ENUM type of ('desktop', 'mobile').

GOAL:
Write an SQL query to find the total amount spent and the total number of users, 
grouped by each spend_date and platform.

CRITICAL RULES:
1. If a user purchased using ONLY desktop on a specific date, their purchase 
   belongs to 'desktop'.
2. If a user purchased using ONLY mobile on a specific date, their purchase 
   belongs to 'mobile'.
3. If a user purchased using BOTH desktop and mobile on a specific date, their 
   purchase belongs to 'both' dynamically.
4. ZERO-ROW PRESERVATION: Every distinct date MUST display all three platform segments 
   ('desktop', 'mobile', 'both'). If a segment has no active users, report total_amount 
   as 0 and total_users as 0.

EXAMPLE WALKTHROUGH:
Input Spending Table:
+---------+------------+----------+--------+

| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+

| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+

Output:
+------------+----------+--------------+-------------+

| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+

| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+
*/

-- =========================================================================
-- OPTIMIZED MASTER-GRID SOLUTION (MySQL)
-- =========================================================================

WITH findtotal AS (
    -- Step 1: Consolidate user spending per day to resolve dynamic user categories
    SELECT 
        user_id,
        spend_date,
        CASE 
            WHEN COUNT(DISTINCT platform) = 2 THEN 'both' 
            ELSE MAX(platform) 
        END AS platform,
        SUM(amount) AS total_amount 
    FROM Spending 
    GROUP BY user_id, spend_date
),
platformtable AS (
    -- Step 2: Establish the full structural domain criteria explicitly
    SELECT 'desktop' AS platform 
    UNION 
    SELECT 'mobile' 
    UNION 
    SELECT 'both'
), 
crossjoin AS (
    -- Step 3: Scaffold an exhaustive skeletal layout pairing distinct dates with all platform targets
    SELECT DISTINCT s.spend_date, p.platform 
    FROM Spending s 
    CROSS JOIN platformtable p
) 

-- Step 4: Map actual calculated conversions back into the skeleton template
SELECT 
    c.spend_date,
    c.platform,
    IFNULL(SUM(f.total_amount), 0) AS total_amount,
    COUNT(f.user_id) AS total_users  
FROM crossjoin c 
LEFT JOIN findtotal f 
    ON c.spend_date = f.spend_date 
    AND c.platform = f.platform 
GROUP BY c.spend_date, c.platform;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC & ARCHITECTURE:
-- 1. `findtotal` groups by user and date early, forcing multi-device logs to collapse 
--    into unified profiles, successfully preventing multi-count arithmetic errors.
-- 2. `crossjoin` generates empty layout placeholders using a controlled, small footprint 
--    CROSS JOIN, protecting system memory pipelines from row amplification attacks.
-- 3. The final outer `LEFT JOIN` fits actual computed entities into the template.
-- 4. `COUNT(f.user_id)` safely skips empty states, keeping structural placeholder cells 
--    anchored to 0 instead of defaulting to corrupt NULL responses.
-- =========================================================================
