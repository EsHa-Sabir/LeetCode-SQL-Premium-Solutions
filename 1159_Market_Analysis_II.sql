-- =========================================================================
-- LEETCODE PROBLEM: 1159. Market Analysis II
-- DIFFICULTY: Hard
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Write an SQL query to find for each user, whether the brand of the second item 
(by date) they sold is their favorite brand or not. 

CONSTRAINTS & RULES:
1. The Second Sale: We strictly care about the 2nd order chronologically where 
   the user is the 'seller_id'.
2. The Evaluation: 
   - If the item's brand of their 2nd sold transaction matches their 'favorite_brand', report 'yes'.
   - If it does not match, report 'no'.
3. Fewer Than 2 Sales: If a user has sold less than two items (0 or 1 item), report 'no' for that user.
4. All Users Included: The final output must contain ALL users from the Users table.

Return the result table in any order.

---------------------------------------------------------------------------
DATABASE SCHEMAS & TABLES:

Table: Users
+----------------+---------+

| Column Name    | Type    |
+----------------+---------+

| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+
user_id is the primary key of this table.

Table: Orders
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key of this table.
buyer_id and seller_id are foreign keys to the Users table.

Table: Items
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| item_id       | int     |
| item_brand    | varchar |
+---------------+---------+
item_id is the primary key of this table.

---------------------------------------------------------------------------
EXAMPLE TEST CASE:

Input Users Table:
+---------+------------+----------------+

| user_id | join_date  | favorite_brand |
+---------+------------+----------------+

| 1       | 2019-01-01 | Lenovo         |
| 2       | 2019-02-09 | Samsung        |
| 3       | 2019-01-19 | LG             |
| 4       | 2019-05-21 | HP             |
+---------+------------+----------------+

Input Orders Table:
+----------+------------+---------+----------+-----------+

| order_id | order_date | item_id | buyer_id | seller_id |
+----------+------------+---------+----------+-----------+

| 1        | 2019-08-01 | 4       | 1        | 2         |
| 2        | 2019-08-02 | 2       | 1        | 3         |
| 3        | 2019-08-03 | 3       | 2        | 3         |
| 4        | 2019-08-04 | 1       | 4        | 2         |
| 5        | 2019-08-04 | 1       | 3        | 4         |
| 6        | 2019-08-05 | 2       | 2        | 4         |
+----------+------------+---------+----------+-----------+

Input Items Table:
+---------+------------+

| item_id | item_brand |
+---------+------------+

| 1       | Samsung    |
| 2       | Lenovo     |
| 3       | LG         |
| 4       | HP         |
+---------+------------+

Output:
+-----------+--------------------+

| seller_id | 2nd_item_fav_brand |
+-----------+--------------------+

| 1         | no                 |
| 2         | yes                |
| 3         | yes                |
| 4         | no                 |
+-----------+--------------------+

DETAILED TRACING EXPLANATION:
- User 1: Has 0 sales as a seller. Automatic 'no'.
- User 2: 
  * 1st Sale: 2019-08-01 (Item 4 -> HP)
  * 2nd Sale: 2019-08-04 (Item 1 -> Samsung). Matches favorite brand 'Samsung'. Output: 'yes'.
- User 3: 
  * 1st Sale: 2019-08-02 (Item 2 -> Lenovo)
  * 2nd Sale: 2019-08-03 (Item 3 -> LG). Matches favorite brand 'LG'. Output: 'yes'.
- User 4: 
  * 1st Sale: 2019-08-04 (Item 1 -> Samsung)
  * 2nd Sale: 2019-08-05 (Item 2 -> Lenovo). Favorite is HP. No match. Output: 'no'.
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL using ROW_NUMBER & LEFT JOIN)
-- =========================================================================

WITH RankedSales AS (
    -- Step 1: Chronologically rank sales per seller and map item brands
    SELECT 
        o.seller_id,
        i.item_brand,
        ROW_NUMBER() OVER (PARTITION BY o.seller_id ORDER BY o.order_date) AS rnk
    FROM Orders o
    JOIN Items i ON o.item_id = i.item_id
)

-- Step 2: Preserving all users via LEFT JOIN and evaluating the 2nd sale criteria
SELECT 
    u.user_id AS seller_id,
    CASE 
        WHEN r.item_brand = u.favorite_brand THEN 'yes' 
        ELSE 'no' 
    END AS 2nd_item_fav_brand
FROM Users u
LEFT JOIN RankedSales r 
    ON u.user_id = r.seller_id 
    AND r.rnk = 2
ORDER BY seller_id ASC;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `ROW_NUMBER()` creates strict chronological indices partitioning by sellers.
-- 2. Inner join with `Items` fetches the brand properties before global data trimming.
-- 3. Outer `LEFT JOIN` on `u.user_id = r.seller_id AND r.rnk = 2` ensures profiles 
--    with fewer than 2 transactions are safely retained rather than dropped.
-- 4. The `CASE WHEN` clause filters strings seamlessly, masking unmatched/NULL segments to 'no'.
-- =========================================================================
