CREATE OR REPLACE PROCEDURE proc_price_correction(c_id IN NUMBER)
AS
    TYPE c_type IS TABLE OF sales%ROWTYPE ;
    v_collection c_type := c_type() ;
    
    TYPE c_type2 IS TABLE OF NUMBER ;
    v_result c_type2 ; 
    
BEGIN
    SELECT *
    BULK COLLECT INTO v_collection
    FROM sales 
    WHERE customer_id = c_id 
    FOR UPDATE ;
    
    FORALL i IN v_collection.FIRST .. v_collection.LAST
        UPDATE sales 
        SET total_amount = tax_amount + price_amount 
        WHERE sale_id = v_collection(i).sale_id 
        RETURNING sale_id BULK COLLECT INTO v_result ;
    
    COMMIT ;
    
    FOR j IN v_result.FIRST .. v_result.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_result(j)) ;
    END LOOP ;
    
END ;
/

EXEC proc_price_correction(3) ;
