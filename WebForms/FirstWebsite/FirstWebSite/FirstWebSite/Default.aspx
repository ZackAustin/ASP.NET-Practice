<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Default.aspx.cs" 
    Inherits="FirstWebSite.Default" %>
<%@ Reference Control="~/UserInfoBoxControl.ascx" %>
<%@ Register TagPrefix="My" TagName="EventUserControl"
    Src="~/EventUserControl.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
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
        </div>
    </form>
</body>
</html>

