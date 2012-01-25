using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.GlobalHelper;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.CMSHelper;

public partial class CMSModules_ContactManagement_FormControls_AccountStatusDialog : CMSModalPage
{
    #region "Variables"

    private int siteId = -1;
    protected Hashtable mParameters;
    bool allowGlobal;
    bool allowSite;
    bool isSitemanager;

    #endregion


    #region "Properties"

    /// <summary>
    /// Stop processing flag.
    /// </summary>
    public bool StopProcessing
    {
        get
        {
            return gridElem.StopProcessing;
        }
        set
        {
            gridElem.StopProcessing = value;
        }
    }


    /// <summary>
    /// Hashtable containing dialog parameters.
    /// </summary>
    private Hashtable Parameters
    {
        get
        {
            if (mParameters == null)
            {
                string identificator = QueryHelper.GetString("params", null);
                mParameters = (Hashtable)WindowHelper.GetItem(identificator);
            }
            return mParameters;
        }
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        siteId = ValidationHelper.GetInteger(Parameters["siteid"], 0);
        if (siteId < 0)
        {
            StopProcessing = true;
            return;
        }

        if (!QueryHelper.ValidateHash("hash") || Parameters == null)
        {
            StopProcessing = true;
            return;
        }

        isSitemanager = ValidationHelper.GetBoolean(Parameters["issitemanager"], false);
        CurrentMaster.Title.TitleText = GetString("om.accountstatus.select");
        CurrentMaster.Title.TitleImage = GetImageUrl("Objects/OM_AccountStatus/object.png");
        Page.Title = CurrentMaster.Title.TitleText;
        string siteName = SiteInfoProvider.GetSiteName(siteId);
        CurrentUserInfo user = CMSContext.CurrentUser;
        allowSite = ConfigurationHelper.AuthorizedReadConfiguration(CMSContext.CurrentSiteID, false);
        allowGlobal = ConfigurationHelper.AuthorizedReadConfiguration(UniSelector.US_GLOBAL_RECORD, false, isSitemanager);


        // Check read permission
        if ((siteId > 0) && !allowSite && !allowGlobal)
        {
            RedirectToAccessDenied("cms.contactmanagement", "ReadConfiguration");
            return;
        }
        else if ((siteId == 0) && !allowGlobal)
        {
            RedirectToAccessDenied("cms.contactmanagement", "ReadGlobalConfiguration");
            return;
        }

        if (siteId > 0)
        {
            if (allowSite)
            {
                gridElem.WhereCondition = "AccountStatusSiteID = " + siteId;
            }
            // Check if global config is allowed for the site
            if (allowGlobal)
            {
                // Add account statuses from global configuration
                gridElem.WhereCondition = SqlHelperClass.AddWhereCondition(gridElem.WhereCondition, "AccountStatusSiteID IS NULL", "OR");
            }
        }
        else if ((siteId == 0) && allowGlobal)
        {
            gridElem.WhereCondition = "AccountStatusSiteID IS NULL";
        }

        gridElem.OnExternalDataBound += gridElem_OnExternalDataBound;
        gridElem.Pager.DefaultPageSize = 10;

        // Display 'Reset' button when 'none' status is allowed
        if (ValidationHelper.GetBoolean(Parameters["allownone"], false))
        {
            btnReset.Visible = true;
            btnReset.Click += btn_Click;
            btnReset.CommandArgument = "0";
        }
    }


    /// <summary>
    /// Unigrid external databound handler.
    /// </summary>
    protected object gridElem_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        switch (sourceName)
        {
            case "accountstatusdisplayname":
                LinkButton btn = new LinkButton();
                DataRowView drv = parameter as DataRowView;
                btn.Text = HTMLHelper.HTMLEncode(ValidationHelper.GetString(drv["AccountStatusDisplayName"], null));
                btn.Click += new EventHandler(btn_Click);
                btn.CommandArgument = ValidationHelper.GetString(drv["AccountStatusID"], null);
                btn.ToolTip = HTMLHelper.HTMLEncode(ValidationHelper.GetString(drv.Row["AccountStatusDescription"], null));
                return btn;
        }
        return parameter;
    }


    /// <summary>
    /// Account status selected event handler.
    /// </summary>
    protected void btn_Click(object sender, EventArgs e)
    {
        int statusId = ValidationHelper.GetInteger(((IButtonControl)sender).CommandArgument, 0);
        string script = ScriptHelper.GetScript(@"
wopener.SelectValue_" + ValidationHelper.GetString(Parameters["clientid"], string.Empty) + @"(" + statusId + @");
window.close();
");

        ScriptHelper.RegisterStartupScript(this.Page, typeof(string), "CloseWindow", script);
    }

    #endregion
}
