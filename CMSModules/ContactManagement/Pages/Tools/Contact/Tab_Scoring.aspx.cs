using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;

[EditedObject(OnlineMarketingObjectType.CONTACT, "contactID")]

public partial class CMSModules_ContactManagement_Pages_Tools_Contact_Tab_Scoring : CMSScorePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check read permission 
        int siteID = ContactHelper.ObjectSiteID(EditedObject);
        if (!ContactHelper.AuthorizedReadContact(siteID, false))
        {
            RedirectToCMSDeskAccessDenied("CMS.ContactManagement", "ReadContacts");
        }

        // Check that user is authroized for the module
        CurrentUserInfo user = CMSContext.CurrentUser;
        if (!user.IsAuthorizedPerResource("CMS.Scoring", "Read"))
        {
            RedirectToAccessDenied("CMS.Scoring", "Read");
        }

        // Set up control
        ContactInfo ci = (ContactInfo)CMSPage.EditedObject;
        cScoring.ContactID = ci.ContactID;
        cScoring.SiteID = ci.ContactSiteID;
        cScoring.UniGrid.ZeroRowsText = GetString("om.score.notfound");
    }
}