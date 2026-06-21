CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

