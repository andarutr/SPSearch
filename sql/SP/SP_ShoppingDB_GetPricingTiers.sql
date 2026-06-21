CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPricingTiers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PricingTiers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

