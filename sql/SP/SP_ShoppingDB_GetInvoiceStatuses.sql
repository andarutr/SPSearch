CREATE PROCEDURE SP_ShoppingDB_GetInvoiceStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InvoiceStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

