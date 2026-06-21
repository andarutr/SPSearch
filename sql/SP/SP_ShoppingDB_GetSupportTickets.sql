CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupportTickets
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTickets
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

