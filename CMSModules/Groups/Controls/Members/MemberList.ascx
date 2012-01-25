<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_Groups_Controls_Members_MemberList" CodeFile="MemberList.ascx.cs" %>
<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/Groups/Controls/Members/MemberFilter.ascx" TagName="MemberFilter"
    TagPrefix="cms" %>
<cms:MemberFilter runat="server" ID="filterMembers" />
<div style="padding-top: 10px">
</div>
<cms:UniGrid runat="server" ID="gridElem" OrderBy="UserName" GridName="~/CMSModules/Groups/Controls/Members/Member_List.xml" />
