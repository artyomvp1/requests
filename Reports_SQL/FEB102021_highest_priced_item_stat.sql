SELECT sales_date,
       s.customer_id, 
       SUBSTR(c.first_name, 1, 1 ) || '. ' || c.last_name as full_name,
       item_id, 
       to_char(total_amount, '$9,999.99')as price_amount,
       DECODE(NTILE(3) OVER(ORDER BY price_amount DESC), 1, 'HIGH',
                                                         2, 'AVERAGE',
                                                         3, 'LOW', 
                                                         NULL) as rnked
FROM sales s 
LEFT JOIN customer c ON c.customer_id = s.customer_id ;
