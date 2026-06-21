CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPayoutStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PayoutStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

