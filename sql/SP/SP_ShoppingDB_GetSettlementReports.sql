CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSettlementReports
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SettlementReports
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

