DECLARE
    TYPE c_type IS TABLE OF VARCHAR2(20) ;
    v_collection c_type := c_type() ;
    v_sql VARCHAR2(100) ;
    
BEGIN
    SELECT table_name
    BULK COLLECT INTO v_collection -- bulking
    FROM all_tables 
    WHERE owner = 'ADMIN' 
      AND table_name != 'EVENT_LOG' ;
    
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP
        v_sql := 'CREATE SEQUENCE ' || v_collection(i) || '_sq MINVALUE 1 INCREMENT BY 1' ;
        EXECUTE IMMEDIATE v_sql ;
        
    END LOOP ;

END ;