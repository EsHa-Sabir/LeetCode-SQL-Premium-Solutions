-- 🔒 LeetCode Premium Problem 1194: Tournament Winners
-- Difficulty: Hard
-- Category: Database (SQL)

/*
================================================================================
📌 PROBLEM STATEMENT
================================================================================
Table: Players
+-------------+---------+

| Column Name | Type    |
+-------------+---------+

| player_id   | int     |
| group_id    | int     |
+-------------+---------+
player_id is the primary key of this table.
Each row of this table indicates the group of each player.

Table: Matches
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| match_id      | int     |
| first_player  | int     |
| second_player | int     |
| first_score   | int     |
| second_score  | int     |
+---------------+---------+
match_id is the primary key of this table.
Each row is a record of a match. first_player and second_player contain the 
player_id of each match. first_score and second_score contain the number 
of points of the first_player and second_player respectively.
You may assume that, in each match, players belong to the same group.

--------------------------------------------------------------------------------
💡 BUSINESS LOGIC & TIE-BREAKER CONDITIONS:
--------------------------------------------------------------------------------
The winner in each group is the player who scored the MAXIMUM TOTAL POINTS 
within the group. In the case of a tie, the player with the LOWEST player_id 
wins the group.

Write an SQL query to find the winner in each group.
Return the result table in any order.

================================================================================
📊 EXAMPLE DATASET & DRY RUN
================================================================================
Input Players Table:
+-----------+----------+

| player_id | group_id |
+-----------+----------+

| 15        | 1        |
| 25        | 1        |
| 30        | 1        |
| 45        | 1        |
| 10        | 2        |
| 35        | 2        |
| 50        | 2        |
| 20        | 3        |
| 40        | 3        |
+-----------+----------+

Input Matches Table:
+----------+--------------+---------------+-------------+--------------+

| match_id | first_player | second_player | first_score | second_score |
+----------+--------------+---------------+-------------+--------------+

| 1        | 15           | 45            | 3           | 0            |
| 2        | 30           | 25            | 1           | 2            |
| 3        | 45           | 15            | 2           | 2            |
| 4        | 40           | 20            | 5           | 2            |
| 5        | 35           | 50            | 1           | 1            |
+----------+--------------+---------------+-------------+--------------+

Output Table:
+------------+-----------+

| group_id   | player_id |
+------------+-----------+

| 1          | 15        |
| 2          | 35        |
| 3          | 40        |
+------------+-----------+

================================================================================
🧠 APPROACH & LOGICAL BREAKDOWN
================================================================================
1. Extract Both Player Scores: 
   Since a player can be either first_player or second_player, we separate the 
   matches into two internal subsets to simplify aggregations.
2. Unify Streams via UNION ALL:
   Merge both scores into a single structural block.
3. Left Join with Players Table (Crucial Edge-case):
   We group from the master 'Players' table to ensure that even players who did 
   not participate or score any goals (0 scores) are preserved accurately.
4. Window Ranking & Tie-Breaking:
   Using ROW_NUMBER() partitioned by group_id, sorted by total_score DESC, 
   and breaking ties via player_id ASC.
*/

-- =============================================================================
-- 🚀 OPTIMIZED HIGH-PERFORMANCE SQL SOLUTION
-- =============================================================================
WITH firstplayer AS (
    SELECT m.first_player AS player_id, m.first_score AS score 
    FROM Matches m
),  
secondplayer AS (
    SELECT m.second_player AS player_id, m.second_score AS score 
    FROM Matches m
), 
combinetable AS (
    SELECT player_id, score FROM firstplayer 
    UNION ALL 
    SELECT player_id, score FROM secondplayer
),
totatscore AS (
    SELECT 
        p.group_id,
        p.player_id,
        SUM(COALESCE(c.score, 0)) AS total_score
    FROM Players p
    LEFT JOIN combinetable c ON p.player_id = c.player_id
    GROUP BY p.group_id, p.player_id
), 
performrnk AS (
    SELECT 
        group_id,
        player_id,
        ROW_NUMBER() OVER(PARTITION BY group_id ORDER BY total_score DESC, player_id ASC) AS rnk  
    FROM totatscore
)
SELECT group_id, player_id 
FROM performrnk 
WHERE rnk = 1;
