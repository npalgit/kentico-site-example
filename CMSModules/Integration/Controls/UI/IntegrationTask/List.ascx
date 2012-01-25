<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_Integration_Controls_UI_IntegrationTask_List"
    CodeFile="List.ascx.cs" %>
<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Namespace="CMS.UIControls.UniGridConfig" TagPrefix="ug" Assembly="CMS.UIControls" %>
<cms:CMSUpdatePanel ID="pnlUpdate" runat="server">
    <ContentTemplate>
        <cms:UniGrid runat="server" ID="gridElem" ObjectType="integration.tasklist" OrderBy="TaskID ASC"
            Columns="TaskID,TaskTitle,TaskTime,TaskType,SynchronizationErrorMessage,SynchronizationID,ConnectorDisplayName"
            IsLiveSite="false">
            <GridActions Parameters="SynchronizationID">
                <ug:Action Name="view" Caption="$General.View$" Icon="View.png" ExternalSourceName="view" />
                <ug:Action Name="run" Caption="$General.Synchronize$" Icon="Synchronize.png" CommandArgument="SynchronizationID" ExternalSourceName="run" />
                <ug:Action Name="delete" Caption="$General.Delete$" Icon="Delete.png" Confirmation="$General.ConfirmDelete$"
                    ModuleName="CMS.Integration" Permissions="modify" CommandArgument="SynchronizationID" />
            </GridActions>
            <GridColumns>
                <ug:Column Source="TaskTitle" Caption="$integration.tasktitle$" Wrap="false" Width="100%">
                    <Filter Type="text" />
                </ug:Column>
                <ug:Column Source="TaskType" Caption="$integration.tasktype$" Wrap="false">
                    <Filter Type="text" />
                </ug:Column>
                <ug:Column Source="TaskTime" Caption="$integration.tasktime$" Wrap="false" />
                <ug:Column Source="ConnectorDisplayName" Caption="$integration.connectorname$" Wrap="false" />
                <ug:Column Source="##ALL##" Caption="$general.result$" ExternalSourceName="result"
                    Wrap="false">
                    <Tooltip Source="SynchronizationErrorMessage" Encode="true" />
                </ug:Column>
            </GridColumns>
            <GridOptions DisplayFilter="true" />
        </cms:UniGrid>
    </ContentTemplate>
</cms:CMSUpdatePanel>
