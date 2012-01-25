<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="TrustMember.aspx.cs" Inherits="CMSTemplates_sef_TrustMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
        <input type="hidden" id="botLogged" name="botLogged" value="<%=BotLoggedIn %>" />
        <div style="float: right; padding: 10px; border-radius: 5px 5px 5px 5px; box-shadow: 0pt 0pt 5px 0pt Gray;
            position: relative; top: -20px; right: -21px;" class="login">
            <%if (BotLoggedIn)
              { %>
            <div>
                <a href="/Secure.aspx">Access Secure Files</a></div>
            <%}
              else
              { %>
            <div class="form-wrap">
                <div class="input-field">
                    <label style="width: 100px;">
                        Login</label>
                    <div class="ctrl" style="padding-left: 90px;">
                        <input type="text" name="login" id="login" class="validate[required]" style="width: 120px;">
                    </div>
                </div>
                <div class="input-field">
                    <label style="width: 100px;">
                        Password</label>
                    <div class="ctrl" style="padding-left: 90px;">
                        <input type="password" name="password" id="password" class="validate[required]" style="width: 120px;">
                    </div>
                </div>
                <div class="ctrl" style="padding-left: 160px;">
                    <button id="btnLoginBot" type="button">
                        LOGIN</button>
                </div>
            </div>
            <%} %>
        </div>
        <h2>
            Board or Trustees</h2>
        <cms:QueryRepeater ID="CMSRepeater1" runat="server" QueryName="custom.trustmember.selectAll"
            TransformationName="custom.trustmember.Preview" SelectedItemTransformationName="custom.trustmember.Default"
            ItemSeparator="<hr />">
        </cms:QueryRepeater>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
