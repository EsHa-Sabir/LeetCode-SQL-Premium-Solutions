/*

### LeetCode 603: Consecutive Available Seats (🔒 Premium / Easy)

1. 📋 Table Structure (The Schema)

Table: Cinema
+-------------+------+ 

| Column Name | Type |
+-------------+------+ 

| seat_id     | int  |
| free        | bi   |
+-------------+------+ 

* seat_id is an auto-increment primary key column for this table.
* Each row of this table indicates whether the seat is free or not.
1 means the seat is free, and 0 means the seat is occupied.

1. 🎯 Demand & Rules (The Core Requirements)

Write a solution to report all the consecutive available seats in the cinema. 

⚠️ Strict Conditions: 

1. A seat is considered available only if its 'free' status is equal to 1.
2. "Consecutive" means there must be TWO or more free seats next to each other
in sequence (e.g., seats 3 and 4). Single isolated free seats must be excluded.

📊 Output Sorting Rule:
Return the result table ordered by seat_id in ascending order (ASC). 

1. 📊 Example 1

Input:
Cinema table:
+---------+------+ 

| seat_id | free |
+---------+------+ 

| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+ 

🔍 Explanation: 

* Seat 1: It is free (1), but its neighbor (Seat 2) is occupied (0). It is isolated.
* Seat 2: Occupied (0) -> Automatically rejected.
* Seat 3, 4, and 5: All three are free (1) and right next to each other in sequence.
They form a consecutive chain of 2 or more available seats, making all three IDs valid.

Expected Output:
+---------+ 

| seat_id |
+---------+ 

| 3       |
| 4       |
| 5       |
+---------+ 

### ================================================================================
My 100% Optimized Solution (Bidirectional Window Look-Ahead):

*/ 

WITH CheckNeighbors AS (
SELECT
seat_id,

LAG(seat_id) OVER(ORDER BY seat_id) AS prev_seat,

LEAD(seat_id) OVER(ORDER BY seat_id) AS next_seat
FROM Cinema
WHERE free = 1
)
SELECT seat_id
FROM CheckNeighbors
WHERE seat_id - 1 = prev_seat 
OR seat_id + 1 = next_seat  
ORDER BY seat_id;
