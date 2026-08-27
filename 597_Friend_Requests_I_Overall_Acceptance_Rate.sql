/*

### LeetCode 597: Friend Requests I: Overall Acceptance Rate (🔒 Premium / Easy)

1. 📋 Table Structure (The Schema)

Table: FriendRequest
+----------------+---------+ 

| Column Name    | Type    |
+----------------+---------+ 

| sender_id      | int     |
| send_to_id     | int     |
| request_date   | date    |
+----------------+---------+ 

* This table may contain duplicate rows.
* This table contains the ID of the user who sent the request, the ID of the
user who received the request, and the date when the request was sent.

Table: RequestAccepted
+----------------+---------+ 

| Column Name    | Type    |
+----------------+---------+ 

| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+ 

* This table may contain duplicate rows.
* This table contains the ID of the user who sent the request, the ID of the
user who accepted the request, and the date when the request was accepted.

1. 🎯Demand & Rules (The Core Requirements)

Write a solution to find the overall acceptance rate of friend requests.
The formula is:
Overall Acceptance Rate = Total Unique Accepted Requests / Total Unique Sent Requests 

⚠️ Strict Edge Cases Handled: 

1. Duplicates Removal: A sender may send multiple requests to the same receiver,
or a receiver may log multiple acceptances. Only UNIQUE pairs must be counted.
2. Zero-Division Safeguard: If the FriendRequest table is completely empty (0 sent requests),
the query must return 0.00 instead of crashing.
3. Decimal Precision: The final rate must be rounded to exactly 2 decimal places.

The output column name must be exact 'accept_rate'. 

1. 📊 Example 1

Input:
FriendRequest table:
+-----------+------------+--------------+ 

| sender_id | send_to_id | request_date |
+-----------+------------+--------------+ 

| 1         | 2          | 2016/06/01   |
| 1         | 3          | 2016/06/01   |
| 1         | 4          | 2016/06/01   |
| 2         | 3          | 2016/06/02   |
| 3         | 4          | 2016/06/09   |
+-----------+------------+--------------+ 

RequestAccepted table:
+--------------+-------------+-------------+ 

| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+ 

| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/10  |
| 3            | 4           | 2016/06/12  | <-- Duplicate row (ignored)
+--------------+-------------+-------------+ 

🔍 Explanation: 

* Total unique requests sent: 5 (pairs: 1->2, 1->3, 1->4, 2->3, 3->4)
* Total unique requests accepted: 4 (pairs: 1->2, 1->3, 2->3, 3->4)
* Rate = 4 / 5 = 0.80

Expected Output:
+-------------+ 

| accept_rate |
+-------------+ 

| 0.80        |
+-------------+ 

### ================================================================================
My 100% Secure & Highly Optimized Solution (No-Join Stream Scan):

*/ 

SELECT
IFNULL(
CAST(
-- Stream 1: Direct lookup count for unique acceptances
((SELECT COUNT(DISTINCT requester_id, accepter_id) FROM RequestAccepted)
/
-- Stream 2: Direct lookup count for unique sent requests with 0-trap protection
NULLIF((SELECT COUNT(DISTINCT sender_id, send_to_id) FROM FriendRequest), 0)) as DECIMAL(10,2)
),
0.00
) AS accept_rate;
