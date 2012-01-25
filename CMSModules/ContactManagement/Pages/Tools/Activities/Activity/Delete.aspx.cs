using System;
using System.Collections;
using System.Data;
using System.Security.Principal;
using System.Text;
using System.Threading;
using System.Web;
using System.Collections.Generic;

using CMS.CMSHelper;
using CMS.DataEngine;
using CMS.EventLog;
using CMS.GlobalHelper;
using CMS.LicenseProvider;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using CMS.UIControls;

public partial class CMSModules_ContactManagement_Pages_Tools_Activities_Activity_Delete : CMSContactManagementActivitiesPage
{
    #region "Variables"

    private Hashtable mParameters = null;
    private static readonly Hashtable mErrors = new Hashtable();
    private string mReturnScript = null;
    private int mSiteID;

    #endregion


    #region "Properties"

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


    /// <summary>
    /// Current log context.
    /// </summary>
    public LogContext CurrentLog
    {
        get
        {
            return EnsureLog();
        }
    }


    /// <summary>
    /// Current Error.
    /// </summary>
    private string CurrentError
    {
        get
        {
            return ValidationHelper.GetString(mErrors["DeleteError_" + ctlAsync.ProcessGUID], string.Empty);
        }
        set
        {
            mErrors["DeleteError_" + ctlAsync.ProcessGUID] = value;
        }
    }


    /// <summary>
    /// Returns script for returning back to list page.
    /// </summary>
    private string ReturnScript
    {
        get
        {
            if (string.IsNullOrEmpty(mReturnScript) && (Parameters != null))
            {
                mReturnScript = "document.location.href = 'List.aspx?siteid=" + SiteID + (SiteManager ? "&issitemanager=1" : string.Empty) + "';";
            }

            return mReturnScript;
        }
    }


    /// <summary>
    /// Where condition used for multiple actions.
    /// </summary>
    private string WhereCondition
    {
        get
        {
            string where = string.Empty;
            if (Parameters != null)
            {
                where = ValidationHelper.GetString(Parameters["where"], string.Empty);
            }
            return where;
        }
    }


    /// <summary>
    /// Site ID retrieved from dialog parameters.
    /// </summary>
    public override int SiteID
    {
        get
        {
            if ((mSiteID == 0) && (Parameters != null))
            {
                mSiteID = ValidationHelper.GetInteger(Parameters["siteid"], 0);
            }
            return mSiteID;
        }
    }


    /// <summary>
    /// Site manager flag retrieved from dialog parameters.
    /// </summary>
    private bool SiteManager
    {
        get
        {
            bool issitemanager = false;
            if (Parameters != null)
            {
                issitemanager = ValidationHelper.GetBoolean(Parameters["issitemanager"], false);
            }
            return issitemanager;
        }
    }

    #endregion


