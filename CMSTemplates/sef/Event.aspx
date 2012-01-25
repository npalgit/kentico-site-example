<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="Event.aspx.cs" Inherits="CMSTemplates_sef_Event" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
     
        <div>
            <cms:CMSRepeater
           ID="CMSRepeater1" 
           runat="server" 
           ClassNames="CMS.Event" 
           TransformationName="CMS.Event.Preview"
           SelectedItemTransformationName="CMS.Event.Default"
           ItemSeparator="<hr />"></cms:CMSRepeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
