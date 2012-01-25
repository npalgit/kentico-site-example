<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="GeneralPageTemplate.aspx.cs" Inherits="CMSTemplates_sef_GeneralPageTemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="topContent" Runat="Server">
   
<cms:CMSPagePlaceholder runat="server" ID="cmsPagePlaceHolder1">
    <LayoutTemplate>    
        <cms:CMSWebPartZone runat="server" ID="topArea"></cms:CMSWebPartZone>
    </LayoutTemplate>
</cms:CMSPagePlaceholder>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">
	<div class="pad20">
		<cms:CMSPagePlaceholder runat="server" ID="cmsPagePlaceHolder">
			<LayoutTemplate>
				<cms:CMSWebPartZone runat="server" ID="rightArea"></cms:CMSWebPartZone>
			</LayoutTemplate>
		</cms:CMSPagePlaceholder>
	</div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
<cms:CMSEditableRegion runat="server" ID="bottomText"  />
</asp:Content>

