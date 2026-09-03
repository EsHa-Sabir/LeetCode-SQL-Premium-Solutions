/*

### LeetCode 615: Average Salary: Departments VS Company (🔒 Premium / Hard)

1. 📋 Table Structure (The Schema)

Table: Salary
+-------------+------+ 

| Column Name | Type |
+-------------+------+ 

| id          | int  |
| employee_id | int  |
| amount      | int  |
| pay_date    | date |
+-------------+------+ 

* id is the primary key column (column with unique values) for this table.
* Each row of this table indicates the salary of an employee in one specific month.
* employee_id is a foreign key reference column from the Employee table.

Table: Employee
+---------------+------+ 

| Column Name   | Type |
+---------------+------+ 

| employee_id   | int  |
| department_id | int  |
+---------------+------+ 

* employee_id is the primary key column (column with unique values) for this table.
* Each row of this table indicates the department_id to which an employee belongs.

1. 🎯 Demand & Rules (The Core Requirements)

Write a solution to judge whether the average salary in the department is higher,
lower, or the same as the company's average salary for each month. 

The comparison result must be mapped to three specific string categories: 

* 'higher': If the department's monthly average salary > company's overall monthly average.
* 'lower': If the department's monthly average salary < company's overall monthly average.
* 'same': If both monthly averages are exactly equal.

⚠️ Strict Requirements: 

1. Date Formatting: The 'pay_date' column must be truncated to calendar month format 'YYYY-MM'.
2. Structural Deduplication: Since window functions preserve the original row metrics,
'DISTINCT' must be applied to suppress duplicate department entries per month.

The output headers must be exact: 'pay_month', 'department_id', and 'comparison'. 

1. 📊 Example 1

Input:
Salary table:
+----+-------------+--------+------------+ 

| id | employee_id | amount | pay_date   |
+----+-------------+--------+------------+ 

| 1  | 1           | 9000   | 2017-03-31 |
| 2  | 2           | 6000   | 2017-03-31 |
| 3  | 3           | 10000  | 2017-03-31 |
| 4  | 1           | 7000   | 2017-02-28 |
| 5  | 2           | 6000   | 2017-02-28 |
| 6  | 3           | 8000   | 2017-02-28 |
+----+-------------+--------+------------+ 

Employee table:
+-------------+---------------+ 

| employee_id | department_id |
+-------------+---------------+ 

| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
+-------------+---------------+ 

🔍 Explanation (March 2017-03): 

* Company Overall Average = (9000 + 6000 + 10000) / 3 = 8333.33
* Department 1 Average = 9000 (9000 > 8333.33) -> 'higher'
* Department 2 Average = (6000 + 10000) / 2 = 8000 (8000 < 8333.33) -> 'lower'

Expected Output:
+-----------+---------------+------------+ 

| pay_month | department_id | comparison |
+-----------+---------------+------------+ 

| 2017-03   | 1             | higher     |
| 2017-03   | 2             | lower      |
| 2017-02   | 1             | same       |
| 2017-02   | 2             | same       |
+-----------+---------------+------------+ 

### ================================================================================
My 100% Optimized Solution (Dual-Window Aggregation & Deduplication):

*/ 

WITH CalculatedAverages AS (
SELECT
-- Standardizing date sequence to month offsets
DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
e.department_id,
-- Window 1: Broad company average baseline
AVG(s.amount) OVER(PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m')) AS company_avg,
-- Window 2: Granular department-specific metrics
AVG(s.amount) OVER(PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m'), e.department_id) AS dept_avg
FROM Salary s
JOIN Employee e ON s.employee_id = e.employee_id
)
SELECT DISTINCT -- Collapses the remaining structural telemetry copies
pay_month,
department_id,
CASE
WHEN dept_avg > company_avg THEN 'higher'
WHEN dept_avg < company_avg THEN 'lower'
ELSE 'same'
END AS comparison
FROM CalculatedAverages;
