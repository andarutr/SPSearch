CREATE PROCEDURE SP_ShoppingDB_GetPurchaseOrders
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PurchaseOrders
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

