<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="secureaspx.aspx.cs" Inherits="CMSTemplates_sef_secureaspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
    
    




     <%if (BotLoggedIn)
            { %>
                 <div id="btnLogoutBot" class="blue" style="float: right; position: relative; cursor: pointer; top: -2px;">Logout</div>
        <h2>Secure files</h2>
        <cms:QueryRepeater 
        ID="CMSRepeater1" 
        runat="server" 
        QueryName="custom.pdf.selectAll"
        TransformationName="custom.pdf.Preview" 
        SelectedItemTransformationName="custom.pdf.Default"
        ItemSeparator="<hr />">
        </cms:QueryRepeater>
            <%}
              else
              { %>
                <a href="/About-us/Board-of-Trustees.aspx" >Click here to login</a>
            <%} %>










   





    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
