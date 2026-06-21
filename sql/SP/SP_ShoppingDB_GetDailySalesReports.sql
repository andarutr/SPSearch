CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetDailySalesReports
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DailySalesReports
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

