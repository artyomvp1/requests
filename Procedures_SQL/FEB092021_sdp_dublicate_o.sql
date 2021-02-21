CREATE OR REPLACE PROCEDURE sdp_dublicate_o
AS
    
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE daily_cache' ; -- Don't forget
    

    DELETE
    FROM spd2@SDP
    WHERE transaction_date >= &start_date
      AND ROWID NOT IN ( SELECT MIN(ROWID)
                         FROM spd2@SDP
                         GROUP BY transaction_id,
                                  transaction_date, 
                                  tran_type,
                                  sdp_mode, 
                                  number_of_rows,
                                  cache_state,
                                  commentary
                        ) ;
                        
    COMMIT ;
END ;
