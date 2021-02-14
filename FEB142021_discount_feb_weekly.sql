WITH x AS ( SELECT customer_id,
                   COUNT(*) AS number_of_sales
            FROM sales
            GROUP BY customer_id
            ),
             
     y as ( SELECT sale_id,
                   sales_date,
                   FIRST_VALUE(sales_date) OVER(PARTITION BY s.customer_id ORDER BY NULL) AS first_sale,
                   s.customer_id,
                   number_of_sales,
                   total_amount
            
            FROM sales s
            LEFT JOIN x ON x.customer_id = s.customer_id 
            )

SELECT y.*,
       CASE WHEN number_of_sales BETWEEN 5 AND 9 AND sales_date - first_sale <= 7 THEN TRUNC(total_amount * 10 / 100)
            WHEN number_of_sales >= 10 AND sales_date - first_sale <= 7 THEN TRUNC(total_amount * 12 / 100)
            ELSE 0 END AS discount_amount
            
FROM y 
WHERE sales_date >= to_date('02.01.2021', 'mm.dd.yyyy')

ORDER BY 1 ;
