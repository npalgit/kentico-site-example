using System;

using CMS.UIControls;
using CMS.WebAnalytics;
using CMS.CMSHelper;
using CMS.OnlineMarketing;
using CMS.SiteProvider;
using CMS.GlobalHelper;

[Actions(1)]
[Action(0, "Objects/OM_ActivityType/add.png", "om.activitytype.new", "New.aspx")]

[Security(Resource = "CMS.ContactManagement", Permission = "ReadActivities")]
public partial class CMSModules_ContactManagement_Pages_Tools_Activities_ActivityType_List : CMSContactManagementActivitiesPage
{
    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        // Show warning if activity logging is disabled
        string currSiteName = CMSContext.CurrentSiteName;

        if (ContactHelper.IsSiteManager)
        {
            currSiteName = SiteInfoProvider.GetSiteName(QueryHelper.GetInteger("siteid", 0));
        }

        if (!ActivitySettingsHelper.OnlineMarketingEnabled(currSiteName))
        {
            lblDis.ResourceString = "om.onlinemarketing.disabled";
        }
        pnlDis.Visible = !ActivitySettingsHelper.ActivitiesEnabledAndModuleLoaded(currSiteName);

        CurrentMaster.HeaderActions.Actions[0, 3] = AddSiteQuery(CurrentMaster.HeaderActions.Actions[0, 3], QueryHelper.GetInteger("siteid", 0));
    }

    #endregion
}
