CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductDiscounts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductDiscounts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

