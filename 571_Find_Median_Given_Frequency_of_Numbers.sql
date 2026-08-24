/*

### LeetCode 571: Find Median Given Frequency of Numbers (🔒 Premium / Hard)

Problem Description:
The Numbers table keeps the value of number and its frequency. 

Table: Numbers
+-------------+------+ 

| Column Name | Type |
+-------------+------+ 

| num         | int  |
| frequency   | int  |
+-------------+------+
num is the primary key (column with unique values) for this table.
Each row of this table shows the frequency of a number in the database. 

Goal:
Write a solution to find the median of all the numbers and round the answer
to two decimal places. 

### ================================================================================
Example 1:

Input:
Numbers table:
+-----+-----------+ 

| num | frequency |
+-----+-----------+ 

| 0   | 7         |
| 1   | 1         |
| 2   | 3         |
| 3   | 1         |
+-----+-----------+ 

Explanation:
If we decompress the data, the full sorted sequence of numbers is:
0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3 

The total number of observations is 12 (an even number).
The middle numbers are the 6th and 7th elements, which are both 0.
The median is (0 + 0) / 2 = 0. 

Output:
+--------+ 

| median |
+--------+ 

| 0.00   |
+--------+ 

### ================================================================================
My Optimized Solution (Without Explicit Decompression):

*/ 

WITH CumulativeTable AS (
SELECT
num,
SUM(frequency) OVER (ORDER BY num ASC) AS forward_sum,
SUM(frequency) OVER (ORDER BY num DESC) AS backward_sum
FROM Numbers
)
SELECT
Cast(AVG(num) as DECIMAL(10,2)) AS median
FROM CumulativeTable
WHERE forward_sum >= (SELECT SUM(frequency) FROM Numbers) / 2
AND backward_sum >= (SELECT SUM(frequency) FROM Numbers) / 2;
