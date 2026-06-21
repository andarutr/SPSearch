CREATE PROCEDURE SP_ShoppingDB_GetUserPaymentMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserPaymentMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

