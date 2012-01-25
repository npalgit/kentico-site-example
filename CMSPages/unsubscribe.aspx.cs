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

public partial class CMSPages_unsubscribe : CMSPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Forums
        Guid subGuid = QueryHelper.GetGuid("subGuid", Guid.Empty);
        int forumId = QueryHelper.GetInteger("forumid", 0);

        if (subGuid != Guid.Empty)
        {
            Server.Transfer(ResolveUrl("~/CMSModules/Forums/CMSPages/Unsubscribe.aspx?&subGuid=") + subGuid.ToString() + "&forumid=" + forumId);
        }

        // Newsletters
        Guid subscriberGuid = QueryHelper.GetGuid("subscriberguid", Guid.Empty);
        Guid newsletterGuid = QueryHelper.GetGuid("newsletterguid", Guid.Empty);
        string subscriptionHash = QueryHelper.GetString("subscriptionhash", string.Empty);
        string datetime = QueryHelper.GetString("datetime", string.Empty);
        Guid issueGuid = QueryHelper.GetGuid("issueguid", Guid.Empty);
        int issueID = QueryHelper.GetInteger("issueid", 0);

        if ((subscriberGuid != Guid.Empty) && (newsletterGuid != Guid.Empty))
        {
            if (issueGuid != Guid.Empty)
            {
                Server.Transfer(ResolveUrl(string.Format("~/CMSModules/Newsletters/CMSPages/Unsubscribe.aspx?&subscriberguid={0}&newsletterGuid={1}&issueguid={2}", subscriberGuid, newsletterGuid, issueGuid)));
            }
            else if (issueID != 0)
            {
                Server.Transfer(ResolveUrl(string.Format("~/CMSModules/Newsletters/CMSPages/Unsubscribe.aspx?&subscriberguid={0}&newsletterGuid={1}&issueid={2}", subscriberGuid, newsletterGuid, issueID)));
            }
            else
            {
                Server.Transfer(ResolveUrl(string.Format("~/CMSModules/Newsletters/CMSPages/Unsubscribe.aspx?&subscriberguid={0}&newsletterGuid={1}", subscriberGuid, newsletterGuid)));
            }
        }
        else if (!string.IsNullOrEmpty(subscriptionHash))
        {
            Server.Transfer(ResolveUrl(string.Format("~/CMSModules/Newsletters/CMSPages/Unsubscribe.aspx?&subscriptionhash={0}&datetime={1}", subscriptionHash, datetime)));
        }
    }
}