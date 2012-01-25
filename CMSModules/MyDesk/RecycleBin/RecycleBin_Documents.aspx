<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RecycleBin_Documents.aspx.cs" Inherits="CMSModules_MyDesk_RecycleBin_RecycleBin_Documents" Theme="Default" EnableEventValidation="false" MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="MyDesk - Documents recycle bin" %>

<%@ Register Src="~/CMSModules/RecycleBin/Controls/RecycleBin.ascx" TagName="RecycleBin"
    TagPrefix="cms" %>
<asp:Content ID="cntBody" ContentPlaceHolderID="plcContent" runat="server">
    <cms:CMSUpdatePanel ID="pnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <cms:RecycleBin ID="recycleBin" runat="server" IsCMSDesk="true" />
        </ContentTemplate>
    </cms:CMSUpdatePanel>
</asp:Content>
