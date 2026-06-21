CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewModerationLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewModerationLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

