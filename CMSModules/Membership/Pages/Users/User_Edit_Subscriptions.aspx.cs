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
using CMS.UIControls;
using CMS.SiteProvider;

public partial class CMSModules_Membership_Pages_Users_User_Edit_Subscriptions : CMSUsersPage
{
    int userId = 0;

    protected override void OnInit(EventArgs e)
    {
        userId = QueryHelper.GetInteger("userid", 0);
        elemSubscriptions.UserID = userId;

        if (userId > 0)
        {
            // Check that only global administrator can edit global administrator's accouns
            UserInfo ui = UserInfoProvider.GetUserInfo(userId);
            EditedObject = ui;
            CheckUserAvaibleOnSite(ui); 

            if (!CheckGlobalAdminEdit(ui))
            {
                elemSubscriptions.Visible = false;
                lblError.Visible = true;
                return;
            }
        }

        elemSubscriptions.ReloadData();
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        elemSubscriptions.OnCheckPermissions += new CMSAdminControl.CheckPermissionsEventHandler(elemSubscriptions_OnCheckPermissions);
    }


    void elemSubscriptions_OnCheckPermissions(string permissionType, CMSAdminControl sender)
    {
        if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CMS.Users", CMSAdminControl.PERMISSION_MODIFY))
        {
            RedirectToAccessDenied("CMS.Users", CMSAdminControl.PERMISSION_MODIFY);
        }
    }
}
