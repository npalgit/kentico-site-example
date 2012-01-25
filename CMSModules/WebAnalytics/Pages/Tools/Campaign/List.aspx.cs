using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.WebAnalytics;

// Actions
[Actions(1)]
[Action(0, "Objects/Analytics_Campaign/add.png", "campaign.campaign.new", "New.aspx")]

public partial class CMSModules_WebAnalytics_Pages_Tools_Campaign_List : CMSWebAnalyticsPage
{
    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #endregion
}
