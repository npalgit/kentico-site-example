using System;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.Polls;
using CMS.UIControls;

public partial class CMSModules_Polls_Tools_Polls_View : CMSPollsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get PollID from querystring
        int pollId = QueryHelper.GetInteger("pollid", 0);

        // Get poll object
        PollInfo pi = PollInfoProvider.GetPollInfo(pollId);
        EditedObject = pi;

        // Check global and site read permmision
        this.CheckPollsReadPermission(pi.PollSiteID);

        if (pi != null)
        {
            // Check permissions during voting if user hasn't got 'Modify' permission
            CurrentUserInfo user = CMSContext.CurrentUser;
            bool checkPermission = 
                (pi.PollSiteID > 0) && !user.IsAuthorizedPerResource("cms.polls", CMSAdminControl.PERMISSION_MODIFY) ||
                (pi.PollSiteID <= 0) && !user.IsAuthorizedPerResource("cms.polls", CMSAdminControl.PERMISSION_GLOBALMODIFY);

            pollElem.PollCodeName = pi.PollCodeName;
            pollElem.PollSiteID = pi.PollSiteID;
            pollElem.PollGroupID = pi.PollGroupID;
            pollElem.CountType = CountTypeEnum.Percentage;
            pollElem.ShowGraph = true;
            pollElem.ShowResultsAfterVote = true;
            // Check permissions during voting if user hasn't got 'Modify' permission
            pollElem.CheckPermissions = checkPermission;
            pollElem.CheckVoted = false;
            pollElem.HideWhenNotAuthorized = false;
            pollElem.CheckOpen = false;
            pollElem.IsLiveSite = false;
        }
    }


    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        int textLength = pollElem.ButtonText.Length;
        if (textLength > 15)
        {
            pollElem.VoteButton.CssClass = "XLongSubmitButton";
        }
        else if (textLength > 8)
        {
            pollElem.VoteButton.CssClass = "LongSubmitButton";
        }
        else
        {
            pollElem.VoteButton.CssClass = "SubmitButton";
        }
    }
}
