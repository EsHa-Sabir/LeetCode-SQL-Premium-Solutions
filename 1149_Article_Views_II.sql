-- =========================================================================
-- LEETCODE PROBLEM: 1149. Article Views II
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Views
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+

GOAL:
Write an SQL query to find all the users that viewed more than one article on the same date.
Return the result table sorted by id in ascending order.
*/

-- =========================================================================
-- HIGHLY OPTIMIZED SOLUTION (MySQL)
-- =========================================================================

SELECT DISTINCT viewer_id AS id
FROM Views
GROUP BY viewer_id, view_date
HAVING COUNT(DISTINCT article_id) > 1
ORDER BY id ASC;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC & PERFORMANCE INSIGHTS:
-- 1. `GROUP BY viewer_id, view_date` partitions user behaviors on a strict daily scale.
-- 2. `HAVING COUNT(DISTINCT article_id) > 1` isolates high-volume single day consumers.
-- 3. `SELECT DISTINCT` safely trims out multi-date operational repetitions, outputting atomic indices.
-- 4. `ORDER BY id ASC` preserves clean alphanumeric sorting alignments natively.
-- =========================================================================
