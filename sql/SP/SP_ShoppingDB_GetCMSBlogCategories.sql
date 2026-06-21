CREATE PROCEDURE SP_ShoppingDB_GetCMSBlogCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CMSBlogCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

