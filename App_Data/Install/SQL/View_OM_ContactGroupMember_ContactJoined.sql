CREATE VIEW [View_OM_ContactGroupMember_ContactJoined]
AS
SELECT     dbo.OM_Contact.ContactID, dbo.OM_Contact.ContactFirstName, dbo.OM_Contact.ContactMiddleName, dbo.OM_Contact.ContactLastName, 
                      dbo.OM_Contact.ContactSalutation, dbo.OM_Contact.ContactTitleBefore, dbo.OM_Contact.ContactTitleAfter, dbo.OM_Contact.ContactJobTitle, 
                      dbo.OM_Contact.ContactAddress1, dbo.OM_Contact.ContactAddress2, dbo.OM_Contact.ContactCity, dbo.OM_Contact.ContactZIP, dbo.OM_Contact.ContactStateID, 
                      dbo.OM_Contact.ContactCountryID, dbo.OM_Contact.ContactMobilePhone, dbo.OM_Contact.ContactHomePhone, dbo.OM_Contact.ContactBusinessPhone, 
                      dbo.OM_Contact.ContactEmail, dbo.OM_Contact.ContactWebSite, dbo.OM_Contact.ContactBirthday, dbo.OM_Contact.ContactGender, dbo.OM_Contact.ContactStatusID, 
                      dbo.OM_Contact.ContactNotes, dbo.OM_Contact.ContactOwnerUserID, dbo.OM_Contact.ContactMonitored, dbo.OM_Contact.ContactMergedWithContactID, 
                      dbo.OM_Contact.ContactIsAnonymous, dbo.OM_Contact.ContactSiteID, dbo.OM_Contact.ContactGUID, dbo.OM_Contact.ContactLastModified, 
                      dbo.OM_Contact.ContactCreated, dbo.OM_Contact.ContactMergedWhen, dbo.OM_Contact.ContactGlobalContactID, dbo.OM_Contact.ContactBounces, 
                      dbo.OM_Contact.ContactLastLogon, dbo.OM_Contact.ContactCampaign, dbo.OM_ContactGroupMember.ContactGroupMemberContactGroupID, 
                      dbo.OM_ContactGroupMember.ContactGroupMemberFromCondition, dbo.OM_ContactGroupMember.ContactGroupMemberFromAccount, 
                      dbo.OM_ContactGroupMember.ContactGroupMemberFromManual, dbo.OM_ContactGroupMember.ContactGroupMemberID, 
                      dbo.OM_ContactGroup.ContactGroupDisplayName, dbo.OM_ContactGroup.ContactGroupName, dbo.OM_ContactGroup.ContactGroupID, 
                      dbo.OM_ContactGroup.ContactGroupSiteID
FROM         dbo.OM_ContactGroupMember INNER JOIN
                      dbo.OM_Contact ON dbo.OM_ContactGroupMember.ContactGroupMemberRelatedID = dbo.OM_Contact.ContactID INNER JOIN
                      dbo.OM_ContactGroup ON dbo.OM_ContactGroup.ContactGroupID = dbo.OM_ContactGroupMember.ContactGroupMemberContactGroupID
WHERE     (dbo.OM_ContactGroupMember.ContactGroupMemberType = 0)
GO
