IF OBJECT_ID('proc_minus15') IS NOT NULL
	DROP PROCEDURE proc_minus15 
GO

CREATE PROCEDURE proc_minus15 (@c_id INT)
AS

BEGIN
	DECLARE
		@rec1 INT,
		@rec2 DATE, 
		@rec3 INT

	DECLARE
		@log_table TABLE (sale_id INT IDENTITY(1, 1), 
						  new_value INT, 
						  old_value INT)

	UPDATE sales 
	SET total_amount = total_amount - total_amount * 15 / 100 -- Add 15% discount
		OUTPUT inserted.total_amount, deleted.total_amount
		INTO @log_table (new_value, old_value)
	WHERE customer_id = @c_id 

	SELECT *
	FROM @log_table
	
END 
