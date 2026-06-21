CREATE PROCEDURE SP_ShoppingDB_GetPurchaseOrderItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PurchaseOrderItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

