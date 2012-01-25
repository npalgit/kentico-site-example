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

public partial class CMSFormControls_Inputs_WhereCondition : SqlFormControl
{
    /// <summary>
    /// Editing textbox
    /// </summary>
    protected override TextBox TextBoxControl
    {
        get
        {
            return this.txtWhere;
        }
    }


    /// <summary>
    /// Gets the regular expression for the safe value
    /// </summary>
    protected override Regex GetSafeRegEx()
    {
        // Build the regex
        string number = "[0-9.]*";
        string str = "'[^']*'";

        string item = String.Format("(?:{0}(?:\\.{0})?|{1}|{2})", SQLIdentifier, number, str);
        string space = "[ ()]";
        string op = String.Format("(?:[+*/%=\\-]|<>|>=?|<=?|{0}+(?:OR|AND|(?:NOT )?LIKE){0}+)", space);

        string regex = String.Format("^{0}*(?:{1}(?:{0}*{2}{0}*{1})*)?{0}*$", space, item, op);

        // Expression groups: none
        return RegexHelper.GetRegex(regex, RegexOptions.IgnoreCase);
    }
}
