CREATE OR ALTER PROCEDURE SP_HealthDB_GetMedicalEquipment
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM MedicalEquipment
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

