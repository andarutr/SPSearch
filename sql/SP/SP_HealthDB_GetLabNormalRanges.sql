CREATE OR ALTER PROCEDURE SP_HealthDB_GetLabNormalRanges
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LabNormalRanges
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

