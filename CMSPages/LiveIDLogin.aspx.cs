using System;
using System.Web.UI;
using System.Web;
using System.Web.Security;
using System.Data;

using CMS.SiteProvider;
using CMS.SettingsProvider;
using CMS.MembershipProvider;
using CMS.GlobalHelper;
using CMS.CMSHelper;
using CMS.LicenseProvider;
using CMS.UIControls;
using CMS.WebAnalytics;
using CMS.TreeEngine;
using CMS.IO;
using CMS.PortalEngine;


/// <summary>
/// This page handles the login, logout and clearcookie Web Auth
/// actions.  When you create a Windows Live application, you must
/// specify the URL of this handler page.
/// </summary>
public partial class CMSPages_LiveIDLogin : CMSPage
{
    #region "Private fields"

    private static string defaultPage = URLHelper.ResolveUrl("~/Default.aspx");
    private static string loginPage = SettingsKeyProvider.GetStringValue(CMSContext.CurrentSiteName + ".CMSSecuredAreasLogonPage");
    private static string logoutPage = defaultPage;
    private const string liveCookieName = "webauthtoken";

    private String siteName = String.Empty;
    private String relativeURL = String.Empty;
    private String conversionName = String.Empty;
    private String conversionValue = String.Empty;

    #endregion


    #region "Methods"

    /// <summary>
    /// Parse parameters from session
    /// </summary>
    /// <param name="parameters">LiveID login parameters</param>
    private void ParseParameters(String[] parameters)
    {
        if ((parameters != null) && (parameters.Length == 3))
        {
            relativeURL = HttpUtility.UrlDecode(parameters[0]);
            conversionName = HttpUtility.UrlDecode(parameters[1]);
            conversionValue = HttpUtility.UrlDecode(parameters[2]);
        }
    }


    /// <summary>
    /// Get user information and logs user (register if no user found)
    /// </summary>
    private void ProcessLiveIDLogin()
    {
        // Get authorization code from URL        
        String code = QueryHelper.GetString("code", String.Empty);

        // Create windows login object        
        WindowsLiveLogin wwl = new WindowsLiveLogin(siteName);

        // Get login parameters 
        String[] parameters = SessionHelper.GetValue("LiveIDInformtion") as String[];
        ParseParameters(parameters);
        Session.Remove("LiveIDInformtion");

        // Process login via Live ID
        WindowsLiveLogin.User liveUser = wwl.ProcessLogin(code, relativeURL);

        // Authorization sucesfull
        if (liveUser != null)
        {
            // Find user by ID
            UserInfo winUser = UserInfoProvider.GetUserInfoByWindowsLiveID(liveUser.Id);

            string error = String.Empty;

            // Register new user
            if (winUser == null)
            {
                // Check whether additional user info page is set
                string additionalInfoPage = SettingsKeyProvider.GetStringValue(siteName + ".CMSLiveIDRequiredUserDataPage");

                // No page set, user can be created/sign
                if (additionalInfoPage == String.Empty)
                {
                    // Create new user user
                    UserInfo ui = UserInfoProvider.AuthenticateWindowsLiveUser(liveUser.Id, siteName, true, ref error);

                    // Remove live user object from session, won't be needed
                    Session.Remove("windowsliveloginuser");

                    // If user was found or successfuly created
                    if ((ui != null) && (ui.Enabled))
                    {
                        // Send registration e-mails
                        // E-mail confirmation is not required as user already provided confirmation by successful login using LiveID
                        UserInfoProvider.SendRegistrationEmails(ui, null, null, false, false);

                        // Track registration into analytics
                        double val = ValidationHelper.GetDouble(CMSContext.CurrentResolver.ResolveMacros(conversionValue), 0);
                        UserInfoProvider.TrackUserRegistration(conversionName, val, siteName, ui);

                        // Log registration activity
                        if ((CMSContext.ViewMode == ViewModeEnum.LiveSite) && ActivitySettingsHelper.ActivitiesEnabledAndModuleLoaded(siteName) && ActivitySettingsHelper.ActivitiesEnabledForThisUser(CMSContext.CurrentUser)
                            && ActivitySettingsHelper.UserRegistrationEnabled(siteName))
                        {
                            int contactId = ModuleCommands.OnlineMarketingGetUserLoginContactID(ui);
                            TreeNode currentDoc = CMSContext.CurrentDocument;
                            ActivityLogProvider.LogRegistrationActivity(contactId,
                                ui, URLHelper.CurrentRelativePath, (currentDoc != null ? currentDoc.NodeID : 0), siteName, CMSContext.Campaign, (currentDoc != null ? currentDoc.DocumentCulture : null));
                        }

                        SetAuthCookieAndRedirect(ui);
                    }
                    // User not created
                    else
                    {
                        ClearCookieAndRedirect();
                    }
                }
                // Required data page exists
                else
                {
                    // Store user object in session for additional info page
                    SessionHelper.SetValue("windowsliveloginuser", liveUser);

                    // Redirect to additional info page
                    URLHelper.Redirect(URLHelper.ResolveUrl(additionalInfoPage));
                }
            }
            else
            {
                UserInfo ui = UserInfoProvider.AuthenticateWindowsLiveUser(liveUser.Id, siteName, true, ref error);

                // If user was found 
                if ((ui != null) && (ui.Enabled))
                {
                    SetAuthCookieAndRedirect(ui);
                }
            }
        }
    }


