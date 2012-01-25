using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.SiteProvider;
using CMS.SettingsProvider;
using CMS.WebAnalytics;

// Edited object
[EditedObject(AnalyticsObjectType.CAMPAIGN, "campaignid")]

// Breadcrumbs
[Breadcrumbs(2)]
[Breadcrumb(0, "campaign.campaign.list", "~/CMSModules/WebAnalytics/Pages/Tools/Campaign/List.aspx", "_parent")]
[Breadcrumb(1, Text = "{%EditedObject.DisplayName%}")]

// Create empty title for context help
[Title("", "", "campaign_general")]
public partial class CMSModules_WebAnalytics_Pages_Tools_Campaign_Header : CMSWebAnalyticsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int campaignID = QueryHelper.GetInteger("campaignId", 0);
        string[,] tabs = new string[4, 4];
        tabs[0, 0] = GetString ("general.general");
        tabs[0, 1] = "SetHelpTopic('helpTopic', 'campaign_general');";
        tabs[0, 2] = "Tab_General.aspx?campaignid=" + campaignID;

        tabs[1, 0] = GetString("analytics_codename.goals");
        tabs[1, 1] = "SetHelpTopic('helpTopic', 'campaign_goals');";
        tabs[1, 2] = "Tab_Goals.aspx?campaignid=" + campaignID;

        tabs[2, 0] = GetString("conversion.conversion.list"); ;
        tabs[2, 1] = "SetHelpTopic('helpTopic', 'campaign_conversions');";
        tabs[2, 2] = "Tab_Conversions.aspx?campaignid=" + campaignID;

        if (QueryHelper.GetBoolean("DisplayReport", false))
        {
            tabs[3, 0] = GetString("general.reports");
            tabs[3, 1] = "SetHelpTopic('helpTopic', 'campaign_report');";
            tabs[3, 2] = "Tab_Reports.aspx?campaignid=" + campaignID;
        }

        CurrentMaster.Tabs.Tabs = tabs;
        CurrentMaster.Tabs.UrlTarget = "content";
    }
}
