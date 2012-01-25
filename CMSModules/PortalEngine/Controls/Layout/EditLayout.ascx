<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_PortalEngine_Controls_Layout_EditLayout"
    CodeFile="EditLayout.ascx.cs" %>
<%@ Register Src="~/CMSAdminControls/UI/Macros/MacroEditor.ascx" TagName="MacroEditor"
    TagPrefix="cms" %>
<asp:Panel runat="server" ID="pnlLayoutHeader" CssClass="PagePlaceholderLayoutHeader">
    <asp:PlaceHolder runat="server" ID="plcActions">
        <div class="PlaceholderMenu">
            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:LinkButton runat="server" ID="btnSaveLayout" EnableViewState="false" CssClass="MenuItemEdit"
                            OnClick="btnSaveLayout_Click" OnClientClick="layoutChanged = true;">
                            <asp:Image runat="server" ID="imgSave" />
                            <cms:LocalizedLiteral runat="server" ID="ltlSave" ResourceString="General.Save" />
                        </asp:LinkButton>
                    </td>
                    <asp:PlaceHolder runat="server" ID="plcCheckOut" Visible="false">
                        <td>
                            <asp:LinkButton runat="server" ID="btnCheckOut" EnableViewState="false" CssClass="MenuItemEdit"
                                OnClick="btnCheckOut_Click" OnClientClick="layoutChanged = true;">
                                <asp:Image runat="server" ID="imgCheckOut" />
                                <cms:LocalizedLiteral runat="server" ID="ltlCheckOut" ResourceString="PageLayout.CheckOut" />
                            </asp:LinkButton>
                        </td>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" ID="plcCheckIn" Visible="false">
                        <td>
                            <asp:LinkButton runat="server" ID="btnCheckIn" EnableViewState="false" CssClass="MenuItemEdit"
                                OnClick="btnCheckIn_Click" OnClientClick="layoutChanged = true;">
                                <asp:Image runat="server" ID="imgCheckIn" />
                                <cms:LocalizedLiteral runat="server" ID="ltlCheckIn" ResourceString="General.CheckInFromFile" />
                            </asp:LinkButton>
                        </td>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" ID="plcUndoCheckOut" Visible="false">
                        <td>
                            <asp:LinkButton runat="server" ID="btnUndoCheckOut" EnableViewState="false" CssClass="MenuItemEdit"
                                OnClick="btnUndoCheckOut_Click" OnClientClick="layoutChanged = true;">
                                <asp:Image runat="server" ID="imgUndoCheckOut" />
                                <cms:LocalizedLiteral runat="server" ID="ltlUndoCheckOut" ResourceString="PageLayout.DiscardCheckOut" />
                            </asp:LinkButton>
                        </td>
                    </asp:PlaceHolder>
                    <td style="width: 100%;">
                    </td>
                </tr>
            </table>
        </div>
        <asp:Panel runat="server" ID="pnlCheckOutInfo" CssClass="PlaceholderHeaderLine">
            <asp:Label runat="server" ID="lblCheckOutInfo" EnableViewState="false" CssClass="PagePlaceholderCheckOutInfoLabel" />
        </asp:Panel>
    </asp:PlaceHolder>
    <div class="PlaceholderHeaderLine">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td class="FieldLabel" style="vertical-align: middle">
                    <asp:Label ID="lblType" runat="server" EnableViewState="false" />&nbsp;
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="drpType" AutoPostBack="true" />
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div class="PlaceholderInfoLine">
        <asp:PlaceHolder runat="server" ID="plcHint">
            <asp:Label runat="server" ID="lblLayoutInfo" CssClass="InfoLabel" EnableViewState="false" />
            <asp:Label runat="server" ID="lblLayoutError" CssClass="ErrorLabel" EnableViewState="false"
                Visible="false" />
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcDirectives" Visible="false">
            <asp:Label runat="server" ID="ltlDirectives" EnableViewState="false" CssClass="LayoutDirectives" /><br />
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcVirtualInfo" Visible="false">
            <br />
            <asp:Label runat="server" ID="lblVirtualInfo" CssClass="ErrorLabel" EnableViewState="false" />
        </asp:PlaceHolder>
    </div>
</asp:Panel>
<cms:MacroEditor runat="server" ID="txtLayout" Height="500px" Width="99%" />