    /// <summary>
    /// Page load.
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        LicenseHelper.CheckFeatureAndRedirect(URLHelper.GetCurrentDomain(), FeatureEnum.WindowsLiveID);

        siteName = CMSContext.CurrentSiteName;
        // Sitename must be set
        if (string.IsNullOrEmpty(siteName))
        {
            return;
        }

        ProcessLiveIDLogin();
    }


    /// <summary>
    /// Clear live id cookies and redirect to the logon page.
    /// </summary>
    private void ClearCookieAndRedirect()
    {
        ClearLiveCookie();

        // Redirect to login page
        URLHelper.Redirect(loginPage);
    }


    /// <summary>
    /// Clears Live authentication cookie.
    /// </summary>
    private void ClearLiveCookie()
    {
        HttpCookie loginCookie = new HttpCookie(liveCookieName);
        loginCookie.Expires = DateTime.Now.AddYears(-10);

        CookieHelper.SetValue(loginCookie.Name, loginCookie.Value, loginCookie.Expires);
    }


    /// <summary>
    /// Helper method, set authentication cookie and redirect to return URL or default page.
    /// </summary>
    /// <param name="ui">User info</param>
    /// <param name="user">Windows live user</param>
    private void SetAuthCookieAndRedirect(UserInfo ui)
    {
        // Create autentification cookie
        UserInfoProvider.SetAuthCookieWithUserData(ui.UserName, false, Session.Timeout, new string[] { "liveidlogin" });

        // Log activity
        if ((CMSContext.ViewMode == ViewModeEnum.LiveSite) && ActivitySettingsHelper.ActivitiesEnabledAndModuleLoaded(siteName))
        {
            int contactId = ModuleCommands.OnlineMarketingGetUserLoginContactID(ui);
            ActivityLogHelper.UpdateContactLastLogon(contactId);
            if (ActivitySettingsHelper.ActivitiesEnabledForThisUser(ui))
            {
                TreeNode currentDoc = CMSContext.CurrentDocument;
                ActivityLogProvider.LogLoginActivity(contactId, ui, URLHelper.CurrentRelativePath,
                    (currentDoc != null ? currentDoc.NodeID : 0), siteName, CMSContext.Campaign, (currentDoc != null ? currentDoc.DocumentCulture : null));
            }
        }

        // If there is some return url redirect there        
        if (!String.IsNullOrEmpty(relativeURL))
        {
            URLHelper.Redirect(ResolveUrl(relativeURL));
        }
        else // Redirect to default page
        {
            URLHelper.Redirect(defaultPage);
        }
    }

    #endregion
}
