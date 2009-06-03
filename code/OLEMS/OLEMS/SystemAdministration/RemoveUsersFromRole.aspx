<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="RemoveUsersFromRole.aspx.cs"
    Inherits="OLEMS.SystemAdministration.RemoveUsersFromRole" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Role Membership</h3>
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" /><br />
    <table cellpadding="3" border="0">
        <tr>
            <td valign="top">
                Roles:
            </td>
            <td valign="top">
                <asp:ListBox ID="RolesListBox" AutoPostBack="true" OnSelectedIndexChanged="RolesListBox_OnSelectedIndexChanged"
                    runat="server" Rows="8" />
            </td>
            <td valign="top">
                Users:
            </td>
            <td valign="top">
                <asp:ListBox ID="UsersListBox" Rows="8" SelectionMode="Multiple" runat="server" />
            </td>
            <td valign="top">
                <asp:Button Text="Remove User(s) from Role" ID="RemoveUsersButton" runat="server"
                    OnClick="RemoveUsers_OnClick" />
            </td>
        </tr>
    </table>
</asp:Content>
