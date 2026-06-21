CREATE PROCEDURE SP_ShoppingDB_GetAbandonedCarts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AbandonedCarts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

