CREATE VIEW [View_OM_AccountContact_AccountJoined]
AS
SELECT     dbo.OM_Account.AccountID, dbo.OM_Account.AccountName, dbo.OM_AccountContact.ContactID, dbo.OM_AccountContact.AccountContactID, 
                      dbo.OM_AccountContact.ContactRoleID, dbo.OM_Account.AccountSiteID, dbo.OM_Account.AccountMergedWithAccountID, dbo.OM_Account.AccountGlobalAccountID, 
                      dbo.OM_Account.AccountCountryID, dbo.OM_Account.AccountStatusID
FROM         dbo.OM_AccountContact INNER JOIN
                      dbo.OM_Account ON dbo.OM_AccountContact.AccountID = dbo.OM_Account.AccountID
GO
