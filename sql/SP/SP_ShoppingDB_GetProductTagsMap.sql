CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductTagsMap
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductTagsMap
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

