-- =========================================================================
-- LEETCODE PROBLEM: 1126. Active Businesses
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Events
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| business_id   | int     |
| event_type    | varchar |
| occurences    | int     |
+---------------+---------+
(business_id, event_type) is the primary key of this table.

GOAL:
Write an SQL query to find all active businesses. An active business is a business 
that has MORE THAN ONE event_type where its occurrences are STRICTLY GREATER than 
the average activity for that specific event type across all businesses.

Return the result table in any order.
*/

-- =========================================================================
-- OPTIMIZED SOLUTION (MySQL using Window Function)
-- =========================================================================

WITH FindAvg AS (
    -- Step 1: Calculate global average occurrences for each event type dynamically
    SELECT 
        business_id, 
        occurences,
        AVG(occurences) OVER (PARTITION BY event_type) AS avg_occurences 
    FROM Events
) 

-- Step 2: Filter baseline outliers and extract businesses with multiple positive flags
SELECT business_id  
FROM FindAvg 
WHERE occurences > avg_occurences 
GROUP BY business_id 
HAVING COUNT(business_id) > 1;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `AVG() OVER (PARTITION BY event_type)` scans event categories, outputting 
--    the contextual benchmark for row-level mapping without requiring heavy cross-joins.
-- 2. The `WHERE` filter isolates businesses with high operational frequencies.
-- 3. `GROUP BY business_id` organizes accounts structurally into distinct entities.
-- 4. `HAVING COUNT(business_id) > 1` satisfies the primary requirement, 
--    returning only active profiles.
-- =========================================================================
