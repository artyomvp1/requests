CREATE OR REPLACE TRIGGER deposit_control
    AFTER UPDATE
    OF deposit
    ON customer 
    FOR EACH ROW 
    
DECLARE
    v_user VARCHAR2(100) ;
    
BEGIN
    SELECT user
    INTO v_user 
    FROM DUAL ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSDATE, v_user, 'CUSTOMER', :old.DEPOSIT, :new.DEPOSIT, '') ;
        
END ;
/

SELECT *
FROM event_log 
ORDER BY 1 DESC ;
