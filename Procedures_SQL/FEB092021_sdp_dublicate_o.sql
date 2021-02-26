CREATE OR REPLACE PROCEDURE sdp_dublicate_o
AS
    
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE daily_cache' ;
    

    DELETE
    FROM spd2@SDP
    WHERE transaction_date >= TRUNC(SYSDATE)
      AND ROWID NOT IN ( SELECT MIN(ROWID)
                         FROM spd2@SDP
                         GROUP BY transaction_id, transaction_date, tran_type, sdp_mode, 
                                  number_of_rows, cache_state, commentary
                        ) ;
                        
    COMMIT ;
END ;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (job_name             => 'clean_dublicate_sdp',
                               job_type             => 'STORED_PROCEDURE',
                               job_action           => 'sdp_dublicate_o',
                               start_date           => SYSTIMESTAMP,
                               repeat_interval      => 'freq=daily; interval=1;', -- on daily basis
                               end_date             => NULL,
                               enabled              => TRUE,
                               comments             => 'Delete dublicate rows from the cache. Table: daily_cache') ;
END ;
