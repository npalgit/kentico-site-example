<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="NewsPage.aspx.cs" Inherits="CMSTemplates_sef_NewsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" Runat="Server">
    <cms:CMSBreadCrumbs runat="server" />
    <h1>News</h1>
    <cms:CMSRepeater runat="server" ID="repeater" 
    ClassNames="cms.news"
    TransformationName="cms.news.preview"
    SelectedItemTransformationName="cms.news.default"
    ItemSeparator="<hr />" />

</asp:Content>

