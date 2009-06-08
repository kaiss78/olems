<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="AssignQuestionOwnership.aspx.cs"
    Inherits="OLEMS.SystemAdministration.AssignQuestionOwnership" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label></h3>
    <asp:Label ID="Msg" ForeColor="maroon" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
        SelectCommand="SELECT [UserId], [UserName] FROM [vUsersNameSurname] WHERE (([RoleName] = @RoleName) AND ([IsApproved] = @IsApproved))">
        <SelectParameters>
            <asp:Parameter DefaultValue="Question Developer" Name="RoleName" Type="String" />
            <asp:Parameter DefaultValue="False" Name="IsApproved" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
        SelectCommand="SELECT [UserId], [UserName] FROM [vUsersNameSurname] WHERE (([RoleName] = @RoleName) AND ([IsApproved] = @IsApproved))">
        <SelectParameters>
            <asp:Parameter DefaultValue="Question Developer" Name="RoleName" Type="String" />
            <asp:Parameter DefaultValue="True" Name="IsApproved" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table width="100%" cellpadding="3" border="0">
        <tr valign="top">
            <td>
                <asp:Label ID="LabelAssignFrom" runat="server" Text="<%$ Resources:AssignFrom %>"
                    AssociatedControlID="AssignFromListBox"></asp:Label>
            </td>
            <td>
                :
            </td>
            <td>
                <asp:ListBox ID="AssignFromListBox" runat="server" Rows="8" DataSourceID="SqlDataSource1"
                    DataTextField="UserName" DataValueField="UserId" />
            </td>
            <td>
                <asp:Label ID="LabelAssignTo" runat="server" Text="<%$ Resources:AssignTo %>" AssociatedControlID="AssignToListBox"></asp:Label>
            </td>
            <td>
                :
            </td>
            <td>
                <asp:ListBox ID="AssignToListBox" Rows="8" runat="server" DataSourceID="SqlDataSource2"
                    DataTextField="UserName" DataValueField="UserId" />
            </td>
            <td>
                <asp:Button Text="<%$ Resources:AssignQuestionButton %>" ID="AssignQuestionButton"
                    runat="server" OnClick="AssignQuestion_OnClick" />
            </td>
        </tr>
    </table>
</asp:Content>
