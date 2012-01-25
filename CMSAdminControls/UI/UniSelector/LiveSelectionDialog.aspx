<%@ Page Language="C#" AutoEventWireup="true"
    Inherits="CMSAdminControls_UI_UniSelector_LiveSelectionDialog" Title="Live Selection Dialog"
    ValidateRequest="false" Theme="default" MasterPageFile="~/CMSMasterPages/LiveSite/Dialogs/ModalDialogPage.master" CodeFile="LiveSelectionDialog.aspx.cs" %>

<%@ Register Src="Controls/SelectionDialog.ascx" TagName="SelectionDialog" TagPrefix="cms" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="plcContent" runat="Server">
    <cms:SelectionDialog runat="server" ID="selectionDialog" IsLiveSite="true" />
</asp:Content>
<asp:Content ID="cntFooter" ContentPlaceHolderID="plcFooter" runat="server">
    <div class="FloatRight">
        <cms:LocalizedButton ID="btnOk" runat="server" CssClass="SubmitButton" Visible="false"
            EnableViewState="False" /><cms:LocalizedButton ID="btnCancel" runat="server" CssClass="SubmitButton"
                EnableViewState="False" />
    </div>
</asp:Content>
