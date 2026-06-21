CREATE OR ALTER PROCEDURE SP_HealthDB_GetStaffSchedules
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StaffSchedules
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

