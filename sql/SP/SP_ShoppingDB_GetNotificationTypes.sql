CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetNotificationTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NotificationTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

