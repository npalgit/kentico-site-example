<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_ImportExport_Controls_NewSiteWizard"
    CodeFile="NewSiteWizard.ascx.cs" %>
<%@ Register Src="~/CMSAdminControls/Wizard/Header.ascx" TagName="WizardHeader" TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/ImportPanel.ascx" TagName="ImportPanel"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/ImportConfiguration.ascx" TagName="ImportConfiguration"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/ImportSiteDetails.ascx" TagName="ImportSiteDetails"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/UI/System/ActivityBar.ascx" TagName="ActivityBar"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/NewSiteType.ascx" TagName="NewSiteType"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/SelectWebTemplate.ascx" TagName="SelectWebTemplate"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/SelectMasterTemplate.ascx" TagName="SelectMasterTemplate"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/DefineSiteStructure.ascx" TagName="DefineSiteStructure"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/ImportExport/Controls/NewSiteFinish.ascx" TagName="NewSiteFinish"
    TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/AsyncControl.ascx" TagName="AsyncControl" TagPrefix="cms" %>

<script type="text/javascript">
    //<![CDATA[      
    var importTimerId = 0;
    var timerSelectionId = 0;

    // Start timer function
    function StartImportStateTimer() {
        importTimerId = setInterval("GetImportState(false)", 500);
    }

    // End timer function
    function StopImportStateTimer(hideWindow) {
        if (importTimerId) {
            clearInterval(importTimerId);
            importTimerId = 0;

            if (window.HideActivity) {
                window.HideActivity();
            }
        }
    }

    // End timer function
    function StopSelectionTimer() {
        if (timerSelectionId) {
            clearInterval(timerSelectionId);
            timerSelectionId = 0;

            if (window.HideActivity) {
                window.HideActivity();
            }
        }
    }

    // Start timer function
    function StartSelectionTimer() {
        if (window.Activity) {
            timerSelectionId = setInterval("window.Activity()", 500);
        }
    }

    // Cancel import
    function CancelImport() {
        GetImportState(true);
        return false;
    }
    //]]>
</script>

<asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
<asp:Panel ID="pnlWrapper" runat="Server">
    <table class="GlobalWizard" border="0" cellpadding="0" cellspacing="0">
        <tr class="Top">
            <td class="Left">
                &nbsp;
            </td>
            <td class="Center">
                <div style="width: 750px;">
                    <cms:WizardHeader ID="ucHeader" runat="server" />
                </div>
            </td>
            <td class="Right">
                &nbsp;
            </td>
        </tr>
        <tr class="Middle">
            <td class="Center" colspan="3">
                <div id="wzdBody">
                    <asp:Wizard ID="wzdImport" runat="server" DisplaySideBar="False" NavigationButtonStyle-Width="100"
                        NavigationStyle-HorizontalAlign="Right" CssClass="Wizard">
                        <StartNavigationTemplate>
                            <div class="WizardProgress">
                                <div id="actDiv" style="display: none;">
                                    <div class="WizardProgressLabel">
                                        <cms:LocalizedLabel ID="lblActivityInfo" runat="server" Text="{$Export.SelectionInfo$}" />
                                    </div>
                                    <cms:ActivityBar runat="server" ID="barActivity" Visible="true" />
                                </div>
                            </div>
                            <div id="buttonsDiv" class="WizardButtons">
                                <cms:LocalizedButton UseSubmitBehavior="True" ID="StepNextButton" runat="server"
                                    CommandName="MoveNext" Text="{$general.next$} >" CssClass="SubmitButton" OnClientClick="return NextStepAction();"
                                    RenderScript="true" />
                            </div>
                        </StartNavigationTemplate>
                        <StepNavigationTemplate>
                            <div class="WizardProgress">
                                <% if ((wzdImport.ActiveStepIndex == 4) || (wzdImport.ActiveStepIndex == 1))
                                   { %>
                                <div id="actDiv" <% if (wzdImport.ActiveStepIndex == 1) { %> style="display: none;"
                                    <% } %>>
                                    <div class="WizardProgressLabel">
                                        <% if (wzdImport.ActiveStepIndex == 1)
                                           { %>
                                        <cms:LocalizedLabel ID="lblActivityInfo" runat="server" Text="{$Export.SelectionInfo$}" />
                                        <% }
                                           else
                                           { %>
                                        <cms:LocalizedLabel ID="lblActivityImportInfo" runat="server" Text="{$import.progress$}" />
                                        <% } %>
                                    </div>
                                    <cms:ActivityBar runat="server" ID="barActivity" Visible="true" />
                                </div>
                                <% } %>
                            </div>
                            <div id="buttonsDiv" class="WizardButtons">
                                <cms:LocalizedButton UseSubmitBehavior="True" ID="StepPreviousButton" runat="server"
                                    CommandName="MovePrevious" Text="{$ExportSiteSettings.PreviousStep$}" CssClass="SubmitButton"
                                    CausesValidation="false" RenderScript="true" /><% if (wzdImport.ActiveStepIndex == 4)
                                                                                      { %><cms:LocalizedButton UseSubmitBehavior="True" ID="StepCancelButton" runat="server"
                                                                                          CommandName="Cancel" Text="{$general.cancel$}" CssClass="SubmitButton" CausesValidation="false"
                                                                                          RenderScript="true" /><% } %><cms:LocalizedButton UseSubmitBehavior="True" ID="StepNextButton"
                                                                                              runat="server" CommandName="MoveNext" Text="{$general.next$} >" CssClass="SubmitButton"
                                                                                              OnClientClick="return NextStepAction();" RenderScript="true" />
                            </div>
                        </StepNavigationTemplate>
                        <FinishNavigationTemplate>
                            <div id="buttonsDiv" class="WizardButtons">
                                <cms:LocalizedButton UseSubmitBehavior="True" ID="StepFinishButton" runat="server"
                                    CommandName="MoveComplete" ResourceString="general.finish" CssClass="SubmitButton"
                                    RenderScript="true" />
                            </div>
                        </FinishNavigationTemplate>
                        <WizardSteps>
                            <asp:WizardStep ID="wzdStepStart" runat="server" AllowReturn="False" StepType="Start"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <cms:NewSiteType runat="server" ID="siteType" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepTemplate" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <cms:SelectWebTemplate runat="server" ID="selectTemplate" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepSiteDetails" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <cms:ImportSiteDetails ID="siteDetails" runat="server" AllowExisting="false" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepSelection" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStepPanel" style="height: <%= PanelHeight %>px;">
                                    <div class="WizardBorder">
                                        <cms:ImportPanel ID="pnlImport" runat="server" />
                                    </div>
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepProgress" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <asp:Label ID="lblProgress" runat="Server" CssClass="WizardLog" EnableViewState="false" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepMasterTemplate" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <cms:SelectMasterTemplate ID="selectMaster" runat="server" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepSiteStructure" runat="server" AllowReturn="False" StepType="Step"
                                EnableViewState="true">
                                <div class="GlobalWizardStepPanel" style="height: <%= PanelHeight %>px;">
                                    <cms:DefineSiteStructure ID="siteStructure" runat="server" />
                                </div>
                            </asp:WizardStep>
                            <asp:WizardStep ID="wzdStepFinished" runat="server" AllowReturn="False" StepType="Finish"
                                EnableViewState="true">
                                <div class="GlobalWizardStep" style="height: <%= PanelHeight %>px">
                                    <cms:NewSiteFinish ID="finishSite" runat="server" />
                                </div>
                            </asp:WizardStep>
                        </WizardSteps>
                    </asp:Wizard>
                </div>
            </td>
        </tr>
        <tr class="Bottom">
            <td class="Left">
                &nbsp;
            </td>
            <td class="Center">
                &nbsp;
            </td>
            <td class="Right">
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Panel>
<br />
<asp:Label ID="lblError" runat="server" CssClass="ErrorLabel" EnableViewState="false" />
<asp:Label ID="lblWarning" runat="server" CssClass="ErrorLabel" EnableViewState="false" />
<asp:Panel ID="pnlPermissions" runat="server" Visible="false" EnableViewState="false">
    <br />
    <asp:HyperLink ID="lnkPermissions" runat="server" />
</asp:Panel>
<asp:HiddenField ID="hdnState" runat="server" />
<asp:Literal ID="ltlScriptAfter" runat="server" EnableViewState="false" />
<cms:AsyncControl ID="ctrlAsync" runat="server" />
<cms:AsyncControl ID="ctrlImport" runat="server" />
