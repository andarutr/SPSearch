CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShippingMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShippingMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

