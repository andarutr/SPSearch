CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

