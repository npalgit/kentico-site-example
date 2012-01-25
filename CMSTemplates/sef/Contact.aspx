<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/sef/sef.master" AutoEventWireup="true"
    CodeFile="Contact.aspx.cs" Inherits="CMSTemplates_sef_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcStyle" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcHead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="topContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightColumn" runat="Server">
    <div class="pad20">
        <h2>
            Contact Information</h2>
        <img src="/content/images/contact.png">
        <br>
        <br>
        <br>
        <h2>
            Submit a Query</h2>
        <div class="form-wrap">
            
            <div class="input-field">
                <label>
                    Title/Prefix</label>
                <div class="ctrl">
                    <input type="text" name="title" id="title" class="validate[required]">
                </div>
            </div>
            <div class="input-field">
                <label>
                    First Name</label>
                <div class="ctrl">
                    <input type="text" name="fname" id="fname" class="validate[required]">
                </div>
            </div>
            <div class="input-field">
                <label>
                    Last Name</label>
                <div class="ctrl">
                    <input type="text" name="lname" id="lname" class="validate[required]">
                </div>
            </div>
            <div class="input-field">
                <label>
                    Email Address</label>
                <div class="ctrl">
                    <input type="text" name="email" id="email" class="validate[required]">
                </div>
            </div>
            <div class="input-field">
                <label>
                    Phone</label>
                <div class="ctrl">
                    <input type="text" name="phone" id="phone" class="validate[required]">
                </div>
            </div>
            <div class="input-field">
                <label>
                    What is your inquiry</label>
                <div class="ctrl">
                    <textarea type="text" name="inquiry" id="inquiry" class="validate[required]"></textarea>
                </div>
            </div>

<div class="input-field">
                <label>          </label>
                <div class="ctrl">
                    <button id="btnContact" type="button">SEND</button>
                </div>
            </div>
            
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="bottomContent" runat="Server">
</asp:Content>
