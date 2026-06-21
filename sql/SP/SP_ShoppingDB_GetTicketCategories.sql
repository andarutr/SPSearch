CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetTicketCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM TicketCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

