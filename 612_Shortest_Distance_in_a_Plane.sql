/*

### LeetCode 612: Shortest Distance in a Plane (🔒 Premium / Medium)

1. 📋 Table Structure (The Schema)

Table: Point2D
+-------------+------+ 

| Column Name | Type |
+-------------+------+ 

| x           | int  |
| y           | int  |
+-------------+------+ 

* (x, y) is the primary key column (combination of columns with unique values) for this table.
* Each row of this table indicates the position of a point on the X-Y plane.

1.Demand & Rules (The Core Requirements)

Write a solution to report the shortest distance between any two distinct points
from the Point2D table. 

The distance between two points p1(x1, y1) and p2(x2, y2) is calculated using
the Euclidean Distance formula:
Distance = SQRT((x2 - x1)^2 + (y2 - y1)^2) 

⚠️ Strict Edge Cases Handled: 

1. No Self-Matching: Points must not calculate a distance with themselves, as the
self-distance will always evaluate to 0.
2. Parallel/Linear Planes Validation: Pairs that share identical X or identical Y
coordinates (horizontal/vertical lines) must NOT be deleted, as they represent distinct lines.
3. Decimal Precision: The final output must be rounded to exactly 2 decimal places.

The output column name must be exact 'shortest'. 

1. 📊 Example 1

Input:
Point2D table:
+----+----+ 

| x  | y  |
+----+----+ 

| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
+----+----+ 

🔍 Explanation:
The shortest distance is between the points (-1, -1) and (-1, -2) which is 1.00. 

* Distance ((-1,-1) to (0,0))  = SQRT((0 - (-1))^2 + (0 - (-1))^2) = SQRT(2) = 1.41
* Distance ((0,0) to (-1,-2))  = SQRT((-1 - 0)^2 + (-2 - 0)^2) = SQRT(5) = 2.24
* Distance ((-1,-1) to (-1,-2)) = SQRT((-1 - (-1))^2 + (-2 - (-1))^2) = SQRT(1) = 1.00

Expected Output:
+----------+ 

| shortest |
+----------+ 

| 1.00     |
+----------+ 

### ================================================================================
My 100% Optimized Solution (Spatial Cross-Join Evaluation):

*/ 

SELECT
ROUND(SQRT(MIN(POW(b.x - a.x, 2) + POW(b.y - a.y, 2))), 2) AS shortest
FROM Point2D a
CROSS JOIN Point2D b
WHERE a.x <> b.x OR a.y <> b.y;
