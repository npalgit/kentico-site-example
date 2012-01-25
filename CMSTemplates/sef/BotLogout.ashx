<%@ WebHandler Language="C#" Class="BotLogout" %>

using System;
using System.Web;

public class BotLogout : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Session["botLogged"] = null;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}