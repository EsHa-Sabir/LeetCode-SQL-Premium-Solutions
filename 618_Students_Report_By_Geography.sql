/*

### LeetCode 618: Students Report By Geography (🔒 Premium / Hard)

1. 📋 Table Structure (The Schema)

Table: Student
+-------------+---------+ 

| Column Name | Type    |
+-------------+---------+ 

| name        | varchar |
| continent   | varchar |
+-------------+---------+ 

* This table does not have a primary key (column with unique values); it may contain duplicate rows.
* Each row of this table indicates the name of a student and the continent they belong to.

1. 🎯 Sawaal Ki Demand & Rules (The Core Requirements)

Write a solution to pivot the continent column so that each student name is
sorted alphabetically and displayed under their respective continent. 

The output columns must be mapped exactly to: 'America', 'Asia', and 'Europe'. 

⚠️ Strict Constraints & Edge Cases: 

1. Alphabetical Alignment: Student names within each continent must be ordered
alphabetically ascending (A-Z) from top to bottom.
2. Sparse Matrix NULL Padding: Since the count of students varies across continents,
the query must dynamically pad trailing empty records with explicit NULLs.
3. Row Compression Framework: Standard pivot projections scatter elements across
independent multi-tier lines; an explicit matrix flattening sequence must be deployed.

1. 📊 Example 1

Input:
Student table:
+--------+-----------+ 

| name   | continent |
+--------+-----------+ 

| Jane   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jack   | America   |
+--------+-----------+ 

🔍 Step-by-Step Row Breakdown: 

* America Lineup: Jack, Jane (Sorted alphabetically)
* Asia Lineup: Xi
* Europe Lineup: Pascal
* Row-1 joins the first elements: Jack, Xi, Pascal.
* Row-2 contains Jane for America, while Asia and Europe are padded with NULL.

Expected Output:
+---------+------+--------+ 

| America | Asia | Europe |
+---------+------+--------+ 

| Jack    | Xi   | Pascal |
| Jane    | NULL | NULL   |
+---------+------+--------+ 

### ================================================================================
My 100% Optimized Solution (In-Memory Hash Bucketing & Row Collapse):

*/ 

WITH rankrow AS (
SELECT
name,
continent,

ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS rnk
FROM Student
)
SELECT

MAX(CASE WHEN continent = 'America' THEN name END) AS America,
MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
FROM rankrow
GROUP BY rnk; 
