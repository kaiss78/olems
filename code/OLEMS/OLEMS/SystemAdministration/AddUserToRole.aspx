<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="AddUserToRole.aspx.cs"
    Inherits="OLEMS.SystemAdministration.AddUserToRole" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label></h3>
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" /><br />
    <table cellpadding="3" border="0">
        <tr>
            <td valign="top">
                <asp:Label ID="LabelRoles" runat="server" Text="<%$ Resources:LabelRoles %>" AssociatedControlID="RolesListBox"></asp:Label>
            </td>
            <td valign="top">
                <asp:ListBox ID="RolesListBox" runat="server" Rows="8" />
            </td>
            <td valign="top">
                <asp:Label ID="LabelUsers" runat="server" Text="<%$ Resources:LabelUsers %>" AssociatedControlID="UsersListBox"></asp:Label>
            </td>
            <td valign="top">
                <asp:ListBox ID="UsersListBox" DataTextField="Username" Rows="8" runat="server" />
            </td>
            <td valign="top">
                <asp:Button Text="Add User to Role" ID="AddUserButton" runat="server" OnClick="AddUser_OnClick" />
            </td>
        </tr>
    </table>
</asp:Content>
