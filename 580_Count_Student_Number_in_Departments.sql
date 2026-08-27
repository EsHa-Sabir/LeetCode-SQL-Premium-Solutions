/*

### LeetCode 580: Count Student Number in Departments (🔒 Premium / Medium)

1. 📋 Table Structure (The Schema)

Table: Student
+--------------+---------+ 

| Column Name  | Type    |
+--------------+---------+ 

| student_id   | int     |
| student_name | varchar |
| gender       | varchar |
| dept_id      | int     |
+--------------+---------+ 

* student_id is the primary key (column with unique values) for this table.
* dept_id is a foreign key (reference column) to dept_id from the Department table.
* Each row of this table contains information about the student's name, gender,
and their department ID.

Table: Department
+-------------+---------+ 

| Column Name | Type    |
+-------------+---------+ 

| dept_id     | int     |
| dept_name   | varchar |
+-------------+---------+ 

* dept_id is the primary key (column with unique values) for this table.
* Each row of this table contains the ID and the name of a department.

1. 🎯 Demand & Rules (The Core Requirements)

Write a solution to report the respective number of students for each department
in the Department table (even if a department has no students). 

⚠️ Strict Condition:
If a department has no students enrolled, report 0 for that department. 

📊 Output Sorting Rule:
The final result table must be sorted by student_number in descending order.
If there is a tie, sort the rows alphabetically by dept_name in ascending order. 

1. 📊 Example 1

Input:
Student table:
+------------+--------------+--------+---------+ 

| student_id | student_name | gender | dept_id |
+------------+--------------+--------+---------+ 

| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |
+------------+--------------+--------+---------+ 

Department table:
+---------+-----------------+ 

| dept_id | dept_name       |
+---------+-----------------+ 

| 1       | Engineering     |
| 2       | Science         |
| 3       | Law             |
+---------+-----------------+ 

🔍 Explanation: 

* Engineering (ID 1): Contains 2 students (Jack, Jane).
* Science (ID 2): Contains 1 student (Mark).
* Law (ID 3): Contains no students, so the student count stays 0.
* Based on the sorting rules, Engineering (2) comes first, followed by
Science (1), and Law (0) comes last.

Expected Output:
+-----------------+----------------+ 

| dept_name       | student_number |
+-----------------+----------------+ 

| Engineering     | 2              |
| Science         | 1              |
| Law             | 0              |
+-----------------+----------------+ 

### ================================================================================
My 100% Optimized Solution:
*/ 

SELECT
d.dept_name,
COUNT(s.student_id) AS student_number
FROM Department d
LEFT JOIN Student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name ASC;
