CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSubscriptionPlanTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SubscriptionPlanTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

