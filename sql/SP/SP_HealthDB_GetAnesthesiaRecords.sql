CREATE PROCEDURE SP_HealthDB_GetAnesthesiaRecords
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AnesthesiaRecords
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

