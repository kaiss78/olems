<%@ Page Title="" Language="C#" MasterPageFile="~/OLEMS.Master" CodeBehind="Login.aspx.cs"
    Inherits="OLEMS.UserManagement.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Login ID="LoginOLEMS" runat="server" BackColor="#FFFBD6" BorderColor="#FFDFAD"
        BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"
        Font-Size="0.8em" ForeColor="#333333" TextLayout="TextOnTop" DisplayRememberMe="False"
        FailureText="<%$ Resources:Errors, unsuccessfulLoginAttempt %>" DestinationPageUrl="~/UserManagement/Springboard.aspx">
        <TextBoxStyle Font-Size="0.8em" />
        <LoginButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
        <TitleTextStyle BackColor="#990000" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
    </asp:Login>
</asp:Content>
