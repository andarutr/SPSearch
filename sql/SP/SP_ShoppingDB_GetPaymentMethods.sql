CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

