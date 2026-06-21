CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetInventoryCounts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InventoryCounts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

