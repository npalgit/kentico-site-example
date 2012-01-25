<%@ WebHandler Language="C#" Class="BotLogin" %>

using System;
using System.Web;

public class BotLogin : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Response.Clear();
        if (context.Request.Form["login"] == System.Configuration.ConfigurationManager.AppSettings["botLogin"]
            && context.Request.Form["password"] == System.Configuration.ConfigurationManager.AppSettings["botPassword"])
        {
            HttpContext.Current.Session["botLogged"] = true;
            HttpContext.Current.Response.Write("1");
        }
        else
        {
            HttpContext.Current.Response.Write("0");
        }
        HttpContext.Current.Response.End();
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}