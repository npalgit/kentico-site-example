using System;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.Newsletter;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.WebAnalytics;
using CMS.SettingsProvider;
using CMS.PortalEngine;

public partial class CMSModules_Newsletters_CMSPages_Unsubscribe : CMSPage
{
    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        // Get data from query string
        Guid subscriberGuid = QueryHelper.GetGuid("subscriberguid", Guid.Empty);
        Guid newsletterGuid = QueryHelper.GetGuid("newsletterguid", Guid.Empty);
        string subscriptionHash = QueryHelper.GetString("subscriptionhash", string.Empty);
        Guid issueGuid = QueryHelper.GetGuid("issueGuid", Guid.Empty);
        int issueID = QueryHelper.GetInteger("issueid", 0);
        bool unsubscribed = false;

        string requestTime = QueryHelper.GetString("datetime", string.Empty) ;
        DateTime datetime = DateTimeHelper.ZERO_TIME;

        // Get date and time
        if (!string.IsNullOrEmpty(requestTime))
        {
            try
            {
                datetime = DateTime.ParseExact(requestTime, SecurityHelper.EMAIL_CONFIRMATION_DATETIME_FORMAT, null);
            }
            catch
            {
                ShowError(GetString("newsletter.unsubscribefailed"));
                return;
            }
        }

        // Get site ID
        int siteId = 0;
        if (CMSContext.CurrentSite != null)
        {
            siteId = CMSContext.CurrentSiteID;
        }

        if ((subscriberGuid != Guid.Empty) && (newsletterGuid != Guid.Empty) && (siteId != 0))
        {
            Subscriber subscriber = SubscriberProvider.GetSubscriber(subscriberGuid, siteId);
            if (subscriber == null)
            {
                ShowError(GetString("Unsubscribe.SubscriberDoesNotExist"));
                return;
            }
            if (subscriber.SubscriberType == SiteObjectType.ROLE)
            {
                ShowError(GetString("Unsubscribe.CannotUnsubscribeRole"));
                return;
            }

            Newsletter newsletter = NewsletterProvider.GetNewsletter(newsletterGuid, siteId);
            if (newsletter == null)
            {
                ShowError(GetString("Unsubscribe.NewsletterDoesNotExist"));
                return;
            }

            // Check if subscriber with given GUID is subscribed to specified newsletter
            if (SubscriberProvider.IsSubscribed(subscriber.SubscriberID, newsletter.NewsletterID))
            {
                // Unsubscribe the subscriber from newsletter
                SubscriberProvider.Unsubscribe(subscriber.SubscriberID, newsletter.NewsletterID);
                ShowInformation(GetString("Unsubscribe.Unsubscribed"));
                unsubscribed = true;
                LogActivity(subscriber, 0, newsletter.NewsletterID, issueID, issueGuid, siteId);
            }
            else
            {
                ShowError(GetString("Unsubscribe.NotSubscribed"));
            }
        }
        // Check if subscription approval hash is supplied
        else if (!string.IsNullOrEmpty(subscriptionHash))
        {
            SubscriberNewsletterInfo sni = SubscriberNewsletterInfoProvider.GetSubscriberNewsletterInfo(subscriptionHash);
            // Check if hash is valid
            if (sni != null)
            {
                SubscriberProvider.ApprovalResult result = SubscriberProvider.Unsubscribe(subscriptionHash, true, CMSContext.CurrentSiteName, datetime);

                switch (result)
                {
                    // Approving subscription was successful
                    case SubscriberProvider.ApprovalResult.Success:
                        ShowInformation(GetString("Unsubscribe.Unsubscribed"));
                        unsubscribed = true;
                        LogActivity(null, sni.SubscriberID, sni.NewsletterID, issueID, issueGuid, siteId);
                        break;

                    // Subscription was already approved
                    case SubscriberProvider.ApprovalResult.Failed:
                        ShowError(GetString("newsletter.unsubscribefailed"));
                        break;

                    case SubscriberProvider.ApprovalResult.TimeExceeded:                        
                        ShowError(GetString("newsletter.approval_timeexceeded")) ;
                        break;

                    // Subscription not found
                    default:
                    case SubscriberProvider.ApprovalResult.NotFound:
                        ShowError(GetString("Unsubscribe.NotSubscribed"));
                        break;
                }           
            }
            else
            {
                ShowError(GetString("Unsubscribe.NotSubscribed"));
            }
        }
        else
        {
            if (subscriberGuid == Guid.Empty)
            {
                ShowError(GetString("Unsubscribe.SubscriberDoesNotExist"));
            }
            if (newsletterGuid == Guid.Empty)
            {
                ShowError(GetString("Unsubscribe.NewsletterDoesNotExist"));
            }
        }

        // Increase unsubscribed count
        if (unsubscribed)
        {
            // If Issue ID was provided
            if (issueID > 0)
            {
                IssueProvider.Unsubscribe(issueID);
                return;
            }
            // Otherwise try using the Issue GUID
            if (issueGuid != Guid.Empty)
            {
                Issue issue = IssueProvider.GetIssue(issueGuid, siteId);
                if (issue == null)
                {
                    return;
                }

                IssueProvider.Unsubscribe(issue.IssueID);
            }
        }
    }


    /// <summary>
    /// Logs activity for unsubscribing.
    /// </summary>
    /// <param name="sb">Subscriber (optional - can be null if subscriber ID is used)</param>
    /// <param name="subscriberId">Subscriber ID (optional - can be zero if subscriber object is used)</param>
    /// <param name="newsletterId">Newsletter ID</param>
    /// <param name="issueGuid">Issue GUID</param>
    /// <param name="issueId">Issue ID</param>
    private void LogActivity(Subscriber sb, int subscriberId, int newsletterId, int issueId, Guid issueGuid, int siteId)
    {
        // Check if activities logging is enabled
        if ((newsletterId <= 0) || (CMSContext.ViewMode != ViewModeEnum.LiveSite) || !ActivitySettingsHelper.ActivitiesEnabledAndModuleLoaded(siteId)
            || !ActivitySettingsHelper.NewsletterSubscribeEnabled(siteId))
        {
            return;
        }

        // Load subscriber info object according to its ID if not given
        if (sb == null)
        {
            if (subscriberId <= 0)
            {
                return;
            }
            sb = SubscriberProvider.GetSubscriber(subscriberId);
        }

        if (sb == null)
        {
            return;
        }

        // Try to retrieve contact IDs for particular subscriber from membership relations
        int[] contactIds = ActivityTrackingHelper.GetContactIDs(sb);
        if ((contactIds != null) && (contactIds.Length > 0))
        {
            Newsletter news = NewsletterProvider.GetNewsletter(newsletterId);
            if ((news != null) && news.NewsletterLogActivity)
            {
                // Load additional info (issue id)
                if ((issueId <= 0) && (issueGuid != Guid.Empty))
                {
                    Issue issue = IssueProvider.GetIssue(issueGuid, siteId);
                    if (issue != null)
                    {
                        issueId = issue.IssueID;
                    }
                }

                // Loop through each contact and log activity
                foreach (int contactId in contactIds)
                {
                    var data = new ActivityData()
                    {
                        ContactID = contactId,
                        SiteID = sb.SubscriberSiteID,
                        Type = PredefinedActivityType.NEWSLETTER_UNSUBSCRIBING,
                        TitleData = news.NewsletterName,
                        ItemID = newsletterId,
                        URL = URLHelper.CurrentRelativePath,
                        ItemDetailID = issueId
                    };
                    ActivityLogProvider.LogActivity(data);
                }
            }
        }
    }

    #endregion
}