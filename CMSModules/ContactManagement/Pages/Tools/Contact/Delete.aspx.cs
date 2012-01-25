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
using System.Data.SqlClient;

public partial class CMSModules_ContactManagement_Pages_Tools_Contact_Delete : CMSContactManagementContactsPage
{
    #region "Private variables"

    private IList<string> contactIds = null;
    private int contactSiteId = 0;
    private static readonly Hashtable mErrors = new Hashtable();
    private Hashtable mParameters = null;
    private string mReturnScript = null;
    private int mSiteID = 0;
    private bool issitemanager = false;
    private int numberOfDeletedContacts = 0;
    private static int SQL_TIMEOUT = 72000;

    #endregion


    #region "Properties"

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
    /// Returns script for returning back to list page.
    /// </summary>
    private string ReturnScript
    {
        get
        {
            if (string.IsNullOrEmpty(mReturnScript) && (Parameters != null))
            {
                mReturnScript = "document.location.href = 'List.aspx?siteid=" + SiteID + (issitemanager ? "&issitemanager=1" : string.Empty) + "';";
            }

            return mReturnScript;
        }
    }


    /// <summary>
    /// Returns script for returning back to list page.
    /// </summary>
    private string ReturnScriptDeleteAsync
    {
        get
        {
            if (string.IsNullOrEmpty(mReturnScript) && (Parameters != null))
            {
                mReturnScript = "document.location.href = 'List.aspx?siteid=" + SiteID + (issitemanager ? "&issitemanager=1" : string.Empty) + "&deleteasync=1';";
            }

            return mReturnScript;
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
            };
            return mSiteID;
        }
    }

    #endregion


    #region "Page events"

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

            issitemanager = ValidationHelper.GetBoolean(Parameters["issitemanager"], false);

            if (!RequestHelper.IsCallback())
            {
                // Setup page title text and image
                CurrentMaster.Title.TitleText = GetString("om.contact.deletetitle");
                CurrentMaster.Title.TitleImage = GetImageUrl("Objects/OM_Contact/delete.png");

                btnCancel.Attributes.Add("onclick", ctlAsync.GetCancelScript(true) + "return false;");

                titleElemAsync.TitleText = GetString("om.contact.deleting");
                titleElemAsync.TitleImage = GetImageUrl("Objects/OM_Contact/delete.png");

                // Set visibility of panels
                pnlContent.Visible = true;
                pnlLog.Visible = false;

                // Get names of the contacts that are to be deleted
                DataSet ds = ContactInfoProvider.GetContacts(WhereCondition, "ContactLastName", 1000, "ContactID, ContactFirstName, ContactLastName, ContactSiteID");

                if (!DataHelper.DataSourceIsEmpty(ds))
                {
                    DataRowCollection rows = ds.Tables[0].Rows;

                    // Data set contains only one item...
                    if (rows.Count == 1)
                    {
                        // Get full contact name and use it in the title
                        string fullName = GetFullName(rows[0]);

                        if (!string.IsNullOrEmpty(fullName))
                        {
                            CurrentMaster.Title.TitleText += " \"" + HTMLHelper.HTMLEncode(fullName) + "\"";
                        }
                        contactIds = new List<string>(1);
                        contactIds.Add(ValidationHelper.GetString(DataHelper.GetDataRowValue(rows[0], "ContactID"), string.Empty));
                        contactSiteId = ValidationHelper.GetInteger(DataHelper.GetDataRowValue(rows[0], "ContactSiteID"), 0);
                        numberOfDeletedContacts = 1;
                    }
                    else if (rows.Count > 1)
                    {
                        // Modify title and question for multiple items
                        CurrentMaster.Title.TitleText = GetString("om.contact.deletetitlemultiple");
                        lblQuestion.ResourceString = "om.contact.deletemultiplequestion";

                        // Display list with names of deleted items
                        pnlContactList.Visible = true;

                        string name = null;
                        StringBuilder builder = new StringBuilder();

                        // Display top 1000 records
                        for (int i = 0; i < (rows.Count); i++)
                        {
                            name = GetFullName(rows[i]);
                            if (!string.IsNullOrEmpty(name))
                            {
                                builder.Append(HTMLHelper.HTMLEncode(name));
                            }
                            else
                            {
                                builder.Append("N/A");
                            }
                            builder.Append("<br />");
                        }
                        // Display three dots after last record
                        if (rows.Count == 1000)
                        {
                            builder.Append("...");
                        }

                        lblContacts.Text = builder.ToString();
                        contactSiteId = SiteID;

                        // Get all IDs of deleted items
                        ds = ContactInfoProvider.GetContacts(WhereCondition, "ContactID", 0, "ContactID");
                        contactIds = SqlHelperClass.GetStringValues(ds.Tables[0], "ContactID");
                        numberOfDeletedContacts = ds.Tables[0].Rows.Count;
                    }
                }
                else
                {
                    // Hide everything
                    pnlContent.Visible = false;
                }
            }
        }
        else
        {
            pnlDelete.Visible = false;
            lblError.Text = GetString("dialogs.badhashtext");
        }
    }


    protected override void OnPreRender(EventArgs e)
    {
        // Set visibility of controls
        lblError.Visible = (!string.IsNullOrEmpty(lblError.Text));
        brSeparator.Visible = pnlContactList.Visible;

        btnNo.OnClientClick = ReturnScript + "return false;";

        base.OnPreRender(e);
    }

    #endregion


    #region "Button actions"

    protected void btnOK_Click(object sender, EventArgs e)
    {
        // Check permissions
        ContactHelper.AuthorizedModifyContact(contactSiteId, true, issitemanager);

        EnsureAsyncLog();
        RunAsyncDelete();
    }

    #endregion


    #region "Methods"

    /// <summary>
    /// Returns contact name in the form 'lastname firstname' or null.
    /// </summary>
    /// <param name="row">Data row with contact info</param>
    protected string GetFullName(DataRow row)
    {
        string fullName = null;

        if (row != null)
        {
            // Compose full contact name
            fullName = string.Format("{0} {1}", ValidationHelper.GetString(DataHelper.GetDataRowValue(row, "ContactLastName"), string.Empty),
                ValidationHelper.GetString(DataHelper.GetDataRowValue(row, "ContactFirstName"), string.Empty)).Trim();
        }

        return fullName;
    }


    /// <summary>
    /// Delete contacts on SQL server.
    /// </summary>
    private void DeleteOnSql()
    {
        // Start deleting contacts
        ContactInfoProvider.DeleteContactInfos(WhereCondition);

        // Return to the list page with info label displayed
        ltlScript.Text += ScriptHelper.GetScript(this.ReturnScriptDeleteAsync);
    }


    /// <summary>
    /// Delete items.
    /// </summary>
    private void DeleteItems()
    {
        SqlConnectionStringBuilder connectionString = new SqlConnectionStringBuilder(ConnectionHelper.GetConnection().DataConnection.ConnectionString);
        connectionString.ConnectTimeout = SQL_TIMEOUT;
        using (var cs = new CMSConnectionScope(connectionString.ToString(), true))
        {
            ContactInfo ci = null;
            // Delete the contacts
            foreach (string contactId in contactIds)
            {
                ci = ContactInfoProvider.GetContactInfo(ValidationHelper.GetInteger(contactId, 0));
                if (ci != null)
                {
                    // Display name of deleted contact
                    AddLog((ci.ContactLastName + " " + ci.ContactFirstName).Trim());

                    // Delete contact with its dependencies
                    ContactHelper.Delete(ci, chkChildren.Checked, chkMoveRelations.Checked);
                }
            }
        }
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
    /// Starts asycnhronous deleting of contacts.
    /// </summary>
    private void RunAsyncDelete()
    {
        // Run the async method
        ctlAsync.Parameter = ReturnScript;
        ctlAsync.RunAsync(Delete, WindowsIdentity.GetCurrent());
    }

    #endregion


    #region "Async methods"

    /// <summary>
    /// Deletes document(s).
    /// </summary>
    private void Delete(object parameter)
    {
        if (parameter == null || contactIds.Count < 1)
        {
            return;
        }

        try
        {
            // Begin log
            AddLog(GetString("om.contact.deleting"));
            AddLog(string.Empty);

            // Mass delete without logging items
            if (chkChildren.Checked && !chkMoveRelations.Checked && (numberOfDeletedContacts > 1))
            {
                DeleteOnSql();
            }
            // Delete items
            else
            {
                DeleteItems();
            }
        }
        catch (ThreadAbortException ex)
        {
            string state = ValidationHelper.GetString(ex.ExceptionState, string.Empty);
            if (state == CMSThread.ABORT_REASON_STOP)
            {
                // When canceled
                AddError(GetString("om.deletioncanceled"));
            }
            else
            {
                // Log error
                LogExceptionToEventLog(ex);
            }
        }
        catch (Exception ex)
        {
            // Log error
            LogExceptionToEventLog(ex);
        }
    }


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


    /// <summary>
    /// Adds the log information.
    /// </summary>
    /// <param name="newLog">New log information</param>
    protected void AddLog(string newLog)
    {
        EnsureLog();
        LogContext.AppendLine(newLog);
    }


    /// <summary>
    /// Adds the error to collection of errors.
    /// </summary>
    /// <param name="error">Error message</param>
    protected void AddError(string error)
    {
        AddLog(error);
        CurrentError = (error + "<br />" + CurrentError);
    }


    /// <summary>
    /// When exception occures, log it to event log.
    /// </summary>
    /// <param name="ex">Exception to log</param>
    private void LogExceptionToEventLog(Exception ex)
    {
        EventLogProvider.LogException("Contact management", "DELETECONTACT", ex);
        AddError(GetString("om.contact.deletefailed") + ": " + ex.Message);
    }

    #endregion
}