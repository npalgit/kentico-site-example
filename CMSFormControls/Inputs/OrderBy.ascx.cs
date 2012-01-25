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
using System.Text.RegularExpressions;

using CMS.GlobalHelper;
using CMS.FormControls;

public partial class CMSFormControls_Inputs_OrderBy : SqlFormControl
{
    /// <summary>
    /// Editing textbox
    /// </summary>
    protected override TextBox TextBoxControl
    {
        get
        {
            return this.txtOrder;
        }
    }


    /// <summary>
    /// Gets the regular expression for the safe value
    /// </summary>
    protected override Regex GetSafeRegEx()
    {
        // Build the regex
        string item = String.Format("(?:{0}(?:\\.{0})?(?:\\s+(?:ASC|DESC))?)", SQLIdentifier);
        string regex = String.Format("^\\s*(?:{0}(?:\\s*,\\s*{0})*)?\\s*$", item);

        // Expression groups: none
        return RegexHelper.GetRegex(regex, RegexOptions.IgnoreCase);
    }
}
