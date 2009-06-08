<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="DeactivateUser.aspx.cs"
    Inherits="OLEMS.SystemAdministration.DeactivateUser" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>" /></h3>
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" /><br />
    <table border="0" cellspacing="4">
        <tr>
            <td valign="top">
                <asp:ListBox ID="UsersListBox" DataTextField="Username" Rows="8" AutoPostBack="true"
                    runat="server" />
            </td>
            <td valign="top">
                <table border="0" cellpadding="2" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="Email" Text="<%$ Resources:Email %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="EmailLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="IsOnline" Text="<%$ Resources:IsOnline %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="IsOnlineLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="LastLoginDate" Text="<%$ Resources:LastLoginDate %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="LastLoginDateLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="CreationDate" Text="<%$ Resources:CreationDate %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="CreationDateLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="LastActivityDate" Text="<%$ Resources:LastActivityDate %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="LastActivityDateLabel" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="CanLogin" Text="<%$ Resources:CanLogin %>" />
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="CanLoginLabel" />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:Button ID="DeactivateUserButton" runat="server" Text="<%$ Resources:DeactivateUserButton %>"
                    OnClick="DeactivateUserButton_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
