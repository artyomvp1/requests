SELECT /*+DRIVING_SITE(s1)*/ 
       t.transaction_date,
       s1.spd_type,
       COUNT(*) as c_count 

FROM traffic t
LEFT JOIN traffic_analytics ta ON ta.traffic_load_id = t.traffic_load_id
LEFT JOIN spd1@SPD s1 ON s1.hub_id = t.hub_id

WHERE t.transaction_date > to_date('01.01.2020 00:00:00', 'dd.mm.yyyy hh24:mi:ss')
  AND t.type NOT IN (100, 186)
  AND NOT EXISTS ( SELECT *
                   FROM traffic_pool tp
                   WHERE tp.transaction_id = t.transaction_id
                   )

GROUP BY t_transaction_date,
         s1.spd_type 
HAVING COUNT(*) > 1 ;