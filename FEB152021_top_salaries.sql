-- Top salaries for audit
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
