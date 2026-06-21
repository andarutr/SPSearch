CREATE OR ALTER PROCEDURE SP_HealthDB_GetImagingStudies
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ImagingStudies
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

