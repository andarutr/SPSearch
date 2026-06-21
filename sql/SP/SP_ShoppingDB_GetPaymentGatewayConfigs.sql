CREATE PROCEDURE SP_ShoppingDB_GetPaymentGatewayConfigs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentGatewayConfigs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

