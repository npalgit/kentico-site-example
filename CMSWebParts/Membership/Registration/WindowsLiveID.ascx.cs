using System;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web;

using CMS.PortalControls;
using CMS.SettingsProvider;
using CMS.MembershipProvider;
using CMS.GlobalHelper;
using CMS.CMSHelper;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.PortalEngine;
using CMS.IO;

public partial class CMSWebParts_Membership_Registration_WindowsLiveID : CMSAbstractWebPart
{
    #region "Public properties"

    /// <summary>
    /// Gets or sets the value that indicates whether to show sign out link.
    /// </summary>
    public bool ShowSignOut
    {
        get
        {
            return ValidationHelper.GetBoolean(GetValue("ShowSignOut"), false);
        }
        set
        {
            SetValue("ShowSignOut", value);
        }
    }


    /// <summary>
    /// Gets or sets the value that buttons will be used instead of links.
    /// </summary>
    public bool ShowAsButton
    {
        get
        {
            return ValidationHelper.GetBoolean(GetValue("ShowAsButton"), false);
        }
        set
        {
            SetValue("ShowAsButton", value);
        }
    }


    /// <summary>
    /// Gets or sets sign in button image URL.
    /// </summary>
    public string SignInImageURL
    {
        get
        {
            return DataHelper.GetNotEmpty(GetValue("SignInImageURL"), GetImageUrl("Others/LiveID/signin.gif"));
        }
        set
        {
            SetValue("SignInImageURL", value);
        }
    }


    /// <summary>
    /// Gets or sets sign out button image URL.
    /// </summary>
    public string SignOutImageURL
    {
        get
        {
            return DataHelper.GetNotEmpty(GetValue("SignOutImageURL"), GetImageUrl("Others/LiveID/signout.gif"));
        }
        set
        {
            SetValue("SignOutImageURL", value);
        }
    }


    /// <summary>
    /// Gets or sets the conversion track name used after successful registration.
    /// </summary>
    public string TrackConversionName
    {
        get
        {
            return ValidationHelper.GetString(this.GetValue("TrackConversionName"), SettingsKeyProvider.GetStringValue(CMSContext.CurrentSiteName + ".CMSLiveIDConversionName"));
        }
        set
        {
            if ((value != null) && (value.Length > 400))
            {
                value = value.Substring(0, 400);
            }
            this.SetValue("TrackConversionName", value);
        }
    }


    /// <summary>
    /// Gets or sets the conversion value used after successful registration.
    /// </summary>
    public double ConversionValue
    {
        get
        {
            return ValidationHelper.GetDouble(this.GetValue("ConversionValue"), 0);
        }
        set
        {
            this.SetValue("ConversionValue", value);
        }
    }



    /// <summary>
    /// Gets or sets sign in text.
    /// </summary>
    public string SignInText
    {
        get
        {
            return ValidationHelper.GetString(GetValue("SignInText"), "");
        }
        set
        {
            SetValue("SignInText", value);
        }
    }


    /// <summary>
    /// Gets or sets sign out text.
    /// </summary>
    public string SignOutText
    {
        get
        {
            return ValidationHelper.GetString(GetValue("SignOutText"), "");
        }
        set
        {
            SetValue("SignOutText", value);
        }
    }

    #endregion


    #region "Methods"

    /// <summary>
    /// Content loaded event handler.
    /// </summary>
    public override void OnContentLoaded()
    {
        base.OnContentLoaded();
        SetupControl();
    }