    #region "Page methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check hash validity
        if (QueryHelper.ValidateHash("hash"))
        {
            // Initialize events
            ctlAsync.OnFinished += ctlAsync_OnFinished;
            ctlAsync.OnError += ctlAsync_OnError;
            ctlAsync.OnRequestLog += ctlAsync_OnRequestLog;
            ctlAsync.OnCancel += ctlAsync_OnCancel;

            pnlContent.Visible = true;
            pnlLog.Visible = false;

            if (!RequestHelper.IsCallback())
            {
                btnCancel.Attributes.Add("onclick", ctlAsync.GetCancelScript(true) + "return false;");

                // Setup page title text and image
                CurrentMaster.Title.TitleText = GetString("om.activity.deletetitle");
                CurrentMaster.Title.TitleImage = GetImageUrl("Objects/OM_Activity/delete.png");
                titleElemAsync.TitleText = GetString("om.activity.deleting");
                titleElemAsync.TitleImage = GetImageUrl("Objects/OM_Activity/delete.png");
            }
        }
        else
        {
            pnlContent.Visible = false;
        }
    }


    protected override void OnPreRender(EventArgs e)
    {
        lblError.Visible = (!string.IsNullOrEmpty(lblError.Text));
        btnNo.OnClientClick = ReturnScript + "return false;";

        base.OnPreRender(e);
    }


    protected void btnOK_Click(object sender, EventArgs e)
    {
        ActivityHelper.AuthorizedManageActivity(SiteID, true, SiteManager);

        EnsureAsyncLog();
        RunAsyncDelete();
    }

    #endregion


    #region "Async control event handlers"

    private void ctlAsync_OnCancel(object sender, EventArgs e)
    {
        ctlAsync.Parameter = null;
        AddError(GetString("om.deletioncanceled"));
        ltlScript.Text += ScriptHelper.GetScript("var __pendingCallbacks = new Array();RefreshCurrent();");
        lblError.Text = CurrentError;
        CurrentLog.Close();
    }


    private void ctlAsync_OnRequestLog(object sender, EventArgs e)
    {
        ctlAsync.Log = CurrentLog.Log;
    }


    private void ctlAsync_OnError(object sender, EventArgs e)
    {
        if (ctlAsync.Status == AsyncWorkerStatusEnum.Running)
        {
            ctlAsync.Stop();
        }
        ctlAsync.Parameter = null;
        lblError.Text = CurrentError;
        CurrentLog.Close();
    }


    private void ctlAsync_OnFinished(object sender, EventArgs e)
    {
        lblError.Text = CurrentError;
        CurrentLog.Close();

        if (!string.IsNullOrEmpty(CurrentError))
        {
            ctlAsync.Parameter = null;
            lblError.Text = CurrentError;
        }

        if (ctlAsync.Parameter != null)
        {
            // Return to the list page after successful deletion
            ltlScript.Text += ScriptHelper.GetScript(ctlAsync.Parameter.ToString());

            // Do not set the window title anymore
            CurrentMaster.Title.SetWindowTitle = false;
        }
    }

    #endregion


    #region "Delete methods"

    /// <summary>
    /// Starts asycnhronous deleting of contacts.
    /// </summary>
    private void RunAsyncDelete()
    {
        ctlAsync.Parameter = ReturnScript;
        ctlAsync.RunAsync(Delete, WindowsIdentity.GetCurrent());
    }


    /// <summary>
    /// Deletes activities.
    /// </summary>
    private void Delete(object parameter)
    {
        string whereCondition = WhereCondition;
        try
        {
            // Check permissions for all sites in which some activities are deleted
            InfoObjectCollection<ActivityInfo> activitySites = ActivityInfoProvider.GetActivities(WhereCondition, "ActivitySiteID", 0, "DISTINCT ActivitySiteID").Items;
            foreach (ActivityInfo activitySite in activitySites)
            {
                if (!CurrentUser.IsAuthorizedPerObject(PermissionsEnum.Modify, "om.activity", activitySite.ActivitySiteID.ToString()))
                {
                    // Show error
                    SiteInfo notAllowedSite = SiteInfoProvider.GetSiteInfo(activitySite.ActivitySiteID);
                    AddError(String.Format(GetString("accessdeniedtopage.info"), ResHelper.LocalizeString(notAllowedSite.DisplayName)));
                    // And query this site out
                    whereCondition = SqlHelperClass.AddWhereCondition(whereCondition, "ActivitySiteID <> " + activitySite.ActivitySiteID);
                }
            }

            // Delete activities one by one
            InfoObjectCollection<ActivityInfo> activitiesToDelete = ActivityInfoProvider.GetActivities(whereCondition, "ActivityID", 0, "ActivityID, ActivityType, ActivityTitle").Items;
            foreach (ActivityInfo activity in activitiesToDelete)
            {
                LogContext.AppendLine(activity.ActivityTitle + " - " + activity.ActivityType);
                activity.Delete();
            }
        }
        catch (ThreadAbortException ex)
        {
            string state = ValidationHelper.GetString(ex.ExceptionState, string.Empty);
            if (state != CMSThread.ABORT_REASON_STOP)
            {
                LogExceptionToEventLog(ex);
            }
        }
        catch (Exception ex)
        {
            LogExceptionToEventLog(ex);
        }
    }

    #endregion


    #region "Log methods"

    /// <summary>
    /// When exception occures, log it to event log.
    /// </summary>
    /// <param name="ex">Exception to log</param>
    private void LogExceptionToEventLog(Exception ex)
    {
        EventLogProvider.LogException("Contact management", "DELETEACTIVITY", ex);
        AddError(GetString("om.activity.deletefailed") + ": " + ex.Message);
    }


    /// <summary>
    /// Adds the error to collection of errors.
    /// </summary>
    /// <param name="error">Error message</param>
    protected void AddError(string error)
    {
        EnsureLog();
        LogContext.AppendLine(error);
        CurrentError = (error + "<br />" + CurrentError);
    }


    /// <summary>
    /// Ensures log for asynchronous control
    /// </summary>
    private void EnsureAsyncLog()
    {
        pnlLog.Visible = true;
        pnlContent.Visible = false;

        CurrentError = string.Empty;
        CurrentLog.Close();
        EnsureLog();
    }


    /// <summary>
    /// Ensures the logging context.
    /// </summary>
    protected LogContext EnsureLog()
    {
        LogContext log = LogContext.EnsureLog(ctlAsync.ProcessGUID);
        log.Reversed = true;
        log.LineSeparator = "<br />";
        return log;
    }

    #endregion
}