CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailTemplateTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailTemplateTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

