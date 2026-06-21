CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWarehouseZones
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WarehouseZones
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

