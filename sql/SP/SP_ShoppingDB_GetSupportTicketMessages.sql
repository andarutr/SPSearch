CREATE PROCEDURE SP_ShoppingDB_GetSupportTicketMessages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTicketMessages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

