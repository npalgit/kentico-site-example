using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.Synchronization;
using CMS.SettingsProvider;
using CMS.SynchronizationEngine;

public partial class CMSModules_Integration_Controls_UI_IntegrationTask_List : CMSAdminListControl
{
    #region "Properties"

    /// <summary>
    /// Inner grid.
    /// </summary>
    public UniGrid Grid
    {
        get
        {
            return gridElem;
        }
    }


    /// <summary>
    /// Indicates if the control should perform the operations.
    /// </summary>
    public override bool StopProcessing
    {
        get
        {
            return base.StopProcessing;
        }
        set
        {
            base.StopProcessing = value;
            gridElem.StopProcessing = value;
        }
    }


    /// <summary>
    /// Determines whether to display inbound or outbound tasks
    /// </summary>
    public bool TasksAreInbound
    {
        get;
        set;
    }


    /// <summary>
    /// Identifier of selected connector.
    /// </summary>
    public int ConnectorID
    {
        get;
        set;
    }


    /// <summary>
    /// Indicates if the control is used on the live site.
    /// </summary>
    public override bool IsLiveSite
    {
        get
        {
            return base.IsLiveSite;
        }
        set
        {
            base.IsLiveSite = value;
            gridElem.IsLiveSite = value;
        }
    }

    #endregion


    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        if (StopProcessing)
        {
            // Do nothing
        }
        else
        {
            gridElem.OnBeforeDataReload += gridElem_OnBeforeDataReload;
            gridElem.OnExternalDataBound += gridElem_OnExternalDataBound;
            gridElem.OnAction += gridElem_OnAction;
        }
    }

    #endregion


    #region "Grid events"

    protected void gridElem_OnBeforeDataReload()
    {
        gridElem.WhereCondition = SqlHelperClass.AddWhereCondition(gridElem.WhereCondition, "TaskIsInbound = " + Convert.ToInt32(TasksAreInbound));
        if (ConnectorID > 0)
        {
            gridElem.WhereCondition = SqlHelperClass.AddWhereCondition(gridElem.WhereCondition, "ConnectorID = " + ConnectorID);
            gridElem.GridView.Columns[4].Visible = false;
        }
    }


    protected object gridElem_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        DataRowView drv = null;
        switch (sourceName.ToLower())
        {
            case "result":
                drv = parameter as DataRowView;
                string errorMsg = ValidationHelper.GetString(drv["SynchronizationErrorMessage"], string.Empty);

                bool errorOccurred = !string.IsNullOrEmpty(errorMsg);
                if (errorOccurred)
                {
                    int synchronizationId = ValidationHelper.GetInteger(drv["SynchronizationID"], 0);
                    string logUrl = ResolveUrl("~/CMSModules/Integration/Pages/Administration/Log.aspx?synchronizationid=") + synchronizationId;
                    return "<a target=\"_blank\" href=\"" + logUrl + "\" onclick=\"modalDialog('" + logUrl + "', 'tasklog', 700, 500); return false;\">" + GetString("Tasks.ResultFailed") + "</a>";
                }
                else
                {
                    return string.Empty;
                }

            case "view":
                if (sender is ImageButton)
                {
                    ImageButton viewButton = sender as ImageButton;
                    drv = UniGridFunctions.GetDataRowView(viewButton.Parent as DataControlFieldCell);
                    int taskId = ValidationHelper.GetInteger(drv["TaskID"], 0);
                    string detailUrl = ResolveUrl("~/CMSModules/Integration/Pages/Administration/View.aspx?taskid=") + taskId;
                    viewButton.OnClientClick = "modalDialog('" + detailUrl + "', 'tasklog', 700, 500); return false;";
                    return viewButton;
                }
                return parameter;

            case "run":
                if (sender is ImageButton)
                {
                    ImageButton runButton = sender as ImageButton;
                    if((TasksAreInbound && !IntegrationHelper.IntegrationProcessExternal) || (!TasksAreInbound && !IntegrationHelper.IntegrationProcessInternal))
                    {
                        runButton.ImageUrl = GetImageUrl("/Design/Controls/UniGrid/Actions/SynchronizeDisabled.png");
                        runButton.ToolTip = GetString("integration.processingdisabled");
                        runButton.OnClientClick = "return false;";
                        runButton.Style.Add(HtmlTextWriterStyle.Cursor, "default");
                        return runButton;
                    }
                }
                break;
        }
        return parameter;
    }


    protected void gridElem_OnAction(string actionName, object actionArgument)
    {
        int synchronizationId = ValidationHelper.GetInteger(actionArgument, 0);
        switch (actionName.ToLower())
        {
            case "delete":
                // Delete synchronization
                IntegrationSynchronizationInfoProvider.DeleteIntegrationSynchronizationInfo(synchronizationId);
                break;

            case "run":
                // Get synchronization
                IntegrationSynchronizationInfo synchronization = IntegrationSynchronizationInfoProvider.GetIntegrationSynchronizationInfo(synchronizationId);
                if (synchronization != null)
                {
                    // Get connector and task
                    IntegrationConnectorInfo connectorInfo = IntegrationConnectorInfoProvider.GetIntegrationConnectorInfo(synchronization.SynchronizationConnectorID);
                    IntegrationTaskInfo taskInfo = IntegrationTaskInfoProvider.GetIntegrationTaskInfo(synchronization.SynchronizationTaskID);
                    if ((connectorInfo != null) && (taskInfo != null))
                    {
                        // Get connector instance
                        BaseIntegrationConnector connector = IntegrationHelper.GetConnector(connectorInfo.ConnectorName) as BaseIntegrationConnector;
                        if (connector != null)
                        {
                            // Process the task
                            if (TasksAreInbound)
                            {
                                // Always try to process the task when requested from UI
                                taskInfo.TaskProcessType = IntegrationProcessTypeEnum.Default;
                                connector.ProcessExternalTask(taskInfo);
                            }
                            else
                            {
                                connector.ProcessInternalTask(taskInfo);
                            }
                        }
                    }
                }
                break;
        }
    }

    #endregion


    #region "Helper methods"


    #endregion
}