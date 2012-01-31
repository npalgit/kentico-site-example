<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="interns.aspx.cs" Inherits="CMSTemplates_sef_interns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">


<div class="pad20">

<cms:QueryRepeater
               ID="CMSRepeater1" 
               runat="server" 
               QueryName="custom.intern.selectAll" 
               TransformationName="custom.intern.Preview" 
               SelectedItemTransformationName="custom.intern.Default" 
               ItemSeparator="<div style='clear:both;' ></div><hr class='margin' />"></cms:QueryRepeater> 

</div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
</asp:Content>

