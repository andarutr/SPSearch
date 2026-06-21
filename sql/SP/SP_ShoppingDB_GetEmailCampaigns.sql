CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailCampaigns
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailCampaigns
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

