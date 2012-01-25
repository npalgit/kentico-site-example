<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccountSelectorDialog.aspx.cs" Inherits="CMSModules_ContactManagement_FormControls_AccountSelectorDialog"
    EnableEventValidation="false" MasterPageFile="~/CMSMasterPages/UI/Dialogs/ModalDialogPage.master"
    Theme="Default" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<asp:Content ID="content" ContentPlaceHolderID="plcContent" runat="Server">
    <asp:Panel ID="pnlBody" runat="server" CssClass="UniSelectorDialogBody">
        <cms:cmsupdatepanel id="pnlUpdate" runat="server" updatemode="Conditional">
            <ContentTemplate>
                <div class="PageHeaderLine">
                    <div class="Actions">
                        <asp:Image ID="imgNew" runat="server" EnableViewState="false" CssClass="NewItemImage" />
                        <cms:LocalizedLinkButton ID="btnNew" runat="server" ResourceString="om.account.new" CssClass="NewItemLink" />
                    </div>
                </div>
                <div class="UniSelectorDialogGridArea">
                    <div class="UniSelectorDialogGridPadding">
                        <cms:LocalizedLabel runat="server" ID="lblInfo" CssClass="InfoLabel" EnableViewState="false" ResourceString="om.account.selectparent" />
                        <cms:UniGrid runat="server" ID="gridElem" ObjectType="om.account" OrderBy="AccountName"
                            Columns="AccountID,AccountName" IsLiveSite="false">
                            <GridColumns>
                                <ug:Column ExternalSourceName="AccountName" Source="##ALL##" Caption="$om.account.name$"
                                    Wrap="false">
                                    <Filter Type="text" Size="100" Source="AccountName" />
                                </ug:Column>
                                <ug:Column Width="100%" />
                            </GridColumns>
                            <GridOptions DisplayFilter="true" ShowSelection="false" FilterLimit="10" />
                        </cms:UniGrid>
                        <div class="ClearBoth">
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </cms:cmsupdatepanel>
    </asp:Panel>
</asp:Content>
<asp:Content ID="footer" ContentPlaceHolderID="plcFooter" runat="server">
    <div class="FloatRight">
        <cms:localizedbutton id="btnCancel" runat="server" cssclass="SubmitButton" enableviewstate="False"
            resourcestring="general.cancel" onclientclick="window.close();return false;" />
    </div>
</asp:Content>
