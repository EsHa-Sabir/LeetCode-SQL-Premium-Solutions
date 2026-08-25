/*

### LeetCode 578: Get Highest Answer Rate Question (🔒 Premium / Medium)

Problem Description:
The SurveyLog table contains logs of user activities regarding different survey questions. 

Table: SurveyLog
+-------------+---------+ 

| Column Name | Type    |
+-------------+---------+ 

| id          | int     |
| action      | enum    |
| question_id | int     |
| answer_id   | int     |
| q_num       | int     |
| timestamp   | int     |
+-------------+---------+ 

* This table may contain duplicate rows.
* action is an ENUM column of option values: 'show', 'answer', or 'skip'.
* Each row indicates that the user with ID = id performed an action with
regards to the question with ID = question_id at a certain timestamp.
* If the action is 'show', then answer_id is null.
* If the action is 'answer', then answer_id is not null.

Goal:
Write a solution to report the question that has the highest answer rate.
If multiple questions have the same highest answer rate, report the question
with the smallest question_id. 

The output column name must be exact 'survey_log'. 

### ================================================================================
🧮 Mathematical Formula:
Answer Rate = Total 'answer' actions / Total 'show' actions

Example 1:
Input:
SurveyLog table:
+----+--------+-------------+-----------+-------+-----------+ 

| id | action | question_id | answer_id | q_num | timestamp |
+----+--------+-------------+-----------+-------+-----------+ 

| 5  | show   | 285         | null      | 1     | 123       |
| 5  | answer | 285         | 124124    | 1     | 124       |
| 5  | show   | 369         | null      | 2     | 125       |
| 5  | skip   | 369         | null      | 2     | 126       |
+----+--------+-------------+-----------+-------+-----------+ 

Explanation: 

* Question 285: Shown 1 time, Answered 1 time. Rate = 1 / 1 = 1.0
* Question 369: Shown 1 time, Answered 0 times. Rate = 0 / 1 = 0.0
Question 285 has the highest answer rate.

Output:
+------------+ 

| survey_log |
+------------+ 

| 285        |
+------------+ 

### ================================================================================
My 100% Optimized Solution (With Integer Division & Tie-Breaker Fixes):

*/ 

WITH findcount AS (
SELECT
question_id,
SUM(IF(action='answer', 1, 0)) AS answer_count,
SUM(IF(action='show', 1, 0)) AS show_count
FROM SurveyLog
GROUP BY question_id
),
findanswerrate AS (
SELECT
question_id,
-- Multiplication by 1.0 ensures accurate floating-point division
(1.0 * answer_count) / show_count AS rate
FROM findcount
WHERE show_count > 0 -- Safe-side filter to prevent Divide-by-Zero crash
)
SELECT question_id AS survey_log
FROM findanswerrate
ORDER BY rate DESC, question_id ASC -- Primary sort by rate (DESC), secondary by ID (ASC) for ties
LIMIT 1;
