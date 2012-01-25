using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.UIControls;

public partial class CMSTemplates_sef_TrustMember : TemplatePage
{

    public bool BotLoggedIn
    {
        get
        {
            if (Session["botLogged"] != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}