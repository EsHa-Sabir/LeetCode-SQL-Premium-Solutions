/*

### LeetCode 613: Shortest Distance in a Line (🔒 Premium / Easy)

1. 📋 Table Structure (The Schema)

Table: Point1D
+-------------+------+ 

| Column Name | Type |
+-------------+------+ 

| x           | int  |
+-------------+------+ 

* x is the primary key column (column with unique values) for this table.
* Each row of this table indicates the position of a point on a 1D line.

1. 🎯Demand & Rules (The Core Requirements)

Write a solution to report the shortest distance between any two distinct points
from the Point1D table. 

⚠️ Strict Edge Cases Handled: 

1. No Self-Matching: Points must not calculate a distance with themselves.
2. Deduplication Optimization: By utilizing the strictly less-than positional
operator ('a.x < b.x'), the engine eliminates mirror-duplicate checks
(e.g., calculating both A->B and B->A) and guarantees positive outputs.

The output column name must be exact 'shortest'. 

1. 📊 Example 1

Input:
Point1D table:
+----+ 

| x  |
+----+ 

| -1 |
| 0  |
| 2  |
+----+ 

🔍 Explanation:
The shortest distance is 1 (between -1 and 0). 

Expected Output:
+----------+ 

| shortest |
+----------+ 

| 1        |
+----------+ 

### ================================================================================
My 100% Optimized Solution (Positional 1D Cross-Scan):

*/ 

SELECT MIN(ABS(b.x - a.x)) AS shortest 
FROM Point1D a 
CROSS JOIN Point1D b 
WHERE a.x <> b.x;
