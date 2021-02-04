-- Report
SELECT vs.subscriber_id,
       vs.create_date,
       vs.county_id,
       vs.spd_id,
       vs.credit,
       SUBSTR(tp.tariff_plan_name, 1, INSTR(tp.tariff_plan_name, '(')-1 ) as TARIFF_PLAN_NAME,
       CASE WHEN vs.county_id = 101 THEN 'OC'
            WHEN vs.county_id = 105 THEN 'SF'
            WHEN vs.county_id = 120 THEN 'SD'
            ELSE NULL END 
            
FROM vw_subscribers vs
INNER JOIN tarif_plan tp ON tp.tariff_plan_id = vs.tariff_plan_id

WHERE vs.county_id IN (101, 105, 120)
  AND ( tp.tariff_plan_name LIKE '%START%' 
     OR tp.tariff_plan_name LIKE '%OPTIMUM%' )
  AND vs.create_date >= TO_DATE('01.12.2020 00:00:00', 'dd.mm.yyyy hh24:mi:ss') 
;

-- Testing
SELECT COUNT(*)
FROM sales 
WHERE sales_date >= TO_DATE('01.12.2020 00:00:00', 'dd.mm.yyyy hh24:mi:ss')
  AND sales_date < TO_DATE('31.12.2020 23:59:59', 'dd.mm.yyyy hh24:mi:ss')
;

