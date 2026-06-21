CREATE PROCEDURE SP_ShoppingDB_GetDeliveryTracking
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DeliveryTracking
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

