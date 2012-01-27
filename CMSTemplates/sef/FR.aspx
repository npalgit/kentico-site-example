<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true" CodeFile="FR.aspx.cs" Inherits="CMSTemplates_sef_FR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" Runat="Server">
 <div class="pad20">
        <div class="staff-wrap">
            <h2>
                Financial Reports</h2>
            <div class="staff-item-list">

            <cms:QueryRepeater
               ID="CMSRepeater1" 
               runat="server" 
               QueryName="custom.fr.selectAll" 
               TransformationName="custom.fr.Preview" 
               SelectedItemTransformationName="custom.fr.Default" 
               ItemSeparator="<br /><br />"></cms:QueryRepeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" Runat="Server">
</asp:Content>

