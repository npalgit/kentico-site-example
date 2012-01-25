<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="Default_.aspx.cs" Inherits="CMSTemplates_sef_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" runat="Server">
    <cms:CMSPagePlaceholder ID="plcZone" runat="server">
        <LayoutTemplate>
            <cms:CMSWebPartZone ID="zoneMain" runat="server" />
            <cms:CMSWebPartZone ID="zoneCenter" runat="server" />
            <cms:CMSWebPartZone ID="zoneBottom" runat="server" />
        </LayoutTemplate>
    </cms:CMSPagePlaceholder>
</asp:Content>
