using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.FormControls;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using CMS.CMSHelper;
using CMS.OnlineMarketing;

public partial class CMSModules_ContactManagement_FormControls_AccountStatusSelector : FormEngineUserControl
{
    #region "Properties"

    /// <summary>
    /// Gets or sets the enabled state of the control.
    /// </summary>
    public override bool Enabled
    {
        get
        {
            return base.Enabled;
        }
        set
        {
            this.EnsureChildControls();
            base.Enabled = value;
            this.uniselector.Enabled = value;
        }
    }


    /// <summary>
    /// Gets or sets field value.
    /// </summary>
    public override object Value
    {
        get
        {
            EnsureChildControls();
            if (uniselector.Value.ToString() == UniSelector.US_NONE_RECORD.ToString())
            {
                return null;
            }
            else
            {
                return uniselector.Value;
            }
        }
        set
        {
            this.EnsureChildControls();
            uniselector.Value = ValidationHelper.GetString(value, "");
        }
    }


    /// <summary>
    /// Gets or sets SiteID of account statuses.
    /// </summary>
    public int SiteID
    {
        get;
        set;
    }


    /// <summary>
    /// Returns Uniselector.
    /// </summary>
    public UniSelector UniSelector
    {
        get
        {
            if (uniselector == null)
            {
                pnlUpdate.LoadContainer();
            }
            return uniselector;
        }
    }


    /// <summary>
    /// Dropdownlist used in Uniselector.
    /// </summary>
    public DropDownList DropDownList
    {
        get
        {
            if (uniselector == null)
            {
                pnlUpdate.LoadContainer();
            }
            return uniselector.DropDownSingleSelect;
        }
    }


    /// <summary>
    /// Specifies, whether the selector allows selection of all items. If the dialog allows selection of all items, 
    /// it displays the (all) field in the DDL variant and All button in the Textbox variant (default false). 
    /// When property is selected then Uniselector doesn't load any data from DB, it just returns -1 value 
    /// and external code must handle data loading.
    /// </summary>
    public bool AllowAllItem
    {
        get
        {
            return uniselector.AllowAll;
        }
        set
        {
            uniselector.AllowAll = value;
        }
    }


    /// <summary>
    /// Gets or sets if all contact statuses regardless of site should be displayed.
    /// </summary>
    public bool DisplayAll
    {
        get;
        set;
    }


    /// <summary>
    /// Gets or sets if only global and site statuses should be displayed.
    /// </summary>
    public bool DisplaySiteOrGlobal
    {
        get;
        set;
    }


    /// <summary>
    /// Gets selected AccountStatusID.
    /// </summary>
    public int AccountStatusID
    {
        get
        {
            return ValidationHelper.GetInteger(this.Value, 0);
        }
    }


    /// <summary>
    /// SQL WHERE condition of uniselector.
    /// </summary>
    public string WhereCondition
    {
        get;
        set;
    }


    /// <summary>
    /// Gets or sets if current context is in sitemanager.
    /// </summary>
    public bool IsSiteManager
    {
        get;
        set;
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        if (StopProcessing)
        {
            uniselector.StopProcessing = true;
        }
        else
        {
            ReloadData();
        }
    }


    /// <summary>
    /// Reloads control.
    /// </summary>
    public void ReloadData()
    {
        string where = WhereCondition;
        CurrentUserInfo user = CMSContext.CurrentUser;
        bool allowSite = false;
        bool allowGlobal = ConfigurationHelper.AuthorizedReadConfiguration(UniSelector.US_GLOBAL_RECORD, false, IsSiteManager);

        if (SiteID > 0)
        {
            allowSite = ConfigurationHelper.AuthorizedReadConfiguration(SiteID, false);
        }
        else
        {
            allowSite = ConfigurationHelper.AuthorizedReadConfiguration(CMSContext.CurrentSiteID, false);
        }

        if (DisplayAll || DisplaySiteOrGlobal)
        {
            // Display all site and global statuses
            if (DisplayAll && allowSite && allowGlobal)
            {
                // No WHERE condition required
            }
            // Display current site and global statuses
            else if (DisplaySiteOrGlobal && allowSite && allowGlobal && (SiteID > 0))
            {
                where = SqlHelperClass.AddWhereCondition(where, "AccountStatusSiteID IS NULL OR AccountStatusSiteID = " + (SiteID == 0 ? CMSContext.CurrentSiteID : SiteID));
            }
            // Current site
            else if (allowSite && (SiteID > 0))
            {
                where = SqlHelperClass.AddWhereCondition(where, "AccountStatusSiteID = " + SiteID);
            }
            // Display global statuses
            else if (allowGlobal)
            {
                where = SqlHelperClass.AddWhereCondition(where, "AccountStatusSiteID IS NULL ");
            }
            // Don't display anything
            if (String.IsNullOrEmpty(where) && !DisplayAll)
            {
                where = "(1=0)";
            }
        }
        // Display either global or current site statuses
        else
        {
            // Current site
            if ((SiteID > 0) && allowSite)
            {
                where = SqlHelperClass.AddWhereCondition(where, "AccountStatusSiteID = " + SiteID);
            }
            // Display global statuses
            else if (((SiteID == UniSelector.US_GLOBAL_RECORD) || (SiteID == UniSelector.US_NONE_RECORD)) && allowGlobal)
            {
                where = SqlHelperClass.AddWhereCondition(where, "AccountStatusSiteID IS NULL ");
            }
            // Don't display anything
            if (String.IsNullOrEmpty(where))
            {
                where = "(1=0)";
            }
        }

        uniselector.WhereCondition = where;
        uniselector.Reload(true);
    }

    #endregion
}