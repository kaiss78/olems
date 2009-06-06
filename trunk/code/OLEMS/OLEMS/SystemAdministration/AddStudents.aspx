<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="AddStudents.aspx.cs"
    Inherits="OLEMS.SystemAdministration.AddStudents" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label>
    </h3>
    <asp:FileUpload ID="FileUpload1" runat="server" />
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="<%$ Resources:Button1 %>" />
    <div id="divReadTextFile" runat="server">
        <asp:Label ID="LabelInfo" runat="server" Text=""></asp:Label>
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <br />
        <asp:Button ID="Button2" runat="server" Text="<%$ Resources:Button2 %>" OnClick="Button2_Click" />
    </div>
</asp:Content>
