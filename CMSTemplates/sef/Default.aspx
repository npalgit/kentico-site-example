<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="CMSTemplates_sef_Default" %>

<asp:Content runat="server" ID="headContent" ContentPlaceHolderID="plcHead">
</asp:Content>
<asp:Content ID="topContent" ContentPlaceHolderID="topContent" runat="Server">
    <div class="banner">
        <div class="link left" data-index="1">
        </div>
        <div class="link mid" data-index="2">
        </div>
        <div class="link right" data-index="3">
        </div>
    </div>
</asp:Content>
<asp:Content ID="rightColumn" ContentPlaceHolderID="rightColumn" runat="Server">
    <img src="/content/images/home-bottom-bann.png" class="home-bottom-bann" href="/Hidden-Pages/A-Message-from-the-President.aspx">
    <div class="clear">
    </div>
    <div class="subCols">
        <%--Left sub-column--%>
        <div class="subLeft">
            <p class="img-para">
                <img src="/content/images/home-girl-pic.png">
                Since 2004, the Southern Education Leadership Initiative has provided Southern college
                students internships in nonprofits and foundation working to eradicate education
                inequities throughout the South. The program began in recognition of the 50th anniversary
                of the United States. Supreme Court decision, Brown v. Board of Education, which
                marked the end of legal segregation of America's schools.
                <br>
                <br>
                To learn more about the Initiative, who better to hear from about the program than
                our Intern alumni!
                <br>
                <br>
                <button>
                    Find out more</button>
            </p>
        </div>
        <%--Right sub-column--%>
        <div class="gray-column subRight">
            <div class="gray-block">
                <h2>
                    Connect with SEF
                </h2>
                <p>
                    Duis autem vel eum iriure dolor in hendrerit in vulputate velit:
                </p>
                <div class="social-links">
                    <a href="https://www.facebook.com/southerneducationfoundation"></a>
                    <a href="http://twitter.com/southernedfound"></a>
                    <a href="http://www.youtube.com/watch?v=mb1SpaMoYQ0" target="_blank"></a>
                </div>
            </div>
            <div class="padded">
                <h2>
                    Support SEF's Work
                </h2>
                <p>
                    Nam liber tempor cum soluta nobis eleifend option congue nihil perdiet doming id
                    quod mazim placerat facer possim assum:
                </p>
                <br>
                <button class="green">
                    Click Here To Donate</button>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="bottomContent" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
