CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserSessionAnalytics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserSessionAnalytics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

