using System;

using CMS.CMSHelper;
using CMS.ExtendedControls;
using CMS.FormControls;
using CMS.GlobalHelper;
using CMS.Polls;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.FormEngine;
using CMS.PortalEngine;

public partial class CMSModules_Polls_FormControls_PollSelector : FormEngineUserControl
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
            base.Enabled = value;
            uniSelector.Enabled = value; 
        }
    }


    /// <summary>
    /// Gets or sets field value.
    /// </summary>
    public override object Value
    {
        get
        {
            return this.uniSelector.Value;
        }
        set
        {
            if (uniSelector == null)
            {
                this.pnlUpdate.LoadContainer();
            }
            this.uniSelector.Value = value;
        }
    }


    /// <summary>
    /// Gets ClientID of the dropdownlist with polls.
    /// </summary>
    public override string ValueElementID
    {
        get
        {
            return this.uniSelector.TextBoxSelect.ClientID;
        }
    }


    /// <summary>
    /// Gets or sets if site filter should be shown or not.
    /// </summary>
    public bool ShowSiteFilter
    {
        get
        {
            return ValidationHelper.GetBoolean(this.GetValue("ShowSiteFilter"), true);
        }
        set
        {
            this.SetValue("ShowSiteFilter", value);
        }
    }


    /// <summary>
    /// Gets or sets value that indicates whether group polls is included in list.
    /// </summary>
    private bool ShowGroupPolls
    {
        get;
        set;
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.StopProcessing)
        {
            this.uniSelector.StopProcessing = true;
        }
        else
        {
            if (!SettingsKeyProvider.GetBoolValue(CMSContext.CurrentSiteName + ".CMSPollsAllowGlobal"))
            {
                this.ShowSiteFilter = false;
            }
            ReloadData();
        }
    }


    /// <summary>
    /// Returns TRUE if selector is used in group webpart.
    /// </summary>
    private bool IsGroupPollWebpart()
    {
        int webpartId = QueryHelper.GetInteger("webpartid", 0);
        string webpartName = QueryHelper.GetString("webpartname", null);
        WebPartInfo webpart = null;
        if (webpartId > 0)
        {
            webpart = WebPartInfoProvider.GetWebPartInfo(webpartId);
        }
        else if (webpartName != null)
        {
            webpart = WebPartInfoProvider.GetWebPartInfo(webpartName);
        }

        return (webpart != null) && (webpart.WebPartFileName.IndexOf("grouppoll", StringComparison.InvariantCultureIgnoreCase) != -1);
    }


    /// <summary>
    /// Rturns TRUE if selector is used in group widget.
    /// </summary>
    private bool IsGroupPollWidget()
    {
        int widgetId = QueryHelper.GetInteger("widgetid", 0);
        string widgetName = QueryHelper.GetString("widgetname", null);
        WidgetInfo widget = null;
        if (widgetId > 0)
        {
            widget = WidgetInfoProvider.GetWidgetInfo(widgetId);
        }
        else if (widgetName != null)
        {
            widget = WidgetInfoProvider.GetWidgetInfo(widgetName);
        }

        return (widget != null) && (widget.WidgetName.IndexOf("grouppoll", StringComparison.InvariantCultureIgnoreCase) != -1);
    }


    /// <summary>
    /// Reloads the data in the selector.
    /// </summary>
    public void ReloadData()
    {
        // Return form name or ID according to type of field (if no field specified form name is returned)
        if ((this.FieldInfo != null) && ((this.FieldInfo.DataType == FormFieldDataTypeEnum.Integer) || (this.FieldInfo.DataType == FormFieldDataTypeEnum.LongInteger)))
        {
            object value = uniSelector.Value;
            this.uniSelector.SelectionMode = SelectionModeEnum.SingleDropDownList;
            this.uniSelector.AllowEmpty = true;
            this.ShowSiteFilter = false;
            this.ShowGroupPolls = true;
            uniSelector.Value = value;
        }
        else
        {
            this.uniSelector.OnSelectionChanged += new EventHandler(uniSelector_OnSelectionChanged);
        }

        CurrentUserInfo user = CMSContext.CurrentUser;

        this.uniSelector.IsLiveSite = this.IsLiveSite;
        this.uniSelector.ReturnColumnName = "PollID";

        // Check if running in group poll webpart
        if (IsGroupPollWidget() || IsGroupPollWebpart())
        {
            // Restrict list to current group
            int groupId = QueryHelper.GetInteger("groupid", 0);
            string where = "PollGroupID=" + groupId;
            uniSelector.WhereCondition = SqlHelperClass.AddWhereCondition(uniSelector.WhereCondition, where);
        }
        else
        {
            if (this.ShowSiteFilter)
            {
                // Init site filter
                int currSiteId = CMSContext.CurrentSiteID;
                this.uniSelector.FilterControl = "~/CMSModules/Polls/Controls/Filters/SiteSelector.ascx";
            }
            else
            {
                // Set filter WHERE condition according to user permissions
                string where = null;
                if (!ShowGroupPolls)
                {
                    where = "PollGroupID IS NULL";
                }
                where = SqlHelperClass.AddWhereCondition(where, "PollSiteID=" + CMSContext.CurrentSiteID);
                uniSelector.WhereCondition = SqlHelperClass.AddWhereCondition(uniSelector.WhereCondition, where);
            }
        }
    }


    protected void uniSelector_OnSelectionChanged(object sender, EventArgs e)
    {
        // Translate selected ID to ".<code name>" (for global polls) or "<codename>" (for site polls)
        int id = ValidationHelper.GetInteger(uniSelector.Text, 0);
        if (id > 0)
        {
            PollInfo pi = PollInfoProvider.GetPollInfo(id);
            if (pi != null)
            {
                uniSelector.Text = string.Empty;
                if (pi.PollSiteID <= 0)
                {
                    uniSelector.Text = ".";
                }

                uniSelector.Text += pi.PollCodeName;
            }
        }
    }


    /// <summary>
    /// Returns WHERE condition for selected form.
    /// </summary>
    public override string GetWhereCondition()
    {
        // Return correct WHERE condition for integer if none value is selected
        if ((this.FieldInfo != null) && ((this.FieldInfo.DataType == FormFieldDataTypeEnum.Integer) || (this.FieldInfo.DataType == FormFieldDataTypeEnum.LongInteger)))
        {
            int id = ValidationHelper.GetInteger(uniSelector.Value, 0);
            if (id > 0)
            {
                return base.GetWhereCondition();
            }
        }
        return null;
    }

    #endregion
}
