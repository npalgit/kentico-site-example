using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using CMS.GlobalHelper;
using CMS.FormEngine;
using CMS.UIControls;

// Set help
[Help("alternative_forms_general", "helpTopic")]

public partial class CMSModules_SystemTables_Pages_Development_AlternativeForms_Header : SiteManagerPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int classId = QueryHelper.GetInteger("classid", 0);
        int altFormId = QueryHelper.GetInteger("altformid", 0);
        int saved = QueryHelper.GetInteger("saved", 0);

        AlternativeFormInfo afi = AlternativeFormInfoProvider.GetAlternativeFormInfo(altFormId);

        if (!RequestHelper.IsPostBack())
        {
            InitalizeMenu(classId, altFormId, saved);
        }

        // Set Breadcrumbs
        InitBreadcrumbs(2);
        SetBreadcrumb(0, GetString("altforms.listlink"), ResolveUrl("~/CMSModules/SystemTables/Pages/Development/AlternativeForms/List.aspx?classid=" + classId + "&altformid=" + altFormId), "content", null);
        SetBreadcrumb(1, afi != null ? afi.FormDisplayName : String.Empty, null, null, null);
    }


    /// <summary>
    /// Initializes edit menu.
    /// </summary>
    protected void InitalizeMenu(int classId, int altFormId, int saved)
    {
        string urlParams = "?classid=" + classId.ToString() + "&altformid=" + altFormId.ToString();

        InitTabs(3, "altFormsContent");
        SetTab(0, GetString("general.general"), "Edit_General.aspx" + urlParams + "&saved=" + saved, "SetHelpTopic('helpTopic','alternative_forms_general')");
        SetTab(1, GetString("general.fields"), "Fields.aspx" + urlParams, "SetHelpTopic('helpTopic','alternative_forms_fields')");
        SetTab(2, GetString("general.layout"), "Layout.aspx" + urlParams, "SetHelpTopic('helpTopic','alternative_forms_layout')");
    }
}
