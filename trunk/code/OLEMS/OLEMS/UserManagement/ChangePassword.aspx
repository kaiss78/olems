<%@ Page Title="" Language="C#" MasterPageFile="~/OLEMS.Master" CodeBehind="ChangePassword.aspx.cs"
    Inherits="OLEMS.UserManagement.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ChangePassword ID="ChangePasswordOLEMS" runat="server" BackColor="#FFFBD6" BorderColor="#FFDFAD"
        BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"
        Font-Size="0.8em" NewPasswordRegularExpressionErrorMessage="<%$ Resources:Errors, newPasswordRegularExpressionErrorMessage %>"
        PasswordHintText="<%$ Resources:Errors, passwordHintText %>" NewPasswordRegularExpression=".{4,8}"
        CancelDestinationPageUrl="~/UserManagement/Springboard.aspx" ContinueDestinationPageUrl="~/UserManagement/Springboard.aspx">
        <CancelButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
        <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
        <ContinueButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
        <ChangePasswordButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
        <TitleTextStyle BackColor="#990000" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
        <TextBoxStyle Font-Size="0.8em" />
        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
    </asp:ChangePassword>
</asp:Content>
