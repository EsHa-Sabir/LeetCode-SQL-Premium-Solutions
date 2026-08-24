/*

### LeetCode 569: Median Employee Salary (🔒 Premium / Hard)

Problem Statement:
Write an SQL query to find the median salary of each company.
Bonus points if you can solve it without using any built-in median functions. 

Table: Employee
+-------------+---------+ 

| Column Name | Type    |
+-------------+---------+ 

| id          | int     |
| company     | varchar |
| salary      | int     |
+-------------+---------+
id is the primary key for this table. 

Mathematical Logic Used:
A row is a median if its row number (rnk) falls within the range of:
total_count / 2  AND  (total_count / 2) + 1
This perfectly handles both Odd and Even total row constraints. 

### Expected Output:
Return the 'id', 'company', and 'salary' columns ordered by company and salary.

*/ 

WITH mediansalary AS (
SELECT
id,
company,
salary,
ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS rnk,
COUNT(*) OVER (PARTITION BY company) AS total_count
FROM Employee
)
SELECT
m.id,
m.company,
m.salary
FROM mediansalary m
WHERE m.rnk BETWEEN m.total_count / 2 AND (m.total_count / 2) + 1
ORDER BY m.company, m.salary;
