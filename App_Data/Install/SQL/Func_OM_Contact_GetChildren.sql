CREATE FUNCTION [Func_OM_Contact_GetChildren] 
(
	@currentContactId int,
	@includeParent int
)
RETURNS @result TABLE
(
	ContactID int
)
AS
BEGIN
    -- Recursively find all children of current contact
    WITH Recursion(ContactID)
    AS
    (
        SELECT ContactID
        FROM OM_Contact c
        WHERE c.ContactMergedWithContactID = @currentContactID
        UNION ALL
        SELECT c.ContactID
        FROM OM_Contact c INNER JOIN Recursion r ON c.ContactMergedWithContactID = r.ContactID
    )
    INSERT INTO @result SELECT ContactID FROM Recursion 
	-- Include parent contact ID in result
	IF @includeParent = 1
      INSERT INTO @result VALUES (@currentContactId)
	RETURN 
END
