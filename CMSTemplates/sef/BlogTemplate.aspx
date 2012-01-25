<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="BlogTemplate.aspx.cs" Inherits="CMSTemplates_sef_BlogTemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">
<div class="pad20">
<%--<cms:CMSBreadCrumbs ID="CMSBreadCrumbs1" runat="server" />--%>

<%--<hr />--%>


   <cms:CMSRepeater
   ID="CMSRepeater1" 
   runat="server" 
   ClassNames="CMS.BlogPost" 
   TransformationName="CMS.BlogPost.Preview"
   SelectedItemTransformationName="CMS.BlogPost.Single"
   ItemSeparator="<hr />"></cms:CMSRepeater>
</div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
</asp:Content>

