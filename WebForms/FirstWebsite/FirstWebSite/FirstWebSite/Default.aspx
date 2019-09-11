<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Default.aspx.cs" Inherits="FirstWebSite.Default" %>
<%@ Reference Control="~/UserInfoBoxControl.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
        </div>
    </form>
</body>
</html>



