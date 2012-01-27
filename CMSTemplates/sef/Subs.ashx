<%@ WebHandler Language="C#" Class="Subs" %>

using System;
using System.Web;

public class Subs : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Response.Clear();
        if (!String.IsNullOrEmpty(context.Request.Form["subsEmail"]))
        {
            //get newsletter in according to its name for current site
            CMS.Newsletter.Newsletter myNewsletter = CMS.Newsletter.NewsletterProvider.GetNewsletter(
                "general", 
                CMS.CMSHelper.CMSContext.CurrentSite.SiteID);

            //get subscriber in according to e-mail of current user for current site
            CMS.Newsletter.Subscriber mySubscriber =
                CMS.Newsletter.SubscriberProvider.GetSubscriberByEmail(context.Request.Form["subsEmail"], CMS.CMSHelper.CMSContext.CurrentSite.SiteID);

            if (mySubscriber == null) //if subscriber with given e-mail doesn't exist create the new one
            {
                mySubscriber = new CMS.Newsletter.Subscriber();
                mySubscriber.SubscriberID = 0;
                mySubscriber.SubscriberSiteID = CMS.CMSHelper.CMSContext.CurrentSite.SiteID;
                mySubscriber.SubscriberGUID = new Guid();
                mySubscriber.SubscriberEmail = context.Request.Form["subsEmail"];
                mySubscriber.SubscriberFirstName = context.Request.Form["subsEmail"];
                mySubscriber.SubscriberLastName = context.Request.Form["subsEmail"];
                //.. you can fill other properties for subscriber from ui (UserInfo) object

                CMS.Newsletter.SubscriberProvider.SetSubscriber(mySubscriber);
            }

            //subscribe subscriber to newsletter. Last parameter says if you want to send subscription confirmation to user.
            CMS.Newsletter.SubscriberProvider.Subscribe(mySubscriber.SubscriberGUID, myNewsletter.NewsletterID, CMS.CMSHelper.CMSContext.CurrentSite.SiteID);
            
        }        
        HttpContext.Current.Response.End();
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}