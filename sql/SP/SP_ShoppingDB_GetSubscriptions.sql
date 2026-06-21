CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSubscriptions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Subscriptions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

