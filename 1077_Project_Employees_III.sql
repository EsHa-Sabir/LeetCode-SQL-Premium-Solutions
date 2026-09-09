/*
================================================================================
LEETCODE PROBLEM 1077: Project Employees III
Difficulty: Medium
Category: Database (MySQL)
================================================================================

Problem Description:
Write an SQL query that reports the most experienced employees in each project. 
In case of a tie, report all employees with the maximum number of experience years.

Return the result table in any order.

The query result format is in the following example.

--------------------------------------------------------------------------------
Database Schema & Tables:

1. Table: Project
+-------------+---------+

| Column Name | Type    |
+-------------+---------+

| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.

2. Table: Employee
+------------------+---------+

| Column Name      | Type    |
+------------------+---------+

| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.

--------------------------------------------------------------------------------
Example 1:

Input:
Project table:
+-------------+-------------+

| project_id  | employee_id |
+-------------+-------------+

| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+

| employee_id | name   | experience_years |
+-------------+--------+------------------+

| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 3                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Output:
+-------------+-------------+

| project_id  | employee_id |
+-------------+-------------+

| 1           | 1           |
| 1           | 3           |
| 2           | 1           |
+-------------+-------------+

Explanation:
- For Project 1, employee 1 and 3 both have the maximum experience of 3 years (Tie).
- For Project 2, employee 1 has 3 years of experience while employee 4 has 2 years.
================================================================================
*/

-- Your 100% Correct & Optimized Solution:
WITH jointable AS (
    SELECT 
        p.project_id,
        p.employee_id,
        e.experience_years 
    FROM Project p 
    JOIN Employee e 
      ON p.employee_id = e.employee_id
),
performrnk AS (
    SELECT 
        project_id,
        employee_id,
        experience_years,
        RANK() OVER(PARTITION BY project_id ORDER BY experience_years DESC) AS rnk 
    FROM jointable
)
SELECT 
    project_id,
    employee_id 
FROM performrnk 
WHERE rnk = 1;
