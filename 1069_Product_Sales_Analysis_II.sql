### /*

### LeetCode 1069: Product Sales Analysis II (🔒 Premium / Easy)

1. 📋 Table Structure (The Schema)

Table: Sales
+-------------+-------+ 

| Column Name | Type  |
+-------------+-------+ 

| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+ 

* (sale_id, year) is the primary key (combination of columns with unique values) of this table.
* product_id is a foreign key reference column to the Product table.
* Each row of this table shows a sale on the product id in a certain year.

Table: Product
+--------------+---------+ 

| Column Name  | Type    |
+--------------+---------+ 

| product_id   | int     |
| product_name | varchar |
+--------------+---------+ 

* product_id is the primary key of this table.

1. 🎯 Demand & Rules (The Core Requirements)

Write a solution to report the total quantity sold per product id. 

⚠️ Optimization Strategy Used: 

* Avoided an unnecessary external relational table scan ('JOIN' with Product table).
Since 'product_id' and 'quantity' both coexist inside the 'Sales' table,
grouping directly over the source dataset maximizes computational execution speeds.
* Combined isolated sales rows using explicit grouped aggregate mapping via 'SUM()'.

The output headers must be exact: 'product_id' and 'total_quantity'. 

1. 📊 Example 1

Input:
Sales table:
+---------+------------+------+----------+-------+ 

| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 

| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+ 

Product table:
+------------+--------------+ 

| product_id | product_name |
+------------+--------------+ 

| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+ 

🔍 Explanation: 

* Product 100 was sold twice: 10 units in 2008 and 12 units in 2009. Total = 22.
* Product 200 was sold once: 15 units in 2011. Total = 15.

Expected Output:
+------------+----------------+ 

| product_id | total_quantity |
+------------+----------------+ 

| 100        | 22             |
| 200        | 15             |
+------------+----------------+ 

### ================================================================================
My Verified Solution (Highly Optimized No-Join Aggregate Grid):

*/ 

SELECT
product_id,
SUM(quantity) AS total_quantity
FROM Sales
GROUP BY product_id;
