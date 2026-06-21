CREATE PROCEDURE SP_ShoppingDB_GetOrderStatusHistory
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderStatusHistory
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

