-- =========================================================================
-- LEETCODE PROBLEM: 1132. Reported Posts II
-- DIFFICULTY: Medium
-- CATEGORY: Database / SQL (MySQL)
-- =========================================================================

/*
PROBLEM STATEMENT:
Table: Actions
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| user_id       | int     |
| post_id       | int     |
| action_date   | date    |
| action        | enum    |
| extra         | varchar |
+---------------+---------+

Table: Removals
+---------------+---------+

| Column Name   | Type    |
+---------------+---------+

| post_id       | int     |
| remove_date   | date    |
+---------------+---------+
post_id is the primary key of the Removals table.

GOAL:
Write an SQL query to find the average daily percentage of posts that got 
removed after being reported as spam, rounded to 2 decimal places.

RULES:
1. Filter only logs where action = 'report' AND extra = 'spam'.
2. Count unique posts per day using DISTINCT constraints.
3. Compute the daily removal rates, then output their global average.
*/

-- =========================================================================
-- 100% CORRECT & ACCEPTED SOLUTION (MySQL using Layered CTEs)
-- =========================================================================

WITH filterrecord AS (
    -- Step 1: Extract unique reported spam posts per day
    SELECT DISTINCT 
        post_id,
        action_date 
    FROM Actions 
    WHERE action = 'report' 
      AND extra = 'spam'
),
jointable AS (
    -- Step 2: Left join removals and compute exact atomic daily percentages
    SELECT 
        ((COUNT(DISTINCT r.post_id) / COUNT(DISTINCT a.post_id)) * 100) AS daily_precentage 
    FROM filterrecord a 
    LEFT JOIN Removals r 
        ON a.post_id = r.post_id 
    GROUP BY a.action_date
) 

-- Step 3: Extract global average rounded to 2 decimal places
SELECT 
    ROUND(AVG(daily_precentage), 2) AS average_daily_percent 
FROM jointable;

-- =========================================================================
-- INTERNAL EXECUTION LOGIC:
-- 1. `filterrecord` deduplicates incoming user report streams safely.
-- 2. `LEFT JOIN Removals` ensures unremoved records remain part of the denominator.
-- 3. `COUNT(DISTINCT r.post_id)` protects calculations from cross-day data duplication loop-holes.
-- 4. Final outer `ROUND(AVG())` aggregates multi-day percentage points accurately.
-- =========================================================================
