CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailTemplates
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailTemplates
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

