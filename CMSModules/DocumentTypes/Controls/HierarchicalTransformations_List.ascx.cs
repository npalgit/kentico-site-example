using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

using CMS.UIControls;
using CMS.SettingsProvider;
using CMS.GlobalHelper;
using CMS.Controls;
using CMS.TreeEngine;
using CMS.CMSHelper;

public partial class CMSModules_DocumentTypes_Controls_HierarchicalTransformations_List : CMSAdminEditControl
{
    #region "Variables"

    TransformationInfo mTransInfo;
    bool mDialogMode;
    private string mTemplateType;
    private bool mIsSiteManager = false;

    #endregion


    #region "Properties"

    /// <summary>
    /// Selected template type.
    /// </summary>
    public string TemplateType
    {
        get
        {
            return mTemplateType;
        }
        set
        {
            mTemplateType = value;
        }
    }


    /// <summary>
    /// Transformation info.
    /// </summary>
    public TransformationInfo TransInfo
    {
        get
        {
            return mTransInfo;
        }
        set
        {
            mTransInfo = value;
        }
    }


    /// <summary>
    /// Indicates whether control is shown in modal dialog window (different master page).
    /// </summary>
    public bool DialogMode
    {
        get
        {
            return mDialogMode;
        }
        set
        {
            mDialogMode = value;
        }
    }


    /// <summary>
    /// Indicate whether is site manager
    /// </summary>
    public bool IsSiteManager
    {
        get
        {
            return mIsSiteManager;
        }
        set
        {
            mIsSiteManager = value;
        }
    }


    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        ugTransformations.GridName = "~/CMSModules/DocumentTypes/Controls/HierarchicalTransformations_List.xml";
        ugTransformations.OnLoadColumns += new OnLoadColumns(ugTransformations_OnLoadColumns);
        ugTransformations.OnExternalDataBound += new OnExternalDataBoundEventHandler(ugTransformations_OnExternalDataBound);
        ugTransformations.OnAction += new OnActionEventHandler(ugTransformations_OnAction);
        ugTransformations.OrderBy = "ClassName";
        ugTransformations.OnBeforeDataReload += new OnBeforeDataReload(ugTransformations_OnBeforeDataReload);


        ugTransformations.ReloadData();
    }

    void ugTransformations_OnBeforeDataReload()
    {
        //Set filters
        int level = ValidationHelper.GetInteger(txtLevel.Text, -1);
        string docType = txtDocTypes.Text;

        //Set new info to XML collection
        HierarchicalTransformations transf = LoadTransformation();

        int pageSize = ValidationHelper.GetInteger(ugTransformations.PageSizeDropdown.SelectedValue, 0);
        int count = transf.ItemsCount;

        // Hide filter when no pager used for grid or if all items count is larger then page size
        if ((pageSize == TreeProvider.ALL_LEVELS) || (count < pageSize))
        {
            pnlFilter.Visible = false;
        }
        else
        {
            pnlFilter.Visible = true;
        }

        DataSet ds = transf.GetDataSet(level, HierarchicalTransformations.StringToUniViewItemType(TemplateType), docType);

        ugTransformations.DataSource = ds;
    }


    void ugTransformations_OnLoadColumns()
    {
        if (TemplateType == "all")
        {
            ugTransformations.AddColumn("Type", GetString("general.type"), 10, true);
        }
        ugTransformations.AddColumn(String.Empty, String.Empty, 1000, false);
    }


    protected object ugTransformations_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        switch (sourceName)
        {
            case "level":
                int level = (int)parameter;
                if (level == -1)
                {
                    return "All";
                }
                break;

            case "doctype":
                string docType = (string)parameter;
                if (docType == String.Empty)
                {
                    return "All";
                }
                break;
        }
        return parameter;
    }


    /// <summary>
    /// Load transformation for xml usage.
    /// </summary>
    /// <returns></returns>
    private HierarchicalTransformations LoadTransformation()
    {
        HierarchicalTransformations transformations = new HierarchicalTransformations("ClassName");
        if (TransInfo != null)
        {
            if (!String.IsNullOrEmpty(TransInfo.TransformationHierarchicalXML))
            {
                transformations.LoadFromXML(TransInfo.TransformationHierarchicalXML);
            }
        }
        return transformations;
    }


    protected void ugTransformations_OnAction(string actionName, object actionArgument)
    {
        if (actionName == "edit")
        {
            string isManager = IsSiteManager ? "&sitemanager=true" : String.Empty;
            URLHelper.Redirect("HierarchicalTransformations_Transformations_Edit.aspx?guid=" + actionArgument + "&transid=" + TransInfo.TransformationID + "&templatetype=" + TemplateType + "&editonlycode=" + mDialogMode + "&tabmode=" + QueryHelper.GetInteger("tabmode", 0) + isManager);
        }
        if (actionName == "delete")
        {
            HierarchicalTransformations transf = LoadTransformation();
            transf.DeleteTransformation(new Guid(Convert.ToString(actionArgument)));
            TransInfo.TransformationHierarchicalXML = transf.GetXML();
            TransformationInfoProvider.SetTransformation(TransInfo);

            //Reloads data
            ugTransformations.ReloadData();
        }
    }

    #endregion
}
