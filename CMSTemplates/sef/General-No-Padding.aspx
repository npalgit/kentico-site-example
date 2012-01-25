<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="General-No-Padding.aspx.cs" Inherits="CMSTemplates_sef_General_No_Padding" %>
<asp:Content ID="Content6" ContentPlaceHolderID="plcHead" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="topContent" Runat="Server">
   
<cms:CMSPagePlaceholder runat="server" ID="cmsPagePlaceHolder1">
    <LayoutTemplate>    
        <cms:CMSWebPartZone runat="server" ID="topArea"></cms:CMSWebPartZone>
    </LayoutTemplate>
</cms:CMSPagePlaceholder>

</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="rightColumn" Runat="Server">	
		<cms:CMSPagePlaceholder runat="server" ID="cmsPagePlaceHolder">
			<LayoutTemplate>
				<cms:CMSWebPartZone runat="server" ID="rightArea"></cms:CMSWebPartZone>
			</LayoutTemplate>
		</cms:CMSPagePlaceholder>	
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="bottomContent" Runat="Server">
<cms:CMSEditableRegion runat="server" ID="bottomText"  />
</asp:Content>

