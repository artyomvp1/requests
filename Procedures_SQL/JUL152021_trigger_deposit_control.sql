/*
Fecthing accout altering customer's deposit 
*/

CREATE OR REPLACE TRIGGER deposit_restrictions_control 
    BEFORE UPDATE
    OF deposit
    ON customer 
    FOR EACH ROW 
    WHEN (NEW.deposit >= 1000)
    
DECLARE
    v_user VARCHAR2(100) ;
    
BEGIN
    SELECT user
    INTO v_user 
    FROM DUAL ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSTIMESTAMP, v_user, 'CUSTOMER', :OLD.deposit, :NEW.deposit, 'DEPOSIT CONTROL TRIGGER RECORD') ;
        
END ;
/