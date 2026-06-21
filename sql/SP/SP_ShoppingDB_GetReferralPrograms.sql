CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReferralPrograms
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReferralPrograms
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

