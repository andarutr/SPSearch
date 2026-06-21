CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderCancellations
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderCancellations
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