    /// <summary>
    /// Initializes the control properties.
    /// </summary>
    protected void SetupControl()
    {
        if (StopProcessing)
        {
            // Do nothing
        }
        else
        {
            if (SettingsKeyProvider.GetBoolValue(CMSContext.CurrentSiteName + ".CMSEnableWindowsLiveID"))
            {
                string siteName = CMSContext.CurrentSiteName;
                if (!string.IsNullOrEmpty(siteName))
                {
                    // Get LiveID settings
                    string appId = SettingsKeyProvider.GetStringValue(siteName + ".CMSApplicationID");
                    string secret = SettingsKeyProvider.GetStringValue(siteName + ".CMSApplicationSecret");

                    // Check valid Windows LiveID parameters
                    if ((appId == string.Empty) || (secret == string.Empty))
                    {
                        lblError.Visible = true;
                        lblError.Text = GetString("liveid.incorrectsettings");
                        return;
                    }

                    WindowsLiveLogin wll = new WindowsLiveLogin(appId, secret);

                    // If user is already authenticated 
                    if (CMSContext.CurrentUser.IsAuthenticated())
                    {
                        // If signout should be visible and user has LiveID registered
                        if ((ShowSignOut) && (!String.IsNullOrEmpty(CMSContext.CurrentUser.UserSettings.WindowsLiveID)))
                        {
                            // Get data from auth cookie 
                            string[] userData = UserInfoProvider.GetUserDataFromAuthCookie();

                            // Check if user has truly logged in by LiveID
                            if ((userData != null) && (Array.IndexOf(userData, "liveidlogin") >= 0))
                            {
                                string navUrl = wll.GetLogoutUrl();

                                // If text is set use text/button link
                                if (!string.IsNullOrEmpty(SignOutText))
                                {
                                    // Button link
                                    if (ShowAsButton)
                                    {
                                        btnSignOut.CommandArgument = navUrl;
                                        btnSignOut.Text = SignOutText;
                                        btnSignOut.Visible = true;
                                    }
                                    // Text link
                                    else
                                    {
                                        btnSignOutLink.CommandArgument = navUrl;
                                        btnSignOutLink.Text = SignOutText;
                                        btnSignOutLink.Visible = true;
                                    }
                                }
                                // Image link
                                else
                                {
                                    btnSignOutImage.CommandArgument = navUrl;
                                    btnSignOutImage.ImageUrl = ResolveUrl(SignOutImageURL);
                                    btnSignOutImage.Visible = true;
                                    btnSignOut.Text = GetString("webparts_membership_signoutbutton.signout");
                                }
                            }
                        }
                        else
                        {
                            Visible = false;
                        }
                    }
                    // Sign In
                    else
                    {
                        // Create return URL
                        string returnUrl = QueryHelper.GetText("returnurl", "");
                        returnUrl = (returnUrl == String.Empty) ? URLHelper.CurrentURL : returnUrl;

                        // Create parameters for LiveID request URL
                        String[] parameters = new String[3];
                        parameters[0] = URLHelper.CurrentURL;
                        parameters[1] = TrackConversionName;
                        parameters[2] = ConversionValue.ToString();
                        SessionHelper.SetValue("LiveIDInformtion", parameters);

                        returnUrl = HttpUtility.UrlEncode(wll.GetLoginUrl());

                        // Get App ID
                        appId = SettingsKeyProvider.GetStringValue(siteName + ".CMSApplicationID");

                        // Create full LiveID request URL                        
                        string navUrl = "https://oauth.live.com/authorize?&client_id=" + appId + "&redirect=true&scope=wl.signin&response_type=code&redirect_uri=" + returnUrl;

                        // If text is set use text/button link
                        if (!string.IsNullOrEmpty(SignInText))
                        {
                            // Button link
                            if (ShowAsButton)
                            {
                                btnSignIn.CommandArgument = navUrl;
                                btnSignIn.Text = SignInText;
                                btnSignIn.Visible = true;
                            }
                            // Text link
                            else
                            {
                                lnkSignIn.NavigateUrl = navUrl;
                                lnkSignIn.Text = SignInText;
                                lnkSignIn.Visible = true;
                            }
                        }
                        // Image link
                        else
                        {
                            lnkSignIn.NavigateUrl = navUrl;
                            lnkSignIn.ImageUrl = ResolveUrl(SignInImageURL);
                            lnkSignIn.Visible = true;
                            lnkSignIn.Text = GetString("webparts_membership_signoutbutton.signin");
                        }
                    }
                }
            }
            else
            {
                // Error label is displayed in Design mode when Windows Live ID is disabled
                if (CMSContext.ViewMode == ViewModeEnum.Design)
                {
                    StringBuilder parameter = new StringBuilder();
                    parameter.Append(GetString("header.sitemanager") + " -> ");
                    parameter.Append(GetString("settingscategory.cmssettings") + " -> ");
                    parameter.Append(GetString("settingscategory.cmsmembership") + " -> ");
                    parameter.Append(GetString("settingscategory.cmsmembershipauthentication") + " -> ");
                    parameter.Append(GetString("settingscategory.cmswindowsliveid"));
                    if (CMSContext.CurrentUser.UserSiteManagerAdmin)
                    {
                        // Make it link for SiteManager Admin
                        parameter.Insert(0, "<a href=\"" + URLHelper.GetAbsoluteUrl("~/CMSSiteManager/default.aspx?section=settings") + "\" target=\"_top\">");
                        parameter.Append("</a>");
                    }

                    lblError.Text = String.Format(GetString("mem.liveid.disabled"), parameter.ToString());
                    lblError.Visible = true;
                }
                else
                {
                    this.Visible = false;
                }
            }
        }
    }


    /// <summary>
    /// SignOut handler.
    /// </summary>
    protected void btnSignOut_Click(object sender, CommandEventArgs e)
    {
        if (StopProcessing)
        {
            // Do not process
        }
        else
        {
            if (CMSContext.CurrentUser.IsAuthenticated())
            {
                // Sign out from CMS
                FormsAuthentication.SignOut();
                CMSContext.CurrentUser = null;
                CMSContext.ClearShoppingCart();

                Response.Cache.SetNoStore();

                if (Session != null)
                {
                    // Store info about logout request, for validation logout request
                    SessionHelper.SetValue("liveidlogout", DateTime.Now);
                }
            }

            // Clear session parameter
            Session.Remove("liveidlogout");

            // Redirect to LiveID logout
            URLHelper.Redirect(e.CommandArgument.ToString());
        }
    }


    /// <summary>
    /// SignIn handler.
    /// </summary>
    protected void btnSignIn_Click(object sender, CommandEventArgs e)
    {
        if (StopProcessing)
        {
            // Do not process
        }
        else
        {
            // Redirect to sign in to Windows Live
            URLHelper.Redirect(e.CommandArgument.ToString());
        }
    }


    /// <summary>
    /// Reloads the control data.
    /// </summary>
    public override void ReloadData()
    {
        base.ReloadData();
        SetupControl();
    }

    #endregion
}
