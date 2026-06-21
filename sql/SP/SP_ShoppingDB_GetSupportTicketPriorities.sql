CREATE PROCEDURE SP_ShoppingDB_GetSupportTicketPriorities
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTicketPriorities
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

