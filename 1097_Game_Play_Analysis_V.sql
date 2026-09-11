-- =========================================================================
-- LEETCODE PROBLEM: 1097. Game Play Analysis V
-- DIFFICULTY: Hard
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Activity
+--------------+---------+

| Column Name  | Type    |
+--------------+---------+

| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.

DEFINITIONS:
1. Install Date: A player's first login day (i.e., MIN(event_date)).
2. Day 1 Retention: The proportion of players with an install date X who 
   logged back in the exact next day, rounded to 2 decimal places.

GOAL:
Write an SQL query to report each install date, total installs, and day 1 retention rate.
The result table can be returned in any order.

EXAMPLE WALKTHROUGH:
Input Table:
+-----------+-----------+------------+--------------+

| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+

| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2016-06-25 | 1            |
| 3         | 1         | 2016-03-01 | 0            |
| 3         | 4         | 2016-07-03 | 5            |
+-----------+-----------+------------+--------------+

Output Table:
+------------+----------+-----------------+

| install_dt | installs | day1_retention  |
+------------+----------+-----------------+

| 2016-03-01 | 2        | 0.50            |
| 2016-06-25 | 1        | 0.00            |
+------------+----------+-----------------+
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL)
-- =========================================================================

WITH InstallDate AS (
    -- Step 1: Find the absolute first login (install) date for each player
    SELECT 
        player_id, 
        MIN(event_date) AS install_dt 
    FROM Activity 
    GROUP BY player_id
)

-- Step 2: Calculate total installs and day 1 retention using a LEFT JOIN
SELECT 
    i.install_dt,
    COUNT(i.player_id) AS installs,
    ROUND(
        COUNT(a.player_id) / COUNT(i.player_id), 
        2
    ) AS day1_retention
FROM InstallDate i
LEFT JOIN Activity a 
    ON i.player_id = a.player_id 
    AND a.event_date = DATE_ADD(i.install_dt, INTERVAL 1 DAY)
GROUP BY i.install_dt;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `InstallDate` CTE extracts the structural baseline of initial installs.
-- 2. The `LEFT JOIN` safely pairs consecutive activity (install_dt + 1 day).
--    Unmatched target dates seamlessly default to NULL fields.
-- 3. `COUNT(i.player_id)` groups and counts total incoming new signups.
-- 4. `COUNT(a.player_id)` systematically bypasses NULL records, cleanly
--    isolating only the retention metrics for consecutive day active users.
-- =========================================================================
