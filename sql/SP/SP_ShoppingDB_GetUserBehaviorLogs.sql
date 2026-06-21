CREATE PROCEDURE SP_ShoppingDB_GetUserBehaviorLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserBehaviorLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

