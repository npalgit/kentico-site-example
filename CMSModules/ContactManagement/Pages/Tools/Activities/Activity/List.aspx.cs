using System;
using System.Data;

using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.CMSHelper;
using CMS.WebAnalytics;
using CMS.OnlineMarketing;
using CMS.SiteProvider;

[Security(Resource = "CMS.ContactManagement", Permission = "ReadActivities")]
public partial class CMSModules_ContactManagement_Pages_Tools_Activities_Activity_List : CMSContactManagementActivitiesPage
{
    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        string currSiteName = CMSContext.CurrentSiteName;
        int currSiteId = CMSContext.CurrentSiteID;

        if (ContactHelper.IsSiteManager)
        {
            currSiteId = this.SiteID;
            currSiteName = SiteInfoProvider.GetSiteName(currSiteId);
        }
        fltElem.SiteID = currSiteId;
        listElem.SiteID = currSiteId;

        // Show warning if activity logging is disabled
        if (!ActivitySettingsHelper.OnlineMarketingEnabled(currSiteName))
        {
            lblDis.ResourceString = "om.onlinemarketing.disabled";
        }
        pnlDis.Visible = !ActivitySettingsHelper.ActivitiesEnabledAndModuleLoaded(currSiteName);


        // Show site name column if activities of all sites are displayed
        listElem.ShowSiteNameColumn = (currSiteId == UniSelector.US_ALL_RECORDS);
        fltElem.ShowSiteFilter = (currSiteId == UniSelector.US_ALL_RECORDS);

        fltElem.ShowIPFilter = ActivitySettingsHelper.IPLoggingEnabled(currSiteName);
        listElem.ShowIPAddressColumn = fltElem.ShowIPFilter;

        listElem.OrderBy = "ActivityCreated DESC";
        listElem.WhereCondition = fltElem.WhereCondition;

        if (QueryHelper.GetInteger("saved", 0) == 1)
        {
            lblInfo.Visible = true;
            lblInfo.Text = GetString("general.changessaved");
        }

        // Disable manual creation of activitiy if no custom activity type is available
        DataSet ds = ActivityTypeInfoProvider.GetActivityTypes("ActivityTypeIsCustom=1 AND ActivityTypeEnabled=1 AND ActivityTypeManualCreationAllowed=1", null, 1, "ActivityTypeID");
        bool aCustomActivityExists = !DataHelper.DataSourceIsEmpty(ds);

        // Or there is no site to create activity on
        ds = SiteInfoProvider.GetSites("SiteID IN (SELECT SiteID FROM CMS_UserSite WHERE UserID = " + CMSContext.CurrentUser.UserID + ")", null, "SiteID", 1);
        bool aSiteExists = !DataHelper.DataSourceIsEmpty(ds);

        if (aCustomActivityExists && aSiteExists)
        {
            InitActions(1, null, null);
            string url = "New.aspx?siteid=" + currSiteId;
            if (ContactHelper.IsSiteManager)
            {
                url += "&issitemanager=1";
            }
            SetAction(0, "Objects/OM_Activity/add.png", GetString("om.activity.newcustom"), url);
        }
    }

    #endregion
}
