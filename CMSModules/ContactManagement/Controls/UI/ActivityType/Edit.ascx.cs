using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.FormControls;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.WebAnalytics;

public partial class CMSModules_ContactManagement_Controls_UI_ActivityType_Edit : CMSAdminEditControl
{
    #region "Properties"

    /// <summary>
    /// UIForm control used for editing objects properties.
    /// </summary>
    public UIForm UIFormControl
    {
        get
        {
            return this.EditForm;
        }
    }


    /// <summary>
    /// Indicates if the control should perform the operations.
    /// </summary>
    public override bool StopProcessing
    {
        get
        {
            return base.StopProcessing;
        }
        set
        {
            base.StopProcessing = value;
            this.EditForm.StopProcessing = value;
        }
    }


    /// <summary>
    /// Indicates if the control is used on the live site.
    /// </summary>
    public override bool IsLiveSite
    {
        get 
        { 
             return base.IsLiveSite;
        }
        set 
        {
            base.IsLiveSite = value;
            EditForm.IsLiveSite = value;
        }
    }

    #endregion


    #region "Page events"

    protected void Page_Load(object sender, EventArgs e)
    {
        bool develMode = SettingsKeyProvider.DevelopmentMode;
        EditForm.OnAfterSave += new EventHandler(EditForm_OnAfterSave);
        fIsCustom.Visible = develMode;
        ucDetailControl.ShowControlsOfType = 2;
        ucMainControl.ShowControlsOfType = 2;

        // Hide codename textbox and "allow manual creation" checkbox for system types
        if ((EditForm.EditedObject != null) && (EditForm.EditedObject.Generalized != null))
        {
            ActivityTypeInfo ati = ActivityTypeInfoProvider.GetActivityTypeInfo(EditForm.EditedObject.Generalized.ObjectID);
            if (ati != null)
            {
                fName.Visible = develMode || ati.ActivityTypeIsCustom;
                fManualCreationAllowed.Visible = ati.ActivityTypeIsCustom;
                fEnable.Visible = develMode || ati.ActivityTypeIsCustom;
            }
        }
    }


    void EditForm_OnAfterSave(object sender, EventArgs e)
    {
        RaiseOnSaved();
    }

    #endregion
}

