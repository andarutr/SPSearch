CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWishlistItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WishlistItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

