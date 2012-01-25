CREATE PROCEDURE [Proc_OM_Contact_MassDelete]
	@where nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	-- Variables
	DECLARE @DeletedContacts TABLE (
		ContactID int NOT NULL,
		ContactSiteID int NULL
	);	
	DECLARE @DeletedMergedContacts TABLE (
		ContactID int NOT NULL
	);		
	DECLARE @currentContactID int;
	DECLARE @currentContactSiteID int;
	DECLARE @currentDeletedContactID int;
	DECLARE @sqlQuery NVARCHAR(MAX);
	-- Get TOP 1000 of deleted contacts
	SET @sqlQuery = 'SELECT TOP 1000 ContactID, ContactSiteID FROM OM_Contact WHERE ' + @where;
	INSERT INTO @DeletedContacts EXEC(@sqlQuery);
	-- Process first batch of records
	WHILE ((SELECT Count(*) FROM @DeletedContacts) > 0)
	BEGIN			
		-- Loop through records
		WHILE ((SELECT Count(*) FROM @DeletedContacts) > 0)
		BEGIN	
			SELECT TOP 1 @currentContactID = ContactID, @currentContactSiteID = ContactSiteID FROM @DeletedContacts;
			-- Get merged contacts
			IF @currentContactSiteID > 0
				INSERT INTO @DeletedMergedContacts SELECT ContactID FROM Func_OM_Contact_GetChildren(@currentContactID, 1)
			ELSE
				INSERT INTO @DeletedMergedContacts SELECT ContactID FROM Func_OM_Contact_GetChildren_Global(@currentContactID, 1)
					/* Remove all references */
					UPDATE OM_Contact SET [ContactGlobalContactID] = NULL WHERE [ContactGlobalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					UPDATE OM_Contact SET [ContactMergedWithContactID] = NULL WHERE [ContactMergedWithContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					UPDATE OM_Account SET [AccountPrimaryContactID] = NULL WHERE [AccountPrimaryContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					UPDATE OM_Account SET [AccountSecondaryContactID] = NULL WHERE [AccountSecondaryContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					/* Remove all relations */
					DELETE FROM OM_AccountContact WHERE [ContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					DELETE FROM OM_ContactGroupMember WHERE ContactGroupMemberType=0 AND (ContactGroupMemberRelatedID  IN (SELECT ContactID FROM @DeletedMergedContacts))
					DELETE FROM [OM_Membership] WHERE [OriginalContactID]  IN (SELECT ContactID FROM @DeletedMergedContacts) OR [ActiveContactID]  IN (SELECT ContactID FROM @DeletedMergedContacts);
					DELETE FROM [OM_IP] WHERE [IPActiveContactID] IN (SELECT ContactID FROM @DeletedMergedContacts) OR [IPOriginalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					DELETE FROM [OM_UserAgent] WHERE [UserAgentActiveContactID] IN (SELECT ContactID FROM @DeletedMergedContacts) OR [UserAgentOriginalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					DELETE FROM [OM_ScoreContactRule] WHERE [ContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
					/* Delete relations from depending activity */
					DELETE FROM [OM_PageVisit] WHERE [PageVisitActivityID] IN (SELECT [ActivityID] FROM OM_Activity WHERE [ActivityActiveContactID] IN (SELECT ContactID FROM @DeletedMergedContacts) OR [ActivityOriginalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts));
					DELETE FROM [OM_Search] WHERE [SearchActivityID] IN (SELECT [ActivityID] FROM OM_Activity WHERE [ActivityActiveContactID] IN (SELECT ContactID FROM @DeletedMergedContacts) OR [ActivityOriginalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts));
					DELETE FROM [OM_Activity] WHERE [ActivityActiveContactID] IN (SELECT ContactID FROM @DeletedMergedContacts) OR [ActivityOriginalContactID] IN (SELECT ContactID FROM @DeletedMergedContacts);
				
			
			-- Delete merged and parent records
			WHILE ((SELECT Count(*) FROM @DeletedMergedContacts) > 0)
			BEGIN
				SELECT TOP 1 @currentDeletedContactID = ContactID FROM @DeletedMergedContacts;
				-- Delete record
				DELETE FROM OM_Contact WHERE ContactID = @currentDeletedContactID;
				DELETE FROM @DeletedMergedContacts WHERE ContactID = @currentDeletedContactID
			END
			DELETE FROM @DeletedContacts WHERE ContactID = @currentContactID;
		END
		INSERT INTO @DeletedContacts EXEC(@sqlQuery);
	END
END
