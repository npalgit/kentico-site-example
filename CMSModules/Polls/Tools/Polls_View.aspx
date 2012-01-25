<%@ Page Language="C#" AutoEventWireup="true"
    Inherits="CMSModules_Polls_Tools_Polls_View"
    MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="Polls - View poll" 
    Theme="Default" CodeFile="Polls_View.aspx.cs" %>

<%@ Register Src="~/CMSModules/Polls/Controls/PollView.ascx" TagName="PollView" TagPrefix="cms" %>
    
<asp:Content ID="cntBody" runat="server" ContentPlaceHolderID="plcContent">
    <div style="width: 300px;">
        <cms:PollView ID="pollElem" runat="server" />
    </div>
</asp:Content>
