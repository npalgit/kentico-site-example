using System;

using CMS.GlobalHelper;
using CMS.OnlineMarketing;
using CMS.WebAnalytics;
using CMS.SettingsProvider;

public partial class CMSModules_ContactManagement_Controls_UI_ActivityDetails_ForumPost : ActivityDetail
{
    #region "Methods"

    public override bool LoadData(ActivityInfo ai)
    {
        if ((ai == null) || !ModuleEntry.IsModuleLoaded(ModuleEntry.FORUMS))
        {
            return false;
        }

        switch (ai.ActivityType)
        {
            case PredefinedActivityType.FORUM_POST:
            case PredefinedActivityType.SUBSCRIPTION_FORUM_POST:
                break;
            default:
                return false;

        }

        int nodeId = ai.ActivityNodeID;
        lblDocIDVal.Text = GetLinkForDocument(nodeId, ai.ActivityCulture);

        if (ai.ActivityType == PredefinedActivityType.FORUM_POST)
        {
            GeneralizedInfo iinfo = ModuleCommands.ForumsGetForumPostInfo(ai.ActivityItemID);
            if (iinfo != null)
            {
                plcComment.Visible = true;
                string text = ValidationHelper.GetString(iinfo.GetValue("PostText"), null);
                txtPost.Text = text;
            }
        }

        return true;
    }


    #endregion
}

