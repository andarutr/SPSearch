CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetChargebacks
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Chargebacks
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

