-- 🔒 LeetCode Premium Problem 1212: Team Scores in Football Tournament
-- Difficulty: Medium
-- Category: Database (SQL)

/*
================================================================================
📌 PROBLEM STATEMENT
================================================================================
Table: Teams
+---------------+----------+

| Column Name   | Type     |
+---------------+----------+

| team_id       | int      |
| team_name     | varchar  |
+---------------+----------+
team_id is the primary key of this table.
Each row of this table represents a single football team.

Table: Matches
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| match_id      | int     |
| host_team     | int     |
| guest_team    | int     |
| host_goals    | int     |
| guest_goals   | int     |
+---------------+---------+
match_id is the primary key of this table.
Each row is a record of a finished match between two different teams.

--------------------------------------------------------------------------------
💡 BUSINESS LOGIC & SCORING MATRIX:
--------------------------------------------------------------------------------
Points are awarded as follows:
- Win (More goals than opponent): 3 points
- Draw (Same number of goals): 1 point
- Loss (Fewer goals than opponent): 0 points

Write an SQL query that selects the team_id, team_name, and num_points of each 
team in the tournament after all described matches.

Ordering Constraints:
- Order by num_points in decreasing order (DESC).
- In case of a tie, order by team_id in increasing order (ASC).

================================================================================
📊 EXAMPLE DATASET & DRY RUN
================================================================================
Input Teams Table:
+-----------+-------------+

| team_id   | team_name   |
+-----------+-------------+

| 10        | Leetcode FC |
| 20        | NewYork FC  |
| 30        | Atlanta FC  |
| 40        | Chicago FC  |
| 50        | Toronto FC  |
+-----------+-------------+

Input Matches Table:
+----------+-----------+------------+------------+-------------+

| match_id | host_team | guest_team | host_goals | guest_goals |
+----------+-----------+------------+------------+-------------+

| 1        | 10        | 20         | 3          | 0           |
| 2        | 30        | 10         | 2          | 2           |
| 3        | 10        | 50         | 5          | 1           |
| 4        | 20        | 30         | 1          | 0           |
| 5        | 50        | 30         | 1          | 0           |
+----------+-----------+------------+------------+-------------+

Output Table:
+-----------+-------------+------------+

| team_id   | team_name   | num_points |
+-----------+-------------+------------+

| 10        | Leetcode FC | 7          |
| 20        | NewYork FC  | 3          |
| 50        | Toronto FC  | 3          |
| 30        | Atlanta FC  | 1          |
| 40        | Chicago FC  | 0          |
+-----------+-------------+------------+

================================================================================
🧠 APPROACH & LOGICAL BREAKDOWN
================================================================================
1. Dynamic Partitioning via CASE WHEN:
   Points allocation shifts based on spatial roles (host vs guest). We run 
   two corresponding matrix maps.
2. Cross-Stream Consolidation (UNION ALL):
   Merge calculated host points and guest points into a clean vertical array.
3. Master Left Join Integrity (Crucial Edge-case):
   Left joining Teams to our point aggregations ensures teams with no matches 
   (like Chicago FC) are preserved with clean null-to-zero maps (IFNULL).
4. Dual-Variable Sorting Constraints:
   ORDER BY num_points DESC, team_id ASC ensures explicit layout control.
*/

-- =============================================================================
-- 🚀 OPTIMIZED HIGH-PERFORMANCE SQL SOLUTION
-- =============================================================================
WITH HostTeam AS (
    SELECT 
        host_team,
        CASE 
            WHEN host_goals > guest_goals THEN 3 
            WHEN host_goals = guest_goals THEN 1 
            ELSE 0 
        END AS num_points 
    FROM Matches
), 
GuestTeam AS (
    SELECT 
        guest_team,
        CASE 
            WHEN host_goals < guest_goals THEN 3 
            WHEN host_goals = guest_goals THEN 1 
            ELSE 0 
        END AS num_points 
    FROM Matches
),
combinetables AS (
    SELECT host_team AS id, num_points FROM HostTeam 
    UNION ALL 
    SELECT guest_team AS id, num_points FROM GuestTeam
),
totalnumpoints AS (
    SELECT id, SUM(num_points) AS num_points 
    FROM combinetables 
    GROUP BY id
) 
SELECT 
    t.team_id,
    t.team_name,
    IFNULL(p.num_points, 0) AS num_points
FROM Teams t 
LEFT JOIN totalnumpoints p ON t.team_id = p.id
ORDER BY num_points DESC, t.team_id ASC;
