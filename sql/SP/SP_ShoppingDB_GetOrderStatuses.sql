CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

