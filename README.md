# 🔒 LeetCode SQL Premium Solutions

<p align="center">
  <b>Mastering Advanced SQL Through Premium LeetCode Problems 🚀</b>
</p>

<p align="center">

![SQL](https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge)
![Problems](https://img.shields.io/badge/Problems_Solved-15-success?style=for-the-badge)
![Easy](https://img.shields.io/badge/Easy-4-brightgreen?style=for-the-badge)
![Medium](https://img.shields.io/badge/Medium-6-yellow?style=for-the-badge)
![Hard](https://img.shields.io/badge/Hard-5-red?style=for-the-badge)

</p>

---

## 📖 About This Repository

Welcome to my repository! 👋

This repository is dedicated to solving and documenting **LeetCode SQL Premium (Locked) problems**.

Since these problems require a LeetCode Premium subscription to access and run test cases, I have documented the **problem concepts, example schemas, SQL approaches, and optimized solutions** for learning and interview preparation.

---

## 🎯 Repository Goals

This repository focuses on:

### 🧠 Master Complex SQL Patterns

- Window Functions
- `ROW_NUMBER()`
- `DENSE_RANK()`
- `RANK()`
- `LAG()`
- `LEAD()`
- `LAST_VALUE()`
- `FIRST_VALUE()`
- Recursive CTEs
- Layered CTEs
- Nested execution CTEs layers.
- Correlated Subqueries
- Aggregate Functions
- Advanced Joins
- SQL Functions
- Window Framing
- ROWS/RANGE/GROUPS BETWEEN boundaries.
- PRECEDING/FOLLOWING
- UNBOUNDED PRECEDING/FOLLOWING

### 💡 Practice Interview-Level Problems

Solve challenging SQL problems commonly associated with technical interviews and data-focused roles.

### 📚 Track My Progress

Maintain clean, structured, and optimized SQL solutions for future learning and interview preparation.

---

# 📊 Progress Tracker

> 🚀 **Currently documenting my journey through advanced LeetCode SQL problems.**

| #️⃣ Problem | 📌 Title | 🎯 Difficulty | 🧠 Key Concepts |
|:----------:|---------|:-------------:|-----------------|
| **512** | **Game Play Analysis II** | 🟢 Easy | `ROW_NUMBER()`, Window Partitioning |
| **534** | **Game Play Analysis III** | 🟡 Medium | Cumulative `SUM()`, Running Totals |
| **569** | **Median Employee Salary** | 🔴 Hard | Mathematical Offsets, `ROW_NUMBER()`, `COUNT(*) OVER()` |
| **571** | **Find Median Given Frequency of Numbers** | 🔴 Hard | Cumulative Frequency, Non-Decompression Median, `SUM() OVER()` |
| **574** | **Winning Candidate** | 🟡 Medium | `COUNT()`, `GROUP BY`, Correlated Max Subquery / `LIMIT 1`|
| **578** | **Get Highest Answer Rate Question** | 🟡 Medium | `Sum()`,`IF()`, `GROUP BY`,`ORDER BY`, Layered CTEs / `LIMIT 1`|
| **579** | **Find Cumulative Salary of an Employee** | 🔴 Hard | Window Framing (RANGE 2 PRECEDING), `MAX()` CTE Filter, Delayed Evaluation|
| **580** | **Count Student Number in Departments** | 🟡 Medium | `LEFT JOIN` Gaps Handling, `COUNT(col)` vs `COUNT(*)`, Grouped Aggregations|
| **597** | **Friend Requests I: Overall Acceptance Rate** | 🟢 Easy |Multi-Table Stream Scans, `COUNT(DISTINCT)`, Zero-Division Rescue (`NULLIF`) |
| **603** | **Consecutive Available Seats** | 🟢 Easy |Bidirectional Window Scanning, `LEAD()`, `LAG()`, Sequence Continuity Parsing |
| **612** | **Shortest Distance in a Plane** | 🟡 Medium |Spatial Cross-Join Evaluation, Multi-Variable Boolean Logic (OR), Geometric Aggregates (SQRT/POW) |
| **613** | **Shortest Distance in a Line** | 🟢 Easy |Vector Distance Cross-Evaluation, Absolute Difference Maps (ABS), Functional Inequalities (<>) |
| **614** | **Second Degree Follower** | 🟡 Medium |Self-Referencing Multi-Level Network Filter, Subquery IN Constraints, Grouped Frequency Aggregations |
| **615** | **Average Salary: Departments VS Company** | 🔴 Hard | Dual-Window Partitioning, Asymmetric Scale Baseline Comparison, Spatial Row Deduplication (`DISTINCT`) |
| **618** | **Students Report By Geography** | 🔴 Hard |Vertical-to-Horizontal Pivot Restructuring, Custom Row Index Alignment, String Bucket Compression (`MAX` + `GROUP BY`) |



---

## 📈 Progress Statistics

| 🟢 Easy | 🟡 Medium | 🔴 Hard | 📚 Total |
|:-------:|:---------:|:-------:|:--------:|
| **4** | **6** | **5** | **15** |

---

## 🧠 SQL Concepts Covered

```text
✔ Window Functions & Advanced Partitioning
✔ Window Frames & Boundaries (ROWS vs RANGE BETWEEN vs GROUPS)
✔ Frame Boundary Shortcuts (Direct PRECEDING Bounds without BETWEEN)
✔ Value Offsets & Gaps Handling (LAG, LEAD, IFNULL Framework)
✔ Cumulative Frequency & Rolling Aggregates
✔ Mathematical Optimization (Floating-point precision with 1.0 multiplier)
✔ Delayed Execution Filters (Calculations before Output Truncation)
✔ Row Limiting Strategies & Tie-Breaker Handling
✔ Left Join Integrity (Preserving empty records and forcing 0 counts)
✔ Reserved Keywords Isolation (Safe Namespace Reference via Backticks)
✔ Zero-Division Arithmetic Safeguards (NULLIF Cascade & Stream Lookups)


