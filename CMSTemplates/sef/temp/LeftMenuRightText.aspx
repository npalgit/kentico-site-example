<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="LeftMenuRightText.aspx.cs" Inherits="CMSTemplates_sef_LeftMenuRightText" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" runat="Server">
    <table width="100%">
        <tr valign="top">
            <td width="20%">
            <cms:CMSTreeMenu runat="server"
            Path="/{0}/%"
            MenuItemImageUrl="~/app_themes/sef/images/bullet.gif"
            MenuItemOpenImageUrl="~/app_themes/sef/images/bullet.gif" />
            </td>
            <td width="80%">
            <cms:CMSEditableRegion runat="server"  ID="edtableRegion"/>

            <asp:WebPartZone>
                <ZoneTemplate>
                    
                </ZoneTemplate>
            </asp:WebPartZone>
            
            
            </td>
        </tr>
    </table>
</asp:Content>
