<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_MediaLibrary_FormControls_LiveSelectors_InsertImageOrMedia_NewMediaFolder"
    Theme="Default" MasterPageFile="~/CMSMasterPages/LiveSite/Dialogs/ModalSimplePage.master" CodeFile="NewMediaFolder.aspx.cs" %>

<%@ Register Src="~/CMSModules/MediaLibrary/Controls/MediaLibrary/FolderActions/EditFolder.ascx"
    TagName="NewFolder" TagPrefix="cms" %>
<asp:Content ID="folderEditContent" runat="server" ContentPlaceHolderID="plcContent">
    <ajaxToolkit:ToolkitScriptManager ID="scriptManager" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <div class="PageContent">
        <div class="MediaLibrary FolderEdit">
            <cms:NewFolder ID="createFolder" runat="server" Action="new" CheckAdvancedPermissions="true" />
        </div>
    </div>
    <asp:Literal ID="ltlScript" runat="server"></asp:Literal>

    <script type="text/javascript" language="javascript">
        //<![CDATA[
        if (typeof (FocusFolderName) != 'undefined') {
            FocusFolderName();
        }
        //]]>
    </script>

</asp:Content>
