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
    <title>Hello, AJAX world!</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="MainScriptManager" runat="server" 
            EnableHistory="true" 
            OnNavigate="MainScriptManager_Navigate" 
            EnableSecureHistoryState="false" />
        <div id="div_CacheDateStamps">
            Cached datestamp:<br />
            <%= DateTime.Now.ToString() %> <br />
            Fresh datestamp:<br />
            <asp:Substitution runat="server" ID="UnCachedArea"
                methodName="GetFreshDateTime" />
        </div>

        <div id="div_HelloWorld" runat="server">
            <br />  <br />
            <asp:Label runat="server" id="HelloWorldLabel"></asp:Label>
            <br />  <br />
            <asp:TextBox runat="server" ID="TextInput" />
            <asp:Button runat="server" ID="GreetButton" Text="Say Hello!" OnClick="GreetButton_Click" />
            <asp:DropDownList runat="server" ID="GreetList" AutoPostBack="true" OnSelectedIndexChanged="GreetList_SelectedIndexChanged">
                <asp:ListItem Value="No one">No one</asp:ListItem>
                <asp:ListItem Value="World">World</asp:ListItem>
                <asp:ListItem Value="Universe">Universe</asp:ListItem>
            </asp:DropDownList>
            <br />  <br />
        </div>

        <div id="div_HelloAJAXWorld" runat="server">
            <br />  <br />
            <asp:UpdatePanel ID="pnlHelloWorld" runat="server">
                <ContentTemplate>
                    <asp:Label runat="server" ID="lblHelloAJAXWorld" 
                        Text="Click the button!" />
                    <br />  <br />
                    <asp:Button runat="server" ID="btnHelloWorld"
                        onclick="btnHelloWorld_Click"
                        Text="Update label" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />  <br />
        </div>

        <div id="div_UpdatePanel" runat="server">
            <br />  <br />
            <asp:UpdatePanel runat="server" id="UpdatePanel" updatemode="Conditional">
            <Triggers>
                <asp:AsyncPostBackTrigger controlid="UpdateButton2" eventname="Click" />
            </Triggers>
                <ContentTemplate>
                    <asp:Label runat="server" id="DateTimeLabel1" />
                    <asp:Button runat="server" id="UpdateButton1" onclick="UpdateButton_Click" text="Update" />               
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server" id="UpdatePanel1" updatemode="Conditional">           
                <ContentTemplate>
                    <asp:Label runat="server" id="DateTimeLabel2" />
                    <asp:Button runat="server" id="UpdateButton2" onclick="UpdateButton_Click" text="Update" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />  <br />
        </div>

        <div id="div_UpdatePanelHistory" runat="server">
            <br />  <br />
            <asp:UpdatePanel runat="server" ID="pnlColorSelect">
            <ContentTemplate>
                <asp:DropDownList runat="server" ID="ddlColor"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlColor_SelectedIndexChanged">
                    <asp:ListItem Value="Red">Red</asp:ListItem>
                    <asp:ListItem Value="Blue">Blue</asp:ListItem>
                    <asp:ListItem Value="Green">Green</asp:ListItem>
                </asp:DropDownList>
                <br /><br />
                Selected color: <asp:Label runat="server" ID="lblSelectedColor" />
            </ContentTemplate>
            </asp:UpdatePanel>
            <br />  <br />
        </div>

        <div id="div_UpdateProgress" runat="server">
            <br />  <br />
            <asp:UpdateProgress runat="server" id="PageUpdateProgress" 
                DynamicLayout="false" AssociatedUpdatePanelID="Panel" DisplayAfter="500" >
            <ProgressTemplate>
                Loading...
            </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel runat="server" id="Panel">
                <ContentTemplate>
                    <asp:Button runat="server" id="UpdateProgressButton"
                        onclick="UpdateProgressButton_Click" text="Update" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />  <br />
        </div>

        <div id="div_Timers" runat="server">
            <br />  <br />
            <asp:Timer runat="server" id="UpdateTimer" interval="5000" ontick="UpdateTimer_Tick" />
            <asp:UpdatePanel runat="server" id="TimedPanel" updatemode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger controlid="UpdateTimer" eventname="Tick" />
                </Triggers>
                <ContentTemplate>
                    <asp:Label runat="server" id="DateStampLabel" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />  <br />
        </div>

        <div id="div_EventUserControl">
            <br />  <br />
            <asp:PlaceHolder runat="server" ID="phUserInfoBox" />
            <My:EventUserControl runat="server" ID="MyEventUserControl"  
                OnPageTitleUpdated="MyEventUserControl_PageTitleUpdated" />
            <br />  <br />
        </div>

        <div id="div_Validators">
            Your name: <br />
            <asp:TextBox runat="server" ID="txtName" />
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" 
                ControlToValidate="txtName" 
                ErrorMessage="Please enter your name!" 
                EnableClientScript="false" />
            <br />  <br />
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
            <br />  <br />

            Date:<br />
            <asp:TextBox runat="server" ID="txtDate" />
            <asp:RangeValidator runat="server" ID="rngDate"
                controltovalidate="txtDate" Type="Date"
                minimumvalue="01-01-2006" MaximumValue="12-31-2006"
                errormessage="Enter a valid date for 2006." />
            <br />  <br />

            4 digit number: <br />
            <asp:TextBox runat="server" ID="txtNumberVal" />
            <asp:RegularExpressionValidator runat="server" ID="regNumber"
                controltovalidate="txtNumberVal"
                validationexpression="^[0-9]{4}$"
                errormessage="Enter a 4 digit number." />
            <br />  <br />

            Custom text: <br />
            <asp:TextBox runat="server" ID="txtCustom" />
            <asp:CustomValidator runat="server" ID="lenCustom"
                controltovalidate="txtCustom"
                onservervalidate="lenCustom_ServerValidate" 
                ValidateEmptyText="true"
                errormessage="Text must be 8 characters long."  />
            <br />  <br />
        </div>

        <div id="div_Sessions" runat="server">
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
            <br />  <br />
        </div>

        <div id="div_ViewStates" runat="server">
            <asp:TextBox runat="server" ID="NameField" />
            <asp:Button runat="server" ID="SubmitForm" OnClick="SubmitForm_Click"
                text="Submits & sets name "/>
            <asp:Button runat="server" ID="RefreshPage" Text="Just a postback" />
            <br />  <br />
            Name retrieved from ViewState: <asp:Label runat="server"
                id="NameLabel" />
        </div>

        <div id="div_Email" runat="server">
            <br /> <br />
            <asp:Button runat="server" ID="MailButton"
                OnClick="MailButton_Click"
                text="Send a test email." />
        </div>

        <div id="div_Files" runat="server">
            <br />  <br />
            <asp:FileUpload ID="FileUploadControl" runat="server" />
            <asp:Button runat="server" ID="UploadButton" Text="Upload"
                onclick="UploadButton_Click" />
            <br />  <br />
            <asp:Label runat="server" ID="StatusLabel" Text="Upload status:" />
        </div>

        <div id="div_Localization" runat="server">
            <br />  <br />
            <asp:Label runat="server" ID="lblHelloWorld"
                Text="Hello, World!"
                meta:resourcekey="lblHelloWorld"
                Font-Names="Verdana" ForeColor="Blue"/>
            <br />  <br />
        </div>

        <% Response.Write("Your currnet culture is: "
                 + System.Globalization.CultureInfo.CurrentCulture.DisplayName);%>
        <br />  <br />
        <% Response.Write("Current date, in a culture specific format: "
                 + DateTime.Now
                 .ToString(System.Globalization.CultureInfo.GetCultureInfo("de-DE")
                 .DateTimeFormat)); %>

        <div id="div_ExplicitResources" runat="server">
            <br />  <br />
            <asp:Label runat="server" ID="lblHelloWorld2"
                Text="<%$ Resources:lblHelloWorld.Text %>"
                Font-Names="Verdana"
                ForeColor="<%$ Resources:lblHelloWorld.ForeColor %>" />
            <br />  <br />

            <asp:Label runat="server" ID="lblHelloWorldGlobal" />
            <br />  <br />
        </div>

        <div id="div_DatabaseAccess" runat="server">
            <asp:DropDownList runat="server" ID="ddlUsers" DataValueField="id"
                datatextfield="name" />
            <br />  <br />
        </div>
    </form>
</body>
</html>
