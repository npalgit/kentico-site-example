<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="history.aspx.cs" Inherits="CMSTemplates_sef_history" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
        <div>
            <div class="timeline">
                <div class="link t1865-1877" data-rel="t1865">
                    <div class="text">
                        1865-1877</div>
                </div>
                <div class="link t1878-1895" data-rel="t1880">
                    <div class="text">
                        1878-1895</div>
                </div>
                <div class="link t1896-1915" data-rel="t1896">
                    <div class="text">
                        1896-1915</div>
                </div>
                <div class="link t1916-1931" data-rel="t1916">
                    <div class="text">
                        1916-1931</div>
                </div>
                <div class="link t1932-1944" data-rel="t1932">
                    <div class="text">
                        1932-1944</div>
                </div>
                <div class="link t1945-1953" data-rel="t1945">
                    <div class="text">
                        1945-1953</div>
                </div>
                <div class="link t1954-1972" data-rel="t1954">
                    <div class="text">
                        1954-1972</div>
                </div>
                <div class="link t1973-1982" data-rel="t1973">
                    <div class="text">
                        1973-1982</div>
                </div>
                <div class="link t1983-1993" data-rel="t1983">
                    <div class="text">
                        1983-1993</div>
                </div>
                <div class="link t1994-now" data-rel="t1994">
                    <div class="text">
                        1994-now</div>
                </div>
            </div>
            <div class="timeline-detail">
                <div class="timeline-item">
                    <cms:QueryRepeater
                       ID="CMSRepeater1" 
                       runat="server" 
                       QueryName="custom.history.selectAll" 
                       TransformationName="custom.history.Preview" 
                       SelectedItemTransformationName="custom.history.Default" 
                       ItemSeparator="<br /><br /><br />"></cms:QueryRepeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
