CREATE VIEW [View_OM_ContactGroupMember_AccountJoined]
AS
SELECT     dbo.OM_Account.AccountID, dbo.OM_Account.AccountName, dbo.OM_Account.AccountAddress1, dbo.OM_Account.AccountAddress2, dbo.OM_Account.AccountCity, 
                      dbo.OM_Account.AccountZIP, dbo.OM_Account.AccountStateID, dbo.OM_Account.AccountCountryID, dbo.OM_Account.AccountWebSite, dbo.OM_Account.AccountPhone, 
                      dbo.OM_Account.AccountEmail, dbo.OM_Account.AccountFax, dbo.OM_Account.AccountPrimaryContactID, dbo.OM_Account.AccountSecondaryContactID, 
                      dbo.OM_Account.AccountStatusID, dbo.OM_Account.AccountNotes, dbo.OM_Account.AccountOwnerUserID, dbo.OM_Account.AccountSubsidiaryOfID, 
                      dbo.OM_Account.AccountMergedWithAccountID, dbo.OM_Account.AccountSiteID, dbo.OM_Account.AccountGUID, dbo.OM_Account.AccountLastModified, 
                      dbo.OM_Account.AccountCreated, dbo.OM_Account.AccountGlobalAccountID, dbo.OM_ContactGroupMember.ContactGroupMemberContactGroupID, 
                      dbo.OM_ContactGroupMember.ContactGroupMemberID
FROM         dbo.OM_ContactGroupMember INNER JOIN
                      dbo.OM_Account ON dbo.OM_ContactGroupMember.ContactGroupMemberRelatedID = dbo.OM_Account.AccountID
WHERE     (dbo.OM_ContactGroupMember.ContactGroupMemberType = 1)
GO
