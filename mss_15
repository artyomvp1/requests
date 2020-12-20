IF OBJECT_ID('called_procedure','P') IS NOT NULL
	DROP PROCEDURE called_procedure
GO

IF OBJECT_ID('calling_procedure','P') IS NOT NULL
	DROP PROCEDURE tmp_procedure
GO

-- Called procedure
CREATE PROCEDURE called_procedure (@c_id INT, @cursor CURSOR VARYING OUTPUT)
AS

BEGIN
	SET @cursor = CURSOR FORWARD_ONLY STATIC FOR
	SELECT sale_id, total_amount
	FROM sales
	WHERE customer_id = @c_id

	OPEN @cursor

END
GO

-- Calling procedure
CREATE PROCEDURE calling_procedure (@customer_id INT)
AS

BEGIN
	DECLARE
		@rec1 INT,
		@rec2 INT,
		@cur CURSOR

	EXEC called_procedure @c_id = @customer_id, @cursor = @cur OUTPUT
	FETCH NEXT FROM @cur INTO @rec1, @rec2
	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT CONCAT(@rec1, ': ', @rec2 )
			FETCH NEXT FROM @cur INTO @rec1, @rec2
		END
	CLOSE @cur
	DEALLOCATE @cur

END ;
GO
