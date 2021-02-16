-- 1. Top salaries for audit
WITH x AS (SELECT employee_id,
                  hire_date, 
                  department_id,
                  salary,
                  NTILE(3) OVER(PARTITION BY NULL ORDER BY salary DESC) AS group_id -- 3 groups
             FROM employee 
             )

SELECT employee_id,
       hire_date,
       department_name,
       number_of_employees,
       salary
       
FROM x 
LEFT JOIN department d ON d.department_id = x.department_id 
WHERE group_id = 1 ;

-- 2. above median value
WITH base AS ( SELECT sale_id,
                       sales_date, 
                       customer_id,
                       total_amount,
                       TRUNC(CUME_DIST() OVER(ORDER BY total_amount), 2) as cumulative_value
                FROM sales
                )

SELECT base.*,
       CASE WHEN cumulative_value >= 0.5 THEN 'ABOVE MEDIAN'
       ELSE NULL END
FROM base 
ORDER BY 1 ;