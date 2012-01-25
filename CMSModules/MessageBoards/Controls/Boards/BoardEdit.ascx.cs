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

using CMS.UIControls;
using CMS.CMSHelper;
using CMS.MessageBoard;
using CMS.GlobalHelper;
using CMS.SiteProvider;
using CMS.SettingsProvider;
using CMS.WebAnalytics;

public partial class CMSModules_MessageBoards_Controls_Boards_BoardEdit : CMSAdminEditControl
{
    #region "Private fields"

    private int mBoardID = 0;
    private BoardInfo mCurrentBoard = null;
    private bool mExternalParent = false;

    #endregion


    #region "Public properties"

    /// <summary>
    /// Current board ID.
    /// </summary>
    public int BoardID
    {
        get
        {
            if (this.mBoardID == 0)
            {
                this.mBoardID = QueryHelper.GetInteger("boardid", 0);
            }

            return this.mBoardID;
        }
        set
        {
            this.mBoardID = value;
        }
    }


    /// <summary>
    /// Indicates whether the control has external parent.
    /// </summary>
    public bool ExternalParent
    {
        get
        {
            return this.mExternalParent;
        }
        set
        {
            this.mExternalParent = value;
        }
    }

    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {

        txtBoardDisplayName.IsLiveSite = this.IsLiveSite;
        txtBoardDescription.IsLiveSite = this.IsLiveSite;

        if (this.StopProcessing || !this.Visible)
        {
            this.EnableViewState = false;
            return;
        }

        // If control should be hidden save view state memory
        if (!this.Visible)
        {
            this.EnableViewState = false;
        }

        // Initializes the controls
        SetupControls();

        // Reload data if necessary
        if (!URLHelper.IsPostback() && !this.IsLiveSite)
        {
            ReloadData();
        }
    }


