<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="RemoveUsersFromRole.aspx.cs"
    Inherits="OLEMS.SystemAdministration.RemoveUsersFromRole" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label></h3>
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" /><br />
    <table cellpadding="3" border="0">
        <tr valign="top">
            <td>
                <asp:Label ID="LabelRoles" runat="server" Text="<%$ Resources:LabelRoles %>" AssociatedControlID="RolesListBox"></asp:Label>
            </td>
            <td>
                <asp:ListBox ID="RolesListBox" AutoPostBack="true" OnSelectedIndexChanged="RolesListBox_OnSelectedIndexChanged"
                    runat="server" Rows="8" />
            </td>
            <td>
                <asp:Label ID="LabelUsers" runat="server" Text="<%$ Resources:LabelUsers %>" AssociatedControlID="UsersListBox"></asp:Label>
            </td>
            <td>
                <asp:ListBox ID="UsersListBox" Rows="8" SelectionMode="Multiple" runat="server" />
            </td>
            <td>
                <asp:Button Text="<%$ Resources:RemoveUsersButton %>" ID="RemoveUsersButton" runat="server"
                    OnClick="RemoveUsers_OnClick" />
            </td>
        </tr>
    </table>
</asp:Content>
