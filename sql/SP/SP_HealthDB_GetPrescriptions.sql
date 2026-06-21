CREATE OR ALTER PROCEDURE SP_HealthDB_GetPrescriptions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Prescriptions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

