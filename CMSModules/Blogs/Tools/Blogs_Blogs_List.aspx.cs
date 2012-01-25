using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using CMS.UIControls;
using CMS.SiteProvider;
using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.LicenseProvider;
using CMS.SettingsProvider;
using CMS.TreeEngine;
using CMS.WorkflowEngine;
using CMS.Blogs;

[Security(Resource = "CMS.Blog", UIElements = "Blogs")]
public partial class CMSModules_Blogs_Tools_Blogs_Blogs_List : CMSBlogsPage
{
    #region "Variables"

    private CurrentUserInfo currentUser = null;
    private bool readBlogs = false;

    #endregion


    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check the current user
        currentUser = CMSContext.CurrentUser;
        if (currentUser == null)
        {
            return;
        }

        // Check 'Read' permission
        if (currentUser.IsAuthorizedPerResource("cms.blog", "Read"))
        {
            readBlogs = true;
        }

        if (!RequestHelper.IsPostBack())
        {
            this.drpBlogs.Items.Add(new ListItem(GetString("general.selectall"), "##ALL##"));
            this.drpBlogs.Items.Add(new ListItem(GetString("blog.selectmyblogs"), "##MYBLOGS##"));
        }

        // No cms.blog doc. type
        if (DataClassInfoProvider.GetDataClass("cms.blog") == null)
        {
            RedirectToInformation(GetString("blog.noblogdoctype"));
        }

        this.CurrentMaster.DisplaySiteSelectorPanel = true;

        this.gridBlogs.OnDataReload += new OnDataReloadEventHandler(gridBlogs_OnDataReload);
        this.gridBlogs.ZeroRowsText = GetString("general.nodatafound");

        DataClassInfo dci = DataClassInfoProvider.GetDataClass("cms.blogpost");
        string classId = "";
        string script = "";

        if (dci != null)
        {
            classId = dci.ClassID.ToString();
        }

        // Get script to redirect to new blog post page        
        script += "function NewPost(parentId, culture) { \n";
        script += "     if (parentId != 0) { \n";
        script += "         parent.parent.parent.location.href = \"" + ResolveUrl("~/CMSDesk/default.aspx") + "?section=content&action=new&nodeid=\" + parentId + \"&classid=" + classId + "&culture=\" + culture;";
        script += "}} \n";

        // Generate javascript code
        ltlScript.Text = ScriptHelper.GetScript(script);
    }

    #endregion


    #region "UniGrid Events"


    protected DataSet gridBlogs_OnDataReload(string completeWhere, string currentOrder, int currentTopN, int currentOffset, int currentPageSize, ref int totalRecords)
    {
        totalRecords = -1;
        if (drpBlogs.SelectedValue == "##MYBLOGS##")
        {
            // Get owned blogs
            return BlogHelper.GetBlogs(CMSContext.CurrentSiteName, currentUser.UserID, null, "BlogID, BlogName, NodeID, DocumentCulture", completeWhere);
        }
        else
        {
            if ((currentUser.IsGlobalAdministrator) || (readBlogs))
            {
                // Get all blogs
                return BlogHelper.GetBlogs(CMSContext.CurrentSiteName, 0, null, "BlogID, BlogName, NodeID, DocumentCulture", completeWhere);
            }
            else
            {
                // Get owned or managed blogs
                return BlogHelper.GetBlogs(CMSContext.CurrentSiteName, currentUser.UserID, currentUser.UserName, "BlogID, BlogName, NodeID, DocumentCulture", completeWhere);
            }
        }
    }

    #endregion
}
