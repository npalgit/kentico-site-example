<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="publications.aspx.cs" Inherits="CMSTemplates_sef_publications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">

<div class="pad20">



<div class="data">
    
    <div class="search-box">
		<span class="srch-head">Search</span>
		
		<input type="text" id="title">
		
		<button id="searchPub" type="button" style="margin-right: 16px;">Search</button>
<span id="viewAll" style="cursor: pointer;" class="blue">(View All)</span>
	</div>
	
    <div class="list">
		<img src="/content/images/pub-title.png">

		<div class="items">
        

        <table>
               <cms:QueryRepeater
               ID="CMSRepeater1" 
               runat="server" 
               QueryName="custom.publ.selectAll" 
               TransformationName="custom.publ.Preview" 
               SelectedItemTransformationName="custom.publ.Default" 
               ItemSeparator=""></cms:QueryRepeater> 
        </table>

        
        


			

		</div>
	</div>
</div>



</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
</asp:Content>

