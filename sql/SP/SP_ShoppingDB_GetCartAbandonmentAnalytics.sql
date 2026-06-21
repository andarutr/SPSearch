CREATE PROCEDURE SP_ShoppingDB_GetCartAbandonmentAnalytics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CartAbandonmentAnalytics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

