WITH x AS ( SELECT sales.*,
		   PERCENTILE_DISC(0.8) WITHIN GROUP (ORDER BY total_amount) OVER(PARTITION BY NULL) as MILESTONE
	    FROM sales 
	   )

SELECT sale_id, 
	   sales_date,
	   x.customer_id, 
	   CONCAT(SUBSTRING(first_name, 1, 1), '. ', last_name),
	   service_plan, 
	   total_amount,
	   milestone
FROM x
LEFT JOIN customer c ON c.customer_id = x.customer_id 
WHERE x.total_amount >= x.MILESTONE
ORDER BY sale_id 
;
