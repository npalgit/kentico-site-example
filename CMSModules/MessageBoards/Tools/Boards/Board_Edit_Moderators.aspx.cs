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

using CMS.MessageBoard ;
using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;

public partial class CMSModules_MessageBoards_Tools_Boards_Board_Edit_Moderators : CMSMessageBoardBoardsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int boardId = QueryHelper.GetInteger("boardid", 0);
        this.boardModerators.BoardID = boardId;
        this.boardModerators.IsLiveSite = false;
    }
}
