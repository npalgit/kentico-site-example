<%@ WebHandler Language="C#" Class="contact" %>

using System;
using System.Web;

public class contact : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Response.Clear();
        
        var form = HttpContext.Current.Request.Form;
        var title = form["title"];
        var fname = form["fname"];
        var lname = form["lname"];
        var email = form["email"];
        var phone = form["phone"];
        var inquiry = form["inquiry"];


        System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient();
        
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(String.Format("<div style='font-size: 11px; color: Gray; font-family: arial; padding: 10px; border: 1px solid Gray; border-radius: 5px 5px 5px 5px; box-shadow: 0pt 0pt 5px 0pt Gray;'>"));



        sb.Append(String.Format("<b>Detail of the Query from SEF Website Inquery page</b><hr /><br />"));        
        
        sb.Append(String.Format("<b>First Name</b>: {0}  <br />", fname));
        
        sb.Append(String.Format("<b>Last Name</b>: {0}  <br />", lname));

        sb.Append(String.Format("<b>Title</b>: {0}  <br />", title));

        sb.Append(String.Format("<b>Email Address</b>: {0}  <br />", email));

        sb.Append(String.Format("<b>Phone</b>: {0}  <br />", phone));

        sb.Append(String.Format("<hr />", fname));
        
        sb.Append(String.Format("<b>Inquiry</b>: {0}  <br />", inquiry));
        sb.Append(String.Format("</div>"));
        System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage(
           email,
           "toEmail".AppSetting<string>("asif.log@gmail.com"),
           "SEF - Inquery from Website",
           sb.ToString() 
            );

        client.Send(msg);
        
        
        HttpContext.Current.Response.End();
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
