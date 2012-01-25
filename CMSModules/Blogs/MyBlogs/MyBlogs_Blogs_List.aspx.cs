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

using CMS.GlobalHelper;
using CMS.CMSHelper;
using CMS.TreeEngine;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using CMS.Blogs;
using CMS.WorkflowEngine;
using CMS.LicenseProvider;
using CMS.UIControls;

public partial class CMSModules_Blogs_MyBlogs_MyBlogs_Blogs_List : CMSMyBlogsPage
{
    #region "Variables"

    protected CurrentUserInfo currentUser = null;
    protected bool isAuthorized = false;

    #endregion


    #region "Page events"

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.gridBlogs.ZeroRowsText = GetString("mydesk.ui.noblogs");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        currentUser = CMSContext.CurrentUser;
        if (currentUser == null)
        {
            return;
        }

        // No cms.blog doc. type
        if (DataClassInfoProvider.GetDataClass("cms.blog") == null)
        {
            RedirectToInformation(GetString("blog.noblogdoctype"));
        }

        // Check if user is authorized to manage 
        isAuthorized = currentUser.IsAuthorizedPerResource("CMS.Blog", "Manage") || (currentUser.IsAuthorizedPerClassName("cms.blog", "Manage", CMSContext.CurrentSiteName) &&
                       currentUser.IsAuthorizedPerClassName("cms.blogpost", "Manage", CMSContext.CurrentSiteName));

        // Register grid events
        this.gridBlogs.OnExternalDataBound += new OnExternalDataBoundEventHandler(gridBlogs_OnExternalDataBound);
        this.gridBlogs.OnDataReload += new OnDataReloadEventHandler(gridBlogs_OnDataReload);

        // Get ClassID of the 'cms.blogpost' class
        DataClassInfo dci = DataClassInfoProvider.GetDataClass("cms.blogpost");
        string classId = "";
        string script = "";

        if (dci != null)
        {
            classId = dci.ClassID.ToString();
        }

        // Get scritp to redirect to new blog post page        
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
        return BlogHelper.GetBlogs(CMSContext.CurrentSiteName, currentUser.UserID, null, "BlogID, ClassName, BlogName, NodeID, DocumentCulture, NodeOwner, BlogModerators", completeWhere);
    }


    protected object gridBlogs_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        //lblInfo.Visible = false;
        switch (sourceName.ToLower())
        {
            case "edit":
            case "newpost":
                GridViewRow gvr = (parameter as GridViewRow);
                if (gvr != null)
                {
                    DataRowView dr = (gvr.DataItem as DataRowView);
                    if (dr != null)
                    {
                        CMS.TreeEngine.TreeNode blogNode = CMS.TreeEngine.TreeNode.New(dr.Row, ValidationHelper.GetString(dr.Row["ClassName"], ""));
                        if (blogNode != null)
                        {
                            isAuthorized = isAuthorized || BlogHelper.IsUserBlogOwner(currentUser.UserID, blogNode);
                            if (!isAuthorized)
                            {
                                ImageButton button = ((ImageButton)sender);
                                if (sourceName.ToLower() == "edit")
                                {
                                    button.ImageUrl = GetImageUrl("Design/Controls/UniGrid/Actions/editdisabled.png");
                                }
                                else
                                {
                                    button.ImageUrl = GetImageUrl("Design/Controls/UniGrid/Actions/addpostdisabled.png");
                                }
                                button.Enabled = false;
                            }
                        }
                    }
                }
                break;
        }
        return parameter;
    }

    #endregion
}
