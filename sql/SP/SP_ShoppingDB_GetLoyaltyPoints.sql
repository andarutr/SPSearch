CREATE PROCEDURE SP_ShoppingDB_GetLoyaltyPoints
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LoyaltyPoints
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

