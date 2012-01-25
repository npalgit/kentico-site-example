<%@ Page Language="C#" AutoEventWireup="true"
    Inherits="CMSModules_Notifications_Administration_Users_User_Edit_Notifications" Theme="Default"
    MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" CodeFile="User_Edit_Notifications.aspx.cs" %>

<%@ Register Src="~/CMSModules/Notifications/Controls/UserNotifications.ascx"
    TagName="UserNotifications" TagPrefix="cms" %>
<asp:Content ID="cntBody" runat="server" ContentPlaceHolderID="plcContent">
    <asp:Label runat="server" ID="lblError" CssClass="ErrorLabel" EnableViewState="false"
        Visible="false" />
    <cms:UserNotifications ID="userNotificationsElem" runat="server" />
</asp:Content>
