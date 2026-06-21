CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCampaignTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CampaignTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

