<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="StaffMember.aspx.cs" Inherits="CMSTemplates_sef_StaffMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
        <div class="staff-wrap">
            <h2>
                Staff</h2>
            <div class="staff-item-list">

            <cms:QueryRepeater
               ID="CMSRepeater1" 
               runat="server" 
               QueryName="custom.staff.selectAll" 
               TransformationName="custom.staff.Preview" 
               SelectedItemTransformationName="custom.staff.Default" 
               ItemSeparator="<hr />"></cms:QueryRepeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