    /// <summary>
    /// Initializes the controls on the page.
    /// </summary>
    private void SetupControls()
    {
        // Hide code name editing for simple mode
        if (this.DisplayMode == ControlDisplayModeEnum.Simple)
        {
            this.plcCodeName.Visible = false;
        }

        // Register scripts
        ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "ShowDateFields",
            ScriptHelper.GetScript(
                "function ShowDateFields(){ \n" +
                "    document.getElementById('" + this.lblBoardOpenFrom.ClientID + "').style.display = 'block'; \n" +
                "    document.getElementById('" + this.dtpBoardOpenFrom.ClientID + "').style.display = 'block'; \n" +
                "    document.getElementById('" + this.lblBoardOpenTo.ClientID + "').style.display = 'block'; \n" +
                "    document.getElementById('" + this.dtpBoardOpenTo.ClientID + "').style.display = 'block'; } \n" +
                "function HideDateFields(){ \n " +
                "    document.getElementById('" + this.lblBoardOpenFrom.ClientID + "').style.display = 'none'; \n " +
                "    document.getElementById('" + this.dtpBoardOpenFrom.ClientID + "').style.display = 'none'; \n" +
                "    document.getElementById('" + this.lblBoardOpenTo.ClientID + "').style.display = 'none'; \n" +
                "    document.getElementById('" + this.dtpBoardOpenTo.ClientID + "').style.display = 'none'; }"
            ));

        ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "CheckBoxes",
            ScriptHelper.GetScript(@"
                function check(txtId,chk,inhV)  
                {
                    txt = document.getElementById(txtId);
                    if ((txt != null)&&(chk != null))
                    {
                        if (chk.checked)
                        {
                            txt.disabled = 'disabled';
                            txt.value = inhV;
                        }
                        else
                        {
                            txt.disabled = '';
                        }
                    }
                }"
           ));

        // Set the labels
        this.lblBoardCodeName.Text = GetString("general.codename") + ResHelper.Colon;
        this.lblBoardOwner.Text = GetString("board.owner.title") + ResHelper.Colon;
        this.lblBoardDescription.Text = GetString("general.description") + ResHelper.Colon;
        this.lblBoardDisplayName.Text = GetString("general.displayname") + ResHelper.Colon;
        this.lblBoardEnable.Text = GetString("general.enable") + ResHelper.Colon;
        this.lblBoardOpen.Text = GetString("general.open") + ResHelper.Colon;
        this.lblBoardOpenFrom.Text = GetString("general.openfrom") + ResHelper.Colon;
        this.lblBoardOpenTo.Text = GetString("general.opento") + ResHelper.Colon;
        this.lblBoardRequireEmail.Text = GetString("board.edit.requireemail") + ResHelper.Colon;
        this.lblUnsubscriptionUrl.Text = GetString("general.unsubscriptionurl") + ResHelper.Colon;
        this.lblBaseUrl.Text = GetString("general.baseurl") + ResHelper.Colon;
        this.btnOk.Text = GetString("general.ok");

        this.chkBoardOpen.Attributes.Add("onclick", "if(this.checked){ ShowDateFields() }else{ HideDateFields() }");

        // Set the error messages for validators
        this.rfvBoardCodeName.ErrorMessage = GetString("board.edit.errcodename");
        this.rfvBoardDisplayName.ErrorMessage = GetString("board.edit.errdisplayname");

        if (IsLiveSite)
        {
            plcUnsubscription.Visible = false;
        }

        this.lblBoardOwnerText.Attributes.Add("style", "font-weight: bold;");

        chkInheritBaseUrl.Attributes.Add("onclick", "check('" + txtBaseUrl.ClientID + "', this,'" + ValidationHelper.GetString(SettingsKeyProvider.GetStringValue(CMSContext.CurrentSiteName + ".CMSBoardBaseUrl"), "") + "')");
        chkInheritUnsubUrl.Attributes.Add("onclick", "check('" + txtUnsubscriptionUrl.ClientID + "', this,'" + ValidationHelper.GetString(SettingsKeyProvider.GetStringValue(CMSContext.CurrentSiteName + ".CMSBoardUnsubsriptionURL"), "") + "')");

        if (ActivitySettingsHelper.IsModuleLoaded())
        {
            this.plcOnline.Visible = true;
        }
    }


    /// <summary>
    /// Reloads the data in the form.
    /// </summary>
    public override void ReloadData()
    {
        base.ReloadData();

        SetupControls();

        if ((mCurrentBoard == null) || (mCurrentBoard.BoardID != this.BoardID))
        {
            // Get the board info
            this.mCurrentBoard = BoardInfoProvider.GetBoardInfo(this.BoardID);
        }

        EditedObject = mCurrentBoard;

        if (mCurrentBoard != null)
        {
            this.txtBoardCodeName.Text = mCurrentBoard.BoardName;
            this.txtBoardDisplayName.Text = mCurrentBoard.BoardDisplayName;
            this.txtBoardDescription.Text = mCurrentBoard.BoardDescription;
            this.txtUnsubscriptionUrl.Text = mCurrentBoard.BoardUnsubscriptionURL;
            this.txtBaseUrl.Text = mCurrentBoard.BoardBaseURL;

            this.chkBoardEnable.Checked = mCurrentBoard.BoardEnabled;
            this.chkBoardOpen.Checked = mCurrentBoard.BoardOpened;
            this.chkBoardRequireEmail.Checked = mCurrentBoard.BoardRequireEmails;
            this.chkSubscriptionsEnable.Checked = mCurrentBoard.BoardEnableSubscriptions;

            this.dtpBoardOpenFrom.SelectedDateTime = mCurrentBoard.BoardOpenedFrom;
            this.dtpBoardOpenTo.SelectedDateTime = mCurrentBoard.BoardOpenedTo;

            // Load the owner info
            string owner = "";
            if (mCurrentBoard.BoardGroupID > 0)
            {
                owner = GetString("board.owner.group");
            }
            else if (mCurrentBoard.BoardUserID > 0)
            {
                owner = GetString("general.user");
            }
            else
            {
                owner = GetString("board.owner.document");
            }

            this.lblBoardOwnerText.Text = owner;

            // Set base/unsubscription URL inheritance
            chkInheritBaseUrl.Checked = (mCurrentBoard.GetValue("BoardBaseUrl") == null);
            chkInheritUnsubUrl.Checked = (mCurrentBoard.GetValue("BoardUnsubscriptionUrl") == null);

            if (!chkInheritBaseUrl.Checked)
            {
                txtBaseUrl.Attributes.Remove("disabled");
            }
            else
            {
                txtBaseUrl.Attributes.Add("disabled", "disabled");
            }

            if (!chkInheritUnsubUrl.Checked)
            {
                txtUnsubscriptionUrl.Attributes.Remove("disabled");
            }
            else
            {
                txtUnsubscriptionUrl.Attributes.Add("disabled", "disabled");
            }

            // If the open date-time details should be displayed
            bool isChecked = this.chkBoardOpen.Checked;
            this.lblBoardOpenFrom.Attributes.Add("style", (isChecked) ? "display: block;" : "display: none;");
            this.dtpBoardOpenFrom.Attributes.Add("style", (isChecked) ? "display: block;" : "display: none;");
            this.lblBoardOpenTo.Attributes.Add("style", (isChecked) ? "display: block;" : "display: none;");
            this.dtpBoardOpenTo.Attributes.Add("style", (isChecked) ? "display: block;" : "display: none;");

            if (this.plcOnline.Visible)
            {
                this.chkLogActivity.Checked = this.mCurrentBoard.BoardLogActivity;
            }
        }
    }


    #region "Event handlers"

    protected void btnOk_Click(object sender, EventArgs e)
    {
        if (!CheckPermissions("cms.messageboards", CMSAdminControl.PERMISSION_MODIFY))
        {
            return;
        }

        this.mCurrentBoard = BoardInfoProvider.GetBoardInfo(this.BoardID);
        if (this.mCurrentBoard != null)
        {
            string errMsg = ValidateForm();

            // If the entries were valid
            if (string.IsNullOrEmpty(errMsg))
            {
                // Get info on existing board

                try
                {
                    // Update board information
                    if (this.plcCodeName.Visible)
                    {
                        this.mCurrentBoard.BoardName = this.txtBoardCodeName.Text;
                    }

                    this.mCurrentBoard.BoardDisplayName = this.txtBoardDisplayName.Text;
                    this.mCurrentBoard.BoardDescription = this.txtBoardDescription.Text;
                    this.mCurrentBoard.BoardEnabled = this.chkBoardEnable.Checked;
                    this.mCurrentBoard.BoardOpened = this.chkBoardOpen.Checked;
                    this.mCurrentBoard.BoardOpenedFrom = this.dtpBoardOpenFrom.SelectedDateTime;
                    this.mCurrentBoard.BoardOpenedTo = this.dtpBoardOpenTo.SelectedDateTime;
                    if (!IsLiveSite)
                    {
                        this.mCurrentBoard.BoardUnsubscriptionURL = chkInheritUnsubUrl.Checked ? null : this.txtUnsubscriptionUrl.Text.Trim();
                        this.mCurrentBoard.BoardBaseURL = chkInheritBaseUrl.Checked ? null : this.txtBaseUrl.Text.Trim();

                    }
                    this.mCurrentBoard.BoardRequireEmails = this.chkBoardRequireEmail.Checked;
                    this.mCurrentBoard.BoardEnableSubscriptions = this.chkSubscriptionsEnable.Checked;

                    if (plcOnline.Visible)
                    {
                        this.mCurrentBoard.BoardLogActivity = this.chkLogActivity.Checked;
                    }

                    // Save changes
                    BoardInfoProvider.SetBoardInfo(this.mCurrentBoard);

                    // Inform user on success
                    this.lblInfo.Text = GetString("general.changessaved");
                    this.lblInfo.Visible = true;

                    // Refresh tree if external parent
                    if (this.ExternalParent)
                    {
                        ltlScript.Text = ScriptHelper.GetScript("window.parent.parent.frames['tree'].RefreshNode('" + this.mCurrentBoard.BoardDisplayName + "', '" + this.mCurrentBoard.BoardID + "')");
                    }

                    // Refresh the fields initiaized with JavaScript
                    ReloadData();
                }
                catch (Exception ex)
                {
                    this.lblError.Visible = true;
                    this.lblError.Text = GetString("general.erroroccurred") + " " + ex.Message;
                }
            }
            else
            {
                // Inform user on error
                this.lblError.Visible = true;
                this.lblError.Text = errMsg;
            }
        }
    }

    #endregion


    #region "Private methods"

    /// <summary>
    /// Validates form entries.
    /// </summary>    
    private string ValidateForm()
    {
        string errMsg = new Validator().NotEmpty(this.txtBoardDisplayName.Text.Trim(), rfvBoardDisplayName.ErrorMessage).Result;

        if (this.txtBoardCodeName.Visible && String.IsNullOrEmpty(errMsg))
        {
            errMsg = new Validator().NotEmpty(this.txtBoardCodeName.Text.Trim(), rfvBoardCodeName.ErrorMessage).Result;

            if (!ValidationHelper.IsCodeName(this.txtBoardCodeName.Text.Trim()))
            {
                errMsg = GetString("general.errorcodenameinidentificatorformat");
            }
        }

        if (!dtpBoardOpenFrom.IsValidRange() || !dtpBoardOpenTo.IsValidRange())
        {
            errMsg = GetString("general.errorinvaliddatetimerange");
        }

        if (string.IsNullOrEmpty(errMsg))
        {
            // Check if the board with given name doesn't exist for particular document
            BoardInfo bi = BoardInfoProvider.GetBoardInfo(this.txtBoardCodeName.Text.Trim(), this.mCurrentBoard.BoardDocumentID);
            if ((bi != null) && (bi.BoardID != this.mCurrentBoard.BoardID))
            {
                errMsg = GetString("general.codenameexists");
            }

            if (errMsg == "")
            {
                // If the board is open check date-time settings
                if (this.chkBoardOpen.Checked)
                {
                    //// Initialize default values
                    DateTime from = DateTimeHelper.ZERO_TIME;
                    DateTime to = DateTimeHelper.ZERO_TIME;
                    bool wasWrongDateTime = true;


                    //// Check if the date-time value is in valid format
                    bool isValidDateTime = ((DateTime.TryParse(this.dtpBoardOpenFrom.DateTimeTextBox.Text, out from) || string.IsNullOrEmpty(this.dtpBoardOpenFrom.DateTimeTextBox.Text)) &&
                                            (DateTime.TryParse(this.dtpBoardOpenTo.DateTimeTextBox.Text, out to) || string.IsNullOrEmpty(this.dtpBoardOpenTo.DateTimeTextBox.Text)));

                    // Check if the date-time doesn't overleap
                    if (isValidDateTime)
                    {
                        // If the date-time values are valid
                        if ((from <= to) || ((from == DateTimeHelper.ZERO_TIME) || (to == DateTimeHelper.ZERO_TIME)))
                        {
                            wasWrongDateTime = false;
                        }
                    }

                    if (wasWrongDateTime)
                    {
                        errMsg = GetString("board.edit.wrongtime");
                    }
                }
            }
        }

        return errMsg;
    }

    #endregion
}
