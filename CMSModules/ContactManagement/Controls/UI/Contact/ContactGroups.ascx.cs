using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

using CMS.UIControls;
using CMS.GlobalHelper;
using CMS.SettingsProvider;
using CMS.CMSHelper;

public partial class CMSModules_ContactManagement_Controls_UI_Contact_ContactGroups : CMSAdminListControl
{

    #region "Variables"

    List<int> mFilterByContacts = new List<int>();
    List<int?> mFilterBySites = new List<int?>();

    #endregion


    #region "Events"

    /// <summary>
    /// Remove button on group is clicked.
    /// </summary>
    public event EventHandler OnRemoveGroup;


    /// <summary>
    /// Remove button on group is clicked.
    /// </summary>
    public event EventHandler OnDrawRemoveButton;

    #endregion


    #region "Properties"

    /// <summary>
    /// Sets or gets contact ID to filter unigrid. 
    /// Leave empty for displaying groups from all contacts.
    /// </summary>
    public List<int> FilterByContacts
    {
        get
        {
            return mFilterByContacts;
        }
        set
        {
            mFilterByContacts = value;
        }
    }


    /// <summary>
    /// Gets or Sets site list to display contact group from. 
    /// Leave empty for displaying groups from all sites. 
    /// Add null for 'global' items.
    /// </summary>
    public List<int?> FilterBySites
    {
        get
        {
            return mFilterBySites;
        }
        set
        {
            mFilterBySites = value;
        }
    }


    /// <summary>
    /// Returns inner unigrid.
    /// </summary>
    public UniGrid UniGrid
    {
        get
        {
            return gridElem;
        }
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        SetUniGridQuery();
        gridElem.OnAction += new OnActionEventHandler(gridElem_OnAction);
        gridElem.OnExternalDataBound += new OnExternalDataBoundEventHandler(gridElem_OnExternalDataBound);
    }


    /// <summary>
    /// Sets unigrid query.
    /// </summary>
    void SetUniGridQuery()
    {
        // Filter by contacts
        if (mFilterByContacts != null && mFilterByContacts.Count > 0)
        {
            String contactFilterCondition = "ContactID IN (" + string.Join(",", mFilterByContacts.ToArray().Select(x => x.ToString()).ToArray()) + ")";
            gridElem.WhereCondition = SqlHelperClass.AddWhereCondition(gridElem.WhereCondition, contactFilterCondition);
        }
        // And sites
        if (mFilterByContacts != null && mFilterByContacts.Count > 0)
        {
            String siteFilterCondition = "ContactGroupSiteID IN ('" + string.Join("','", mFilterBySites.ToArray().Select(x => x.ToString()).ToArray()) + "')";
            if (mFilterBySites.Contains(null))
            {
                siteFilterCondition += " OR ContactGroupSiteID IS NULL";
            }
            gridElem.WhereCondition = SqlHelperClass.AddWhereCondition(gridElem.WhereCondition, siteFilterCondition);
        }
    }


    object gridElem_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        switch (sourceName)
        {
            case "remove":
                OnDrawRemoveButton(sender, EventArgs.Empty);
                break;
        }
        return null;
    }


    void gridElem_OnAction(string actionName, object actionArgument)
    {
        switch (actionName)
        {
            case "remove":
                OnRemoveGroup(actionArgument, EventArgs.Empty);
                break;
        }
    }


    /// <summary>
    /// Reloads unigrid.
    /// </summary>
    public override void ReloadData()
    {
        SetUniGridQuery();
        gridElem.ReloadData();
    }

    #endregion
}