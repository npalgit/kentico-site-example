<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_REST_FormControls_SelectRESTServiceLevel"
    CodeFile="SelectRESTServiceLevel.ascx.cs" %>
<cms:LocalizedRadioButton runat="server" ID="radObjects" GroupName="Level" ResourceString="rest.enableobjectsonly" />
<cms:LocalizedRadioButton runat="server" ID="radDocuments" GroupName="Level" ResourceString="rest.enabledocumentsonly" />
<cms:LocalizedRadioButton runat="server" ID="radBoth" GroupName="Level" ResourceString="rest.enableboth" />
