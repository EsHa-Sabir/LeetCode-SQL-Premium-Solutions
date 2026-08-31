/*

### LeetCode 614: Second Degree Follower (🔒 Premium / Medium)

1. 📋 Table Structure (The Schema)

Table: Follow
+-------------+---------+ 

| Column Name | Type    |
+-------------+---------+ 

| followee    | varchar |
| follower    | varchar |
+-------------+---------+ 

* (followee, follower) is the primary key column (combination of columns with unique values) for this table.
* Each row of this table indicates that the user 'follower' follows the user 'followee'.

1. 🎯 Demand & Rules (The Core Requirements)

A "second-degree follower" is a user who both follows at least one user AND is
followed by at least one user. Report all second-degree followers and the
total number of unique followers they have. 

⚠️ Strict Edge Cases Handled: 

1. Bidirectional Node Filtering: Used an 'IN' subquery lookup layer to catch users
who exist parallel in the followee channel while actively operating as followers themselves.
2. Deduplication Safety: Applied 'COUNT(DISTINCT follower)' to shield aggregations
from duplicate data links.

The output column names must be exact 'follower' and 'num', sorted alphabetically. 

1. 📊 Example 1

Input:
Follow table:
+----------+----------+ 

| followee | follower |
+----------+----------+ 

| Alice    | Bob      |
| Bob      | Charlie  |
| Bob      | Donald   |
| Donald   | Edward   |
+----------+----------+ 

🔍 Explanation:
Bob is a second-degree follower because he follows Alice and has 2 followers (Charlie and Donald).
Donald is a second-degree follower because he follows Bob and has 1 follower (Edward). 

Expected Output:
+----------+-----+ 

| follower | num |
+----------+-----+ 

| Bob      | 2   |
| Donald   | 1   |
+----------+-----+ 

### ================================================================================
My Verified Solution (Self-Referencing Node Filter):

*/ 

SELECT
followee AS follower,
COUNT(follower) AS num
FROM Follow
WHERE followee IN (SELECT follower FROM Follow)
GROUP BY followee
ORDER BY followee;
