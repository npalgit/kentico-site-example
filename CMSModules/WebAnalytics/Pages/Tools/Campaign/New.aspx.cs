using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.WebAnalytics;
using CMS.FormControls;

// Breadcrumbs
[Breadcrumbs(2)]
[Breadcrumb(0, "campaign.campaign.list", "~/CMSModules/WebAnalytics/Pages/Tools/Campaign/List.aspx", null)]
[Breadcrumb(1, "campaign.campaign.new")]

public partial class CMSModules_WebAnalytics_Pages_Tools_Campaign_New : CMSWebAnalyticsPage
{
    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        EditForm.OnBeforeSave += new EventHandler(EditForm_OnBeforeSave);
        EditForm.OnAfterValidate += new EventHandler(EditForm_OnAfterValidate);

        CurrentMaster.Title.HelpTopicName = "campaign_general";
        CurrentMaster.Title.HelpName = "helpTopic";
    }


    void EditForm_OnBeforeSave(object sender, EventArgs e)
    {
        CampaignInfo ci = (CampaignInfo)EditForm.EditedObject;
        ci.CampaignSiteID = CMSContext.CurrentSiteID;
    }


    void EditForm_OnAfterValidate(object sender, EventArgs e)
    {
        // Validate ToDate > FromDate
        FormEngineUserControl fromField = EditForm.FieldControls["CampaignOpenFrom"] as FormEngineUserControl;
        FormEngineUserControl toField = EditForm.FieldControls["CampaignOpenTo"] as FormEngineUserControl;

        DateTime from = DateTimeHelper.ZERO_TIME;
        DateTime to = DateTimeHelper.ZERO_TIME;

        if (fromField != null)
        {
            from = ValidationHelper.GetDateTime(fromField.Value, DateTimeHelper.ZERO_TIME);
        }

        if (toField != null)
        {
            to = ValidationHelper.GetDateTime(toField.Value, DateTimeHelper.ZERO_TIME);
        }

        if ((from != DateTimeHelper.ZERO_TIME) && (to != DateTimeHelper.ZERO_TIME) && (from > to))
        {
            EditForm.StopProcessing = true;
            // Disable default error label
            EditForm.ErrorLabel = null;

            // Show specific label for this error
            lblError.Visible = true;
            lblError.ResourceString = "campaign.wronginterval";
        }
    }

    #endregion
}
