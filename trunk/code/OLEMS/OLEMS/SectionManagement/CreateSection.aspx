<%@ Page Title="" Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true"
    CodeBehind="CreateSection.aspx.cs" Inherits="OLEMS.SectionManagement.CreateSection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
        DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None"
        Height="50px" Width="125px">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <Fields>
            <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id"
                Visible="False" />
            <asp:BoundField DataField="instructorId" HeaderText="instructorId" SortExpression="instructorId"
                Visible="False" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="capacity" HeaderText="capacity" SortExpression="capacity" />
            <asp:BoundField DataField="createdBy" HeaderText="createdBy" SortExpression="createdBy"
                Visible="False" />
            <asp:BoundField DataField="createdAt" HeaderText="createdAt" SortExpression="createdAt"
                Visible="False" />
            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
        </Fields>
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" DeleteCommand="DELETE FROM [Section] WHERE [id] = @original_id AND (([instructorId] = @original_instructorId) OR ([instructorId] IS NULL AND @original_instructorId IS NULL)) AND [name] = @original_name AND (([capacity] = @original_capacity) OR ([capacity] IS NULL AND @original_capacity IS NULL)) AND [createdBy] = @original_createdBy AND [createdAt] = @original_createdAt AND [surum] = @original_surum"
        InsertCommand="INSERT INTO [Section] ([id], [instructorId], [name], [capacity], [createdBy], [createdAt], [surum]) VALUES (@id, @instructorId, @name, @capacity, @createdBy, @createdAt, @surum)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Section]"
        UpdateCommand="UPDATE [Section] SET [instructorId] = @instructorId, [name] = @name, [capacity] = @capacity, [createdBy] = @createdBy, [createdAt] = @createdAt, [surum] = @surum WHERE [id] = @original_id AND (([instructorId] = @original_instructorId) OR ([instructorId] IS NULL AND @original_instructorId IS NULL)) AND [name] = @original_name AND (([capacity] = @original_capacity) OR ([capacity] IS NULL AND @original_capacity IS NULL)) AND [createdBy] = @original_createdBy AND [createdAt] = @original_createdAt AND [surum] = @original_surum">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Object" />
            <asp:Parameter Name="original_instructorId" Type="Object" />
            <asp:Parameter Name="original_name" Type="String" />
            <asp:Parameter Name="original_capacity" Type="Byte" />
            <asp:Parameter Name="original_createdBy" Type="String" />
            <asp:Parameter Name="original_createdAt" Type="DateTime" />
            <asp:Parameter Name="original_surum" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="instructorId" Type="Object" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="capacity" Type="Byte" />
            <asp:Parameter Name="createdBy" Type="String" />
            <asp:Parameter Name="createdAt" Type="DateTime" />
            <asp:Parameter Name="surum" Type="Object" />
            <asp:Parameter Name="original_id" Type="Object" />
            <asp:Parameter Name="original_instructorId" Type="Object" />
            <asp:Parameter Name="original_name" Type="String" />
            <asp:Parameter Name="original_capacity" Type="Byte" />
            <asp:Parameter Name="original_createdBy" Type="String" />
            <asp:Parameter Name="original_createdAt" Type="DateTime" />
            <asp:Parameter Name="original_surum" Type="Object" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="id" Type="Object" />
            <asp:Parameter Name="instructorId" Type="Object" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="capacity" Type="Byte" />
            <asp:Parameter Name="createdBy" Type="String" />
            <asp:Parameter Name="createdAt" Type="DateTime" />
            <asp:Parameter Name="surum" Type="Object" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
