CREATE PROCEDURE [Proc_CMS_Class_SelectAll]
AS
BEGIN
	SELECT * FROM CMS_Class ORDER BY ClassDisplayName
END
