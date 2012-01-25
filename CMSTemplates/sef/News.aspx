<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="News.aspx.cs" Inherits="CMSTemplates_sef_News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">

    <cms:CMSBreadCrumbs runat="server" />

   <cms:CMSRepeater
   ID="CMSRepeater1" 
   runat="server" 
   ClassNames="cms.news" 
   TransformationName="cms.news.preview"
   SelectedItemTransformationName="cms.news.default"
   ItemSeparator="<hr />"></cms:CMSRepeater>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
</asp:Content>

