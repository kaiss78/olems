<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="StudentList.aspx.cs"
    Inherits="OLEMS.Reports.StudentList" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label>
    </h3>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1"
                    DataTextField="name" DataValueField="id" RepeatColumns="4" RepeatDirection="Horizontal">
                </asp:CheckBoxList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [id], [name] FROM [Section] ORDER BY [name]"></asp:SqlDataSource>
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatColumns="4" RepeatDirection="Horizontal">
                </asp:CheckBoxList>
            </td>
            <td>
                <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
                <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                    Width="100%">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td valign="top">
                &nbsp;
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/MSExcel.jpg"
                    OnClick="ImageButton1_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
