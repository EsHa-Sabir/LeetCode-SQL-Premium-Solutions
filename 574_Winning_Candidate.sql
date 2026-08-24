/*🔒 LeetCode 574: Winning Candidate 

Table:Candidate
| Column Name | Type    |
+-------------+---------+

| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the id and the name of a candidate.
Use code with caution.

Table: Vote
| Column Name  | Type    |
+--------------+---------+

| id           | int     |
| candidateId  | int     |
+--------------+---------+
id is an auto-increment primary key (column with unique values).
candidateId is a foreign key (reference column) to id from the Candidate table.
Each row of this table contains information about the candidate who received a vote.

Write an SQL query to report the name of the winning candidate (the candidate who received the most votes). 
The test cases are generated so that there is always a unique winner.

Example 1
Input:

Candidate table:
| id | name |
+----+------+

| 1  | A    |
| 2  | B    |
| 3  | C    |
| 4  | D    |
| 5  | E    |
+----+------+

Vote table:
| id | candidateId |
+----+-------------+

| 1  | 2           |
| 2  | 4           |
| 3  | 3           |
| 4  | 2           |
| 5  | 5           |
+----+-------------+

Expected Output:
| name |
+------+

| B    |
+------+

*/

WITH votecount AS (
    SELECT c.name, COUNT(v.id) AS total_vote 
    FROM Candidate c 
    JOIN Vote v ON c.id = v.candidateId 
    GROUP BY v.candidateId, c.name 
) 
SELECT name 
FROM votecount 
ORDER BY total_vote DESC 
LIMIT 1;
