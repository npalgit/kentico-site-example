using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.LicenseProvider;

// Edited object
[EditedObject(OnlineMarketingObjectType.CONTENTPERSONALIZATIONVARIANT, "variantid")]

// Breadcrumbs
[Breadcrumbs(2)]
[Breadcrumb(0, "contentpersonalizationvariant.list", "~/CMSModules/OnlineMarketing/Pages/Content/ContentPersonalizationVariant/List.aspx?nodeid={?nodeid?}", null)]
[Breadcrumb(1, Text = "{%EditedObject.DisplayName%}", ExistingObject = true)]
[Breadcrumb(1, ResourceString = "contentpersonalizationvariant.new", NewObject = true)]

[Help("cpvariant_edit")]

public partial class CMSModules_OnlineMarketing_Pages_Content_ContentPersonalizationVariant_Edit : CMSPropertiesPage
{
    #region "Page events"

    /// <summary>
    /// Raises the <see cref="E:Init"/> event.
    /// </summary>
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        // Check license
        if (DataHelper.GetNotEmpty(URLHelper.GetCurrentDomain(), "") != "")
        {
            LicenseHelper.CheckFeatureAndRedirect(URLHelper.GetCurrentDomain(), FeatureEnum.ContentPersonalization);
        }

        // Check the Read permissions
        if (!CMSContext.CurrentUser.IsAuthorizedPerResource("cms.contentpersonalization", "Read"))
        {
            RedirectToAccessDenied(String.Format(GetString("general.permissionresource"), "Read", "Content personalization"));
        }
    }


    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check UI Permissions
        if ((CMSContext.CurrentUser == null) || (!CMSContext.CurrentUser.IsAuthorizedPerUIElement("CMS.Content", "Properties.Variants")))
        {
            RedirectToCMSDeskUIElementAccessDenied("CMS.Content", "Properties.Variants");
        }
    }

    #endregion
}
