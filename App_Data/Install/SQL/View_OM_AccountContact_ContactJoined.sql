CREATE VIEW [View_OM_AccountContact_ContactJoined]
AS
SELECT     dbo.OM_Contact.ContactID, dbo.OM_Contact.ContactFirstName, dbo.OM_Contact.ContactMiddleName, dbo.OM_Contact.ContactLastName, 
                      dbo.OM_Contact.ContactEmail, dbo.OM_Contact.ContactSiteID, dbo.OM_Contact.ContactMergedWithContactID, dbo.OM_Contact.ContactGlobalContactID, 
                      dbo.OM_AccountContact.AccountID, dbo.OM_AccountContact.AccountContactID, dbo.OM_Contact.ContactCountryID, dbo.OM_Contact.ContactStatusID, 
                      dbo.OM_AccountContact.ContactRoleID
FROM         dbo.OM_AccountContact INNER JOIN
                      dbo.OM_Contact ON dbo.OM_AccountContact.ContactID = dbo.OM_Contact.ContactID
GO
