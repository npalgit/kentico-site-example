using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public static class settings
{
    public static string ContentPath 
    {
        get
        {
            return "custom.contentPath".AppSetting<string>("/content");
        }
    }

}