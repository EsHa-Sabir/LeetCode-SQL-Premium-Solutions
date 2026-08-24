/*

### LeetCode 512: Game Play Analysis II (🔒 Premium / Easy)

Problem Statement:
Write an SQL query to report the device that each player logged in with for
the first time. 

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
Return a table with 'player_id' and their corresponding first 'device_id'.

*/ 

WITH GetDeviceId AS (
SELECT
player_id,
device_id,
ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC) AS rnk
FROM Activity
)
SELECT
player_id,
device_id
FROM GetDeviceId
WHERE rnk = 1;

