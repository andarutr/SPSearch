CREATE OR ALTER PROCEDURE SP_HealthDB_GetDrugInventory
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DrugInventory
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

