CREATE VIEW [View_OM_Account_Joined]
AS
SELECT     dbo.OM_Account.AccountID, dbo.OM_Account.AccountName, dbo.OM_Account.AccountAddress1, dbo.OM_Account.AccountAddress2, dbo.OM_Account.AccountCity, 
                      dbo.OM_Account.AccountZIP, dbo.OM_Account.AccountStateID, dbo.OM_Account.AccountCountryID, dbo.OM_Account.AccountWebSite, dbo.OM_Account.AccountPhone, 
                      dbo.OM_Account.AccountEmail, dbo.OM_Account.AccountFax, dbo.OM_Account.AccountPrimaryContactID, dbo.OM_Account.AccountSecondaryContactID, 
                      dbo.OM_Account.AccountStatusID, dbo.OM_Account.AccountNotes, dbo.OM_Account.AccountOwnerUserID, dbo.OM_Account.AccountSubsidiaryOfID, 
                      dbo.OM_Account.AccountMergedWithAccountID, dbo.OM_Account.AccountSiteID, dbo.OM_Account.AccountGUID, dbo.OM_Account.AccountLastModified, 
                      dbo.OM_Account.AccountCreated, dbo.OM_Account.AccountGlobalAccountID, PrimaryContact.ContactFirstName AS PrimaryContactFirstName, 
                      PrimaryContact.ContactMiddleName AS PrimaryContactMiddleName, PrimaryContact.ContactLastName AS PrimaryContactLastName, 
                      SecondaryContact.ContactFirstName AS SecondaryContactFirstName, SecondaryContact.ContactMiddleName AS SecondaryContactMiddleName, 
                      SecondaryContact.ContactLastName AS SecondaryContactLastName, dbo.CMS_User.FullName, SubsidiaryOf.AccountName AS SubsidiaryOfName, 
                      ISNULL(PrimaryContact.ContactFirstName, '') + CASE PrimaryContact.ContactFirstName WHEN '' THEN '' WHEN NULL 
                      THEN '' ELSE ' ' END + ISNULL(PrimaryContact.ContactMiddleName, '') + CASE PrimaryContact.ContactMiddleName WHEN '' THEN '' WHEN NULL 
                      THEN '' ELSE ' ' END + ISNULL(PrimaryContact.ContactLastName, '') AS PrimaryContactFullName, ISNULL(SecondaryContact.ContactFirstName, '') 
                      + CASE SecondaryContact.ContactFirstName WHEN '' THEN '' WHEN NULL THEN '' ELSE ' ' END + ISNULL(SecondaryContact.ContactMiddleName, '') 
                      + CASE SecondaryContact.ContactMiddleName WHEN '' THEN '' WHEN NULL THEN '' ELSE ' ' END + ISNULL(SecondaryContact.ContactLastName, '') 
                      AS SecondaryContactFullName, ISNULL(dbo.OM_Account.AccountAddress1, '') + CASE OM_Account.AccountAddress1 WHEN '' THEN '' WHEN NULL 
                      THEN '' ELSE ' ' END + dbo.OM_Account.AccountAddress2 AS AccountFullAddress
FROM         dbo.OM_Account LEFT OUTER JOIN
                      dbo.OM_Contact AS PrimaryContact ON dbo.OM_Account.AccountPrimaryContactID = PrimaryContact.ContactID LEFT OUTER JOIN
                      dbo.OM_Contact AS SecondaryContact ON dbo.OM_Account.AccountSecondaryContactID = SecondaryContact.ContactID LEFT OUTER JOIN
                      dbo.CMS_User ON dbo.OM_Account.AccountOwnerUserID = dbo.CMS_User.UserID LEFT OUTER JOIN
                      dbo.OM_Account AS SubsidiaryOf ON dbo.OM_Account.AccountSubsidiaryOfID = SubsidiaryOf.AccountID
GO
