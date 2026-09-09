/*
================================================================================
LEETCODE PROBLEM 1076: Project Employees II
Difficulty: Easy
Category: Database (MySQL)
================================================================================

Problem Description:
Write an SQL query that reports all the projects that have the most employees.
Return the result table in any order.

--------------------------------------------------------------------------------
Database Schema & Tables:

1. Table: Project
+-------------+---------+

| Column Name | Type    |
+-------------+---------+

| project_id  | int     |
| employee_id | int     |
+-------------+---------+
* (project_id, employee_id) is the primary key of this table.
* employee_id is a foreign key to Employee table.
* Each row indicates that the employee with employee_id is working on the project 
  with project_id.

2. Table: Employee
+------------------+---------+

| Column Name      | Type    |
+------------------+---------+

| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
* employee_id is the primary key of this table.
* Each row contains information about one employee.

--------------------------------------------------------------------------------
Example:

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
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Output:
+-------------+

| project_id  |
+-------------+

| 1           |
+-------------+

Explanation:
The first project has 3 employees while the second one has 2.
================================================================================
*/

-- Your 100% Correct Solution:
WITH findcount AS (
    SELECT 
        project_id,
        COUNT(employee_id) AS total_count 
    FROM Project 
    GROUP BY project_id
)
SELECT project_id 
FROM findcount 
WHERE total_count = (
    SELECT MAX(total_count) 
    FROM findcount
) 
ORDER BY project_id;
