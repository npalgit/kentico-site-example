<%@ Page Language="C#" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" AutoEventWireup="true" Inherits="CMSModules_Blogs_MyBlogs_MyBlogs_Blogs_List"
    Title="Blogs - List" Theme="Default" CodeFile="MyBlogs_Blogs_List.aspx.cs" %>
<%@ Register src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" tagname="UniGrid" tagprefix="cms" %>

<asp:Content ID="contentElem" ContentPlaceHolderID="plcContent" runat="Server">
   <%-- <cms:LocalizedLabel ID="lblInfo" runat="server" CssClass="InfoLabel" ResourceString="mydesk.ui.noblogs"
        Visible="true" EnableViewState="false" />--%>
    <asp:Label ID="lblError" runat="server" CssClass="ErrorLabel" Visible="false" EnableViewState="false" />
    <cms:UniGrid ID="gridBlogs" runat="server" GridName="~/CMSModules/Blogs/Tools/Blog_List.xml"
        IsLiveSite="false" />

    <script type="text/javascript"> 
    //<![CDATA[
           // Open blog edit page in CMSDesk
        function EditBlog(nodeId, culture)
        {
            if ( nodeId != 0 )
            {
                parent.parent.parent.location.href = "../../../CMSDesk/default.aspx?section=content&action=edit&nodeid=" + nodeId + "&culture=" + culture;
            }
        }
    //]]>
    </script>

    <asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
</asp:Content>
