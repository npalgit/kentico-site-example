using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.ProjectManagement;

public partial class CMSModules_ProjectManagement_Controls_UI_Projecttaskstatus_List : CMSAdminListControl
{
    #region "Properties"

    /// <summary>
    /// Inner grid.
    /// </summary>
    public UniGrid Grid
    {
        get
        {
            return this.gridElem;
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
            this.gridElem.StopProcessing = value;
        }
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


    #region "Methods"

    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckPermissions("CMS.ProjectManagement", ProjectManagementPermissionType.MANAGE_CONFIGURATION);

        if (this.StopProcessing)
        {
            return;
        }

        // Grid initialization                
        gridElem.OnAction += new OnActionEventHandler(gridElem_OnAction);
        gridElem.OnExternalDataBound += new OnExternalDataBoundEventHandler(gridElem_OnExternalDataBound);
    }


    /// <summary>
    /// OnPreRender override.
    /// </summary>
    protected override void OnPreRender(EventArgs e)
    {
        lblError.Visible = (!string.IsNullOrEmpty(lblError.Text));
        base.OnPreRender(e);
    }


    /// <summary>
    /// Handles UniGrid's OnExternalDataBound event.
    /// </summary>
    /// <param name="sender">Sender object (image button if it is an external databoud for action button)</param>
    /// <param name="sourceName">External source name of the column specified in the grid XML</param>
    /// <param name="parameter">Source parameter (original value of the field)</param>
    protected object gridElem_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        switch (sourceName.ToLower())
        {
            case "taskstatuscolor":
                string statusColor = "-";
                if (!string.IsNullOrEmpty(parameter.ToString()))
                {
                    statusColor = "<div class='StatusColorBar' style='background-color: " + HTMLHelper.HTMLEncode(parameter.ToString()) + ";'></div>";
                }
                return statusColor;

            case "taskstatusenabled":
                return UniGridFunctions.ColoredSpanYesNo(parameter);

            case "taskstatusisnotstarted":
                return UniGridFunctions.ColoredSpanYesNo(parameter);

            case "taskstatusicon":
                string url = ValidationHelper.GetString(parameter, "");
                if (!String.IsNullOrEmpty(url))
                {
                    url = "<img alt=\"Status image\" src=\"" + URLHelper.ResolveUrl(HTMLHelper.HTMLEncode(url)) + "\" style=\"max-width:50px; max-height: 50px;\"  />";
                    return url;
                }
                return "";

            case "taskstatusisfinished":
                return UniGridFunctions.ColoredSpanYesNo(parameter);
        }

        return parameter;
    }


    /// <summary>
    /// Handles UniGrid's OnAction event.
    /// </summary>
    /// <param name="actionName">Name of the action which should be performed</param>
    /// <param name="actionArgument">ID of the item the action should be performed with</param>
    protected void gridElem_OnAction(string actionName, object actionArgument)
    {
        int projecttaskstatusId = ValidationHelper.GetInteger(actionArgument, 0);
        if (projecttaskstatusId > 0)
        {
            switch (actionName.ToLower())
            {
                case "edit":
                    this.SelectedItemID = projecttaskstatusId;
                    this.RaiseOnEdit();
                    break;

                case "delete":
                    if (!ProjectTaskStatusInfoProvider.CheckDependencies(projecttaskstatusId))
                    {
                        lblError.Text = GetString("pm.projecttaskstatus.removedenied");
                        return;
                    }

                    if (ProjectTaskStatusInfoProvider.GetStatusCount() <= 1)
                    {
                        ltlInfo.Text = ScriptHelper.GetScript("alert('" + GetString("pm.projectstatus.deletealert") + "');");
                        return;
                    }

                    // Delete the object
                    ProjectTaskStatusInfoProvider.DeleteProjectTaskStatusInfo(projecttaskstatusId);
                    this.RaiseOnDelete();

                    // Reload data
                    gridElem.ReloadData();
                    break;

                case "up":
                    ProjectTaskStatusInfoProvider.MoveStatusUp(projecttaskstatusId);
                    break;

                case "down":
                    ProjectTaskStatusInfoProvider.MoveStatusDown(projecttaskstatusId);
                    break;
            }
        }
    }

    #endregion
}