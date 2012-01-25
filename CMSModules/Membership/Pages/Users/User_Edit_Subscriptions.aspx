<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Inherits="CMSModules_Membership_Pages_Users_User_Edit_Subscriptions"
    Theme="Default" CodeFile="User_Edit_Subscriptions.aspx.cs" %>

<%@ Register Src="~/CMSModules/Membership/Controls/Subscriptions.ascx" TagName="Subscriptions"
    TagPrefix="cms" %>
<asp:Content ContentPlaceHolderID="plcContent" ID="content" runat="server">
    <cms:LocalizedLabel runat="server" ID="lblError" CssClass="ErrorLabel" EnableViewState="false"
            Visible="false" ResourceString="Administration-User_List.ErrorGlobalAdmin" />
    <cms:Subscriptions ID="elemSubscriptions" runat="server" IsLiveSite="false" />
</asp:Content>
