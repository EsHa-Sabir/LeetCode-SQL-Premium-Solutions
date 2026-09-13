-- =========================================================================
-- LEETCODE PROBLEM: 1112. Highest Grade For Each Student
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Enrollments
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.

GOAL:
Write an SQL query to find the highest grade with its corresponding course for each student. 
If there's a tie, select the course with the smallest course_id.
The output must be sorted by student_id in ascending order.
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL using ROW_NUMBER)
-- =========================================================================

WITH rnkgrade AS (
    -- Step 1: Assign sequential row integers partitioning per user stream
    SELECT 
        student_id,
        course_id,
        grade,
        ROW_NUMBER() OVER(
            PARTITION BY student_id 
            ORDER BY grade DESC, course_id ASC
        ) AS rnk 
    FROM Enrollments
) 

-- Step 2: Extract top performing index and structure sorting requirements
SELECT 
    student_id,
    course_id,
    grade 
FROM rnkgrade 
WHERE rnk = 1
ORDER BY student_id ASC;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `ROW_NUMBER()` segments rows structurally by `student_id`.
-- 2. The sorting prioritization inside the partition puts the highest grade 
--    at the top (`DESC`) and automatically breaks ties using the lowest `course_id` (`ASC`).
-- 3. Filtering on `rnk = 1` safely truncates trailing ties or lower grades.
-- 4. Final direct `ORDER BY` aligns constraints perfectly with structural requests.
-- =========================================================================
