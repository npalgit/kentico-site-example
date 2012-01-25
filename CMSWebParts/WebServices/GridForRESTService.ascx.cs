using System;
using System.Data;
using System.Net;
using System.Text;

using CMS.GlobalHelper;
using CMS.PortalControls;
using CMS.IO;
using CMS.EventLog;

public partial class CMSWebParts_WebServices_GridForRESTService : CMSAbstractWebPart
{
    #region "Properties"

    /// <summary>
    /// Gets or sets the URL for querying REST Service.
    /// </summary>
    public string RESTServiceQueryURL
    {
        get
        {
            return URLHelper.ResolveUrl(ValidationHelper.GetString(GetValue("RESTServiceQueryURL"), ""));
        }
        set
        {
            SetValue("RESTServiceQueryURL", value);
        }
    }


    /// <summary>
    /// Gets or sets the user name.
    /// </summary>
    public string UserName
    {
        get
        {
            return ValidationHelper.GetString(GetValue("UserName"), "");
        }
        set
        {
            SetValue("UserName", value);
        }
    }


    /// <summary>
    /// Gets or sets the user password.
    /// </summary>
    public string Password
    {
        get
        {
            return ValidationHelper.GetString(GetValue("Password"), "");
        }
        set
        {
            SetValue("Password", value);
        }
    }

    #endregion


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
            basicDataGrid.Visible = false;
        }
        else
        {
            ReloadData();
        }
    }


    /// <summary>
    /// Reload control's data.
    /// </summary>
    public override void ReloadData()
    {
        base.ReloadData();
        if (!string.IsNullOrEmpty(this.RESTServiceQueryURL))
        {
            try
            {
                HttpWebRequest request = this.CreateWebRequest();
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();

                // If everything went ok, parse the xml recieved to dataset and bind it to the grid
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    DataSet ds = new DataSet();
                    ds.ReadXml(response.GetResponseStream());

                    this.basicDataGrid.DataSource = ds;
                    this.basicDataGrid.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle the error
                EventLogProvider.LogException("GridForRESTService", "GETDATA", ex);

                this.lblError.Text = ResHelper.GetStringFormat("RESTService.RequestFailed", ex.Message);
                this.lblError.Visible = true;
            }
        }
    }


    /// <summary>
    /// Creates the WebRequest for querying the REST service.
    /// </summary>
    /// <returns></returns>
    private HttpWebRequest CreateWebRequest()
    {
        string url = this.RESTServiceQueryURL;
        if (url.StartsWith("/"))
        {
            url = URLHelper.GetAbsoluteUrl(url);
        }
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

        request.Method = "GET";
        request.ContentLength = 0;
        request.ContentType = "text/xml";

        // Set credentials for basic authentication
        if (!string.IsNullOrEmpty(this.UserName))
        {
            // Set the authorization header for basic authentication
            request.Headers["Authorization"] = "Basic " + Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(this.UserName + ":" + this.Password));
        }

        return request;
    }
}
