CREATE OR REPLACE TRIGGER test_trigger
    AFTER INSERT OR DELETE  
    ON customer 
    
DECLARE
    v_user VARCHAR2(100) ;
    v_exp EXCEPTION ;
    
BEGIN
    SELECT user 
    INTO v_user
    FROM DUAL ;
    
    IF INSERTING THEN
        INSERT INTO event_log
        VALUES(event_id_sq.NEXTVAL, SYSDATE, v_user, 'CUSTOMER', NULL, NULL, 'Inserting operation') ;
    ELSIF DELETING THEN
        INSERT INTO event_log
        VALUES(event_id_sq.NEXTVAL, SYSDATE, v_user, 'CUSTOMER', NULL, NULL, 'Deleting operation') ;
    ELSE
        RAISE v_exp ;
    END IF ;
    
EXCEPTION 
    WHEN v_exp THEN
        INSERT INTO event_log
        VALUES(event_id_sq.NEXTVAL, SYSDATE, v_user, 'CUSTOMER', NULL, NULL, 'Exception Handling') ;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE) ;
        
END ;
        
