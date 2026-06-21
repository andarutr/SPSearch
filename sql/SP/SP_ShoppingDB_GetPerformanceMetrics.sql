CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPerformanceMetrics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PerformanceMetrics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

