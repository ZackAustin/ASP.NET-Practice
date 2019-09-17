<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" 
    Inherits="FirstWebSite.Default" UICulture="fr" Culture="en-US" %>
<%@ Reference Control="~/UserInfoBoxControl.ascx" %>
<%@ Register TagPrefix="My" TagName="EventUserControl"
    Src="~/EventUserControl.ascx" %>
<%@ OutputCache Duration="2" VaryByParam="None" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>CultureInfo Demo</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div0">
            Cached datestamp:<br />
            <%= DateTime.Now.ToString() %> <br />
            Fresh datestamp:<br />
            <asp:Substitution runat="server" ID="UnCachedArea"
                methodName="GetFreshDateTime" />
        </div>
        <div id="div1">
            <asp:Label runat="server" id="HelloWorldLabel"></asp:Label>
            <br /><br />
            <asp:TextBox runat="server" ID="TextInput" />
            <asp:Button runat="server" ID="GreetButton" Text="Say Hello!" OnClick="GreetButton_Click" />
            <asp:DropDownList runat="server" ID="GreetList" AutoPostBack="true" OnSelectedIndexChanged="GreetList_SelectedIndexChanged">
                <asp:ListItem Value="No one">No one</asp:ListItem>
                <asp:ListItem Value="World">World</asp:ListItem>
                <asp:ListItem Value="Universe">Universe</asp:ListItem>
            </asp:DropDownList>
            <br /><br />

            <asp:PlaceHolder runat="server" ID="phUserInfoBox" />

            <My:EventUserControl runat="server" ID="MyEventUserControl"  
                OnPageTitleUpdated="MyEventUserControl_PageTitleUpdated" />
            <br /><br />
        </div>
        <div id="div2">
            Your name: <br />
            <asp:TextBox runat="server" ID="txtName" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" 
                ControlToValidate="txtName" 
                ErrorMessage="Please enter your name!" 
                EnableClientScript="false" />
            <br /><br />
            <asp:Button runat="server" ID="btnSubmitForm" Text="Ok" 
                OnClick="btnSubmitForm_Click"/>
            <br />
            <p></p>

            Small number: <br />
            <asp:TextBox runat="server" ID="txtSmallNumber" /><br /><br />
            Big number: <br />
            <asp:TextBox runat="server" ID="txtBigNumber" /> <br />
            <br />
            <asp:CompareValidator runat="server" ID="cmpNumbers"
                controltovalidate="txtSmallNumber" ControlToCompare="txtBigNumber"
                operator="LessThan" Type="Integer"
                errorMessage="First number should be smaller than the second." />
            <br /><br />

            Date:<br />
            <asp:TextBox runat="server" ID="txtDate" />
            <asp:RangeValidator runat="server" ID="rngDate"
                controltovalidate="txtDate" Type="Date"
                minimumvalue="01-01-2006" MaximumValue="12-31-2006"
                errormessage="Enter a valid date for 2006." />
            <br /><br />

            4 digit number: <br />
            <asp:TextBox runat="server" ID="txtNumberVal" />
            <asp:RegularExpressionValidator runat="server" ID="regNumber"
                controltovalidate="txtNumberVal"
                validationexpression="^[0-9]{4}$"
                errormessage="Enter a 4 digit number." />
            <br /><br />

            Custom text: <br />
            <asp:TextBox runat="server" ID="txtCustom" />
            <asp:CustomValidator runat="server" ID="lenCustom"
                controltovalidate="txtCustom"
                onservervalidate="lenCustom_ServerValidate" 
                ValidateEmptyText="true"
                errormessage="Text must be 8 characters long."  />
            <br /><br />
        </div>
        <div id="div3" runat="server">
            <asp:DropDownList runat="server" ID="ColorSelector"
                AutoPostBack="true" 
                OnSelectedIndexChanged="ColorSelector_SelectedIndexChanged">
                    <asp:ListItem Value="White" Selected="True">
                        Select Color...
                    </asp:ListItem>
                    <asp:ListItem Value="Red">Red</asp:ListItem>
                    <asp:ListItem Value="Green">Green</asp:ListItem>
                    <asp:ListItem Value="Blue">Blue</asp:ListItem>
            </asp:DropDownList>
            <br /><br />
        </div>

        <div id="div4" runat="server">
            <asp:TextBox runat="server" ID="NameField" />
            <asp:Button runat="server" ID="SubmitForm" OnClick="SubmitForm_Click"
                text="Submits & sets name "/>
            <asp:Button runat="server" ID="RefreshPage" Text="Just a postback" />
            <br /><br />
            Name retrieved from ViewState: <asp:Label runat="server"
                id="NameLabel" />
        </div>

        <div id="div5" runat="server">
            <br /> <br />
            <asp:Button runat="server" ID="MailButton"
                OnClick="MailButton_Click"
                text="Send a test email." />
        </div>

        <div id="div6" runat="server">
            <br />  <br />
            <asp:FileUpload ID="FileUploadControl" runat="server" />
            <asp:Button runat="server" ID="UploadButton" Text="Upload"
                onclick="UploadButton_Click" />
            <br />  <br />
            <asp:Label runat="server" ID="StatusLabel" Text="Upload status:" />
        </div>

        <div id="div7" runat="server">
            <br />  <br />
            <asp:Label runat="server" ID="lblHelloWorld"
                Text="Hello, World!"
                meta:resourcekey="lblHelloWorld" />
            <br />  <br />
        </div>

        <% Response.Write("Your currnet culture is: "
                 + System.Globalization.CultureInfo.CurrentCulture.DisplayName);%>
        <br />  <br />
        <% Response.Write("Current date, in a culture specific format: "
                 + DateTime.Now
                 .ToString(System.Globalization.CultureInfo.GetCultureInfo("de-DE")
                 .DateTimeFormat)); %>

    </form>
</body>
</html>
