-- For ORA
UPDATE sales so
SET total_amount = ( WITH x AS ( SELECT sale_id, total_amount, c.salary / 10000 as DISCOUNT
                                 FROM sales s
                                 LEFT JOIN customer c ON c.customer_id = s.customer_id
                                 )

                     SELECT total_amount - total_amount * discount / 100
                     FROM x
                     WHERE x.sale_id = so.sale_id -- EQUI-JOIN!
                     )
;

SELECT *
FROM sales 
;
