WITH mediansalary AS (
    SELECT 
        id,             
        company,
        salary,
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS rnk,
        COUNT(*) OVER (PARTITION BY company) AS total_count  
    FROM Employee
)   
SELECT 
    m.id,               
    m.company,
    m.salary 
FROM mediansalary m     
WHERE m.rnk BETWEEN m.total_count / 2 
                AND (m.total_count / 2) + 1
ORDER BY m.company, m.salary;
