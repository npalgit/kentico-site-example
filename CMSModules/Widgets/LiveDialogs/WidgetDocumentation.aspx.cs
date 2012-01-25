﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.UIControls;

public partial class CMSModules_Widgets_LiveDialogs_WidgetDocumentation : CMSLiveModalPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.CurrentMaster.Title.TitleText = GetString("WebPartDocumentDialog.Documentation");
        this.CurrentMaster.Title.TitleImage = GetImageUrl("CMSModules/CMS_PortalEngine/Documentation.png");
        this.CurrentMaster.Title.TitleCssClass = "WebPartDocumentationHeader";
        ucWebPartDocumentation.FooterClientID = divFooter.ClientID;
    }
}

