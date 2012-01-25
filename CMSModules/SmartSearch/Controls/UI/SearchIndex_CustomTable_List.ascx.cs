using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.SiteProvider;
using CMS.SettingsProvider;

public partial class CMSModules_SmartSearch_Controls_UI_SearchIndex_CustomTable_List : CMSAdminListControl, IPostBackEventHandler
{
    #region "Variables"

    private int indexId = 0;
    private SearchIndexInfo sii = null;
    private SearchIndexSettings sis = null;
    private bool smartSearchEnabled = SettingsKeyProvider.GetBoolValue("CMSSearchIndexingEnabled");

    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.StopProcessing)
        {
            return;
        }

        // Show panel with message how to enable indexing
        if (!smartSearchEnabled)
        {
            pnlDisabled.Visible = true;
        }

        indexId = QueryHelper.GetInteger("indexid", 0);
        Reload();
    }


    /// <summary>
    /// Reloads datagrid.
    /// </summary>
    private void Reload()
    {
        UniGrid.OnExternalDataBound += new OnExternalDataBoundEventHandler(UniGrid_OnExternalDataBound);
        UniGrid.OnAction += new OnActionEventHandler(UniGrid_OnAction);
        UniGrid.ZeroRowsText = GetString("general.nodatafound");

        DataSet sorted = null;

        sii = SearchIndexInfoProvider.GetSearchIndexInfo(indexId);
        if (sii != null)
        {
            DataSet result = sii.IndexSettings.GetAll();

            if (!DataHelper.DataSourceIsEmpty(result))
            {
                // Set 'id' column to first position
                if (result.Tables[0].Columns["id"] != null)
                {
                    result.Tables[0].Columns["id"].SetOrdinal(0);
                }

                // Check if 'type' column exists
                if (result.Tables[0].Columns["type"] == null)
                {
                    result.Tables[0].Columns.Add(new DataColumn("type"));
                }

                // Sort result
                sorted = new DataSet();
                sorted.Tables.Add(result.Tables[0].Clone());
                if (result.Tables[0].Columns.Contains("classNames"))
                {
                    foreach (DataRow dr in result.Tables[0].Select(null, "classNames"))
                    {
                        sorted.Tables[0].ImportRow(dr);
                    }
                }
            }

            UniGrid.DataSource = sorted;
            UniGrid.ReloadData();
        }
    }


    #region "Events"

    /// <summary>
    /// Unigrid databound handler.
    /// </summary>
    object UniGrid_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        DataRowView drv = (parameter as DataRowView);

        switch (sourceName.ToLower())
        {
            case "customtableclassname":
                string classname = HTMLHelper.HTMLEncode(TextHelper.LimitLength(drv["DisplayName"].ToString(), 200));
                if (string.IsNullOrEmpty(classname))
                {
                    return GetString("general.selectall");
                }
                else
                {
                    return classname;
                }
        }
        return null;
    }


    /// <summary>
    /// Unigrid on action handler.
    /// </summary>
    void UniGrid_OnAction(string actionName, object actionArgument)
    {
        Guid guid;
        switch (actionName)
        {
            case "edit":
                guid = ValidationHelper.GetGuid(actionArgument, Guid.Empty);
                RaiseOnAction("edit", guid);
                break;

            case "delete":
                // Delete search index info object from database with it's dependences
                guid = ValidationHelper.GetGuid(actionArgument, Guid.Empty);

                sis = sii.IndexSettings;
                sis.DeleteSearchIndexSettingsInfo(guid);
                sii.IndexSettings = sis;
                SearchIndexInfoProvider.SetSearchIndexInfo(sii);
                Reload();

                // Show message about rebuilding index
                if (smartSearchEnabled)
                {
                    lblInfo.Visible = true;
                    lblInfo.Text = String.Format(GetString("srch.indexrequiresrebuild"), "<a href=\"javascript:" + Page.ClientScript.GetPostBackEventReference(this, "saved") + "\">" + GetString("General.clickhere") + "</a>");
                }
                break;
        }
    }


    #endregion


    #region "IPostBackEventHandler Members"

    public void RaisePostBackEvent(string eventArgument)
    {
        if (eventArgument == "saved")
        {
            // Get search index info
            SearchIndexInfo sii = null;
            if (this.indexId > 0)
            {
                sii = SearchIndexInfoProvider.GetSearchIndexInfo(this.indexId);
            }

            // Create rebuild task
            if (sii != null)
            {
                SearchTaskInfoProvider.CreateTask(SearchTaskTypeEnum.Rebuild, sii.IndexType, null, sii.IndexName);
            }

            lblInfo.Text = GetString("srch.index.rebuildstarted");
            lblInfo.Visible = true;
        }
    }

    #endregion
}
