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
using CMS.MessageBoard;
using CMS.GlobalHelper;
using CMS.CMSHelper;
using CMS.ExtendedControls;
using CMS.PortalEngine;
using CMS.SettingsProvider;

public partial class CMSModules_MessageBoards_Controls_Boards_BoardModerators : CMSAdminEditControl
{
    #region "Variables"

    protected int mBoardID = 0;
    protected BoardInfo board = null;
    private string currentValues = String.Empty;

    private bool mShouldReloadData = false;

    #endregion


    #region "Properites"

    /// <summary>
    /// ID of the current message board.
    /// </summary>
    public int BoardID
    {
        get
        {
            return this.mBoardID;
        }
        set
        {
            this.mBoardID = value;
        }
    }

    #endregion


    #region "Private properties"

    /// <summary>
    /// Indicates whether the data should be reloaded on PreRender.
    /// </summary>
    private bool ShouldReloadData 
    {
        get 
        {
            return this.mShouldReloadData;
        }
        set 
        {
            this.mShouldReloadData = value;
        }
    }

    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {
        // Register script for pendingCallbacks repair
        ScriptHelper.FixPendingCallbacks(this.Page);

        // Initializes the controls
        SetupControls();
    }


    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // Reload data if necessary
        if (this.ShouldReloadData || (!URLHelper.IsPostback() && !this.IsLiveSite))
        {
            this.currentValues = "";
            userSelector.CurrentValues = GetModerators();

            ReloadData();
        }

        if (board != null)
        {
            bool canModify = CMSContext.CurrentUser.IsAuthorizedPerResource("cms.messageboards", CMSAdminControl.PERMISSION_MODIFY);
            this.userSelector.Enabled = board.BoardModerated && canModify;
            this.chkBoardModerated.Enabled = canModify;
        }
    }


    private void SetupControls()
    {
        // Get resource strings
        this.lblModerators.Text = GetString("board.moderators.title") + ResHelper.Colon;
        this.chkBoardModerated.Text = GetString("board.moderators.ismoderated");
        this.userSelector.CurrentSelector.OnSelectionChanged += new EventHandler(CurrentSelector_OnSelectionChanged);

        board = BoardInfoProvider.GetBoardInfo(this.BoardID);
        if (this.BoardID > 0)
        {
            EditedObject = board;
        }

        if (board != null)
        {
            userSelector.BoardID = this.BoardID;
            userSelector.GroupID = board.BoardGroupID;
            userSelector.CurrentSelector.SelectionMode = SelectionModeEnum.Multiple;
            userSelector.ShowSiteFilter = false;
            userSelector.SiteID = CMSContext.CurrentSiteID;
            userSelector.CurrentValues = GetModerators();
            userSelector.IsLiveSite = this.IsLiveSite;
        }
    }


    /// <summary>
    /// Reloads form data.
    /// </summary>
    public override void ReloadData()
    {
        ReloadData(true);
    }

    /// <summary>
    /// Reloads form data.
    /// </summary>
    public override void ReloadData(bool forceReload)
    {
        base.ReloadData(forceReload);

        // Get board info
        if (board != null)
        {
            chkBoardModerated.Checked = board.BoardModerated;
            if (forceReload)
            {
                if (!String.IsNullOrEmpty(currentValues))
                {
                    string where = SqlHelperClass.AddWhereCondition(this.userSelector.CurrentSelector.WhereCondition, "UserID IN (" + this.currentValues.Replace(';', ',') + ")", "OR");
                    this.userSelector.CurrentSelector.WhereCondition = where;
                }

                userSelector.CurrentSelector.Value = GetModerators();
                userSelector.ReloadData();
            }
        }
    }


    /// <summary>
    /// Returns ID of users who are moderators to this board.
    /// </summary>
    protected string GetModerators()
    {
        if (String.IsNullOrEmpty(currentValues))
        {
            // Get all message board moderators
            DataSet ds = BoardModeratorInfoProvider.GetBoardModerators(this.BoardID, "UserID", null, null, 0);
            if (!DataHelper.DataSourceIsEmpty(ds))
            {
                currentValues = TextHelper.Join(";", SqlHelperClass.GetStringValues(ds.Tables[0], "UserID"));
            }
        }

        return currentValues;
    }


    /// <summary>
    /// Board moderated checkbox change.
    /// </summary>
    protected void chkBoardModerated_CheckedChanged(object sender, EventArgs e)
    {
        if (!CheckPermissions("cms.messageboards", CMSAdminControl.PERMISSION_MODIFY))
        {
            return;
        }

        if (board != null)
        {
            board.BoardModerated = chkBoardModerated.Checked;
            BoardInfoProvider.SetBoardInfo(board);

            lblInfo.Visible = true;
            lblInfo.Text = GetString("General.Changessaved");

            this.ShouldReloadData = true;
        }
    }


    void CurrentSelector_OnSelectionChanged(object sender, EventArgs e)
    {
        this.ShouldReloadData = true;
    }
}
