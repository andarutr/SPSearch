CREATE PROCEDURE SP_ShoppingDB_GetNewsletterSubscribers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NewsletterSubscribers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

