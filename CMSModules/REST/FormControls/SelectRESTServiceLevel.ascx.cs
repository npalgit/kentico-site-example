using System.Web.UI.WebControls;

using CMS.FormControls;
using CMS.GlobalHelper;

public partial class CMSModules_REST_FormControls_SelectRESTServiceLevel : FormEngineUserControl
{
    private int level = 0;


    protected override void CreateChildControls()
    {
        base.CreateChildControls();
        ReloadData();
    }


    /// <summary>
    /// Gets or sets the enabled state of the control.
    /// </summary>
    public override bool Enabled
    {
        get
        {
            return base.Enabled;
        }
        set
        {
            base.Enabled = value;
            this.radBoth.Enabled = value;
            this.radDocuments.Enabled = value;
            this.radObjects.Enabled = value;
        }
    }


    /// <summary>
    /// Gets or sets field value.
    /// </summary>
    public override object Value
    {
        get
        {
            if (radObjects.Checked)
            {
                return 1;
            }
            else if (radDocuments.Checked)
            {
                return 2;
            }
            return 0;
        }
        set
        {
            level = ValidationHelper.GetInteger(value, 0);
            ReloadData();
        }
    }


    /// <summary>
    /// Returns true if user control is valid.
    /// </summary>
    public override bool IsValid()
    {
        return true;
    }


    /// <summary>
    /// Selects correct value.
    /// </summary>
    private void ReloadData()
    {
        switch (level)
        {
            case 1:
                radObjects.Checked = true;
                break;

            case 2:
                radDocuments.Checked = true;
                break;

            default:
                radBoth.Checked = true;
                break;
        }
    }
}