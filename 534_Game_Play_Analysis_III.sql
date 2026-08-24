### /*

### LeetCode 534: Game Play Analysis III (🔒 Premium / Medium)

Problem Statement:
Write an SQL query to report for each player and date, how many games played
so far by the player. That is, the total number of games played by the player
until that date (Cumulative Sum / Running Total). 

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

### Expected Output:
Return the result table with 'player_id', 'event_date', and the running total
aliased as 'games_played_so_far', sorted by player_id and event_date.

*/ 

SELECT
player_id,
event_date,
SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS games_played_so_far
FROM Activity;


