<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleExamForSection.aspx.cs"
    Title="Schedule Exam For Section" Inherits="OLEMS.SectionManagement.ScheduleExamForSection"
    MasterPageFile="~/OLEMS.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:SqlDataSource ID="ExaminationSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT [startedAt], [startDate], [id], [sectionId], [examId], [locationId] FROM [Examination]" 
        DeleteCommand="DELETE FROM [Examination] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [Examination] ([startedAt], [startDate], [sectionId], [examId], [locationId]) VALUES (@startedAt, @startDate, @sectionId, @examId, @locationId)" 
        UpdateCommand="UPDATE [Examination] SET [startedAt] = @startedAt, [startDate] = @startDate, [sectionId] = @sectionId, [examId] = @examId, [locationId] = @locationId WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="startedAt" Type="DateTime" />
            <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="sectionId" Type="Object" />
            <asp:Parameter Name="examId" Type="Object" />
            <asp:Parameter Name="locationId" Type="Object" />
            <asp:Parameter Name="id" Type="Object" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="startedAt" Type="DateTime" />
            <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="id" Type="Object" />
            <asp:Parameter Name="sectionId" />
            <asp:Parameter Name="examId" />
            <asp:Parameter Name="locationId" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SectionSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT [id], [name] FROM [Section]  UNION SELECT NULL as id, 'Not Selected' as name" >
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ExamSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT [id], [name] FROM [Exam] UNION SELECT NULL as id, 'Not Selected' as name" >
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="LocationSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT [id], [name] FROM [Location] UNION SELECT NULL as id, 'Not Selected' as name" >
    </asp:SqlDataSource>
    
<table>
    <tr>
        <td>
        
            <asp:DetailsView ID="ExaminationDetailsView" runat="server" AutoGenerateRows="False" 
                CellPadding="4" DataKeyNames="id" DataSourceID="ExaminationSqlDataSource" 
                DefaultMode="Insert" Font-Names="Arial" Font-Size="Small" ForeColor="#333333" 
                GridLines="None" HeaderText="Schedule Section's Exam" Height="50px" 
                Width="153px" 
                oniteminserted="ExaminationDetailsView_ItemInserted">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <Fields>
                    <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" 
                        SortExpression="id" Visible="False" />
                    <asp:TemplateField HeaderText="Section Name">
                        <InsertItemTemplate>
                            <asp:DropDownList ID="SectionDropDownList" runat="server" DataSourceID="SectionSqlDataSource"
                                DataTextField="name" DataValueField="id" 
                                SelectedValue='<%# Bind("sectionId") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SectionLabel" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Exam Name">
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ExamDropDownList" runat="server" DataSourceID="ExamSqlDataSource"
                                DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("examId") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ExamLabel" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Location Name">
                        <InsertItemTemplate>
                            <asp:DropDownList ID="LocationDropDownList" runat="server" DataSourceID="LocationSqlDataSource"
                                DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("locationId") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LocationLabel" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Exam Date">
                        <InsertItemTemplate>
                            <asp:Calendar ID="startDate" runat="server" BackColor="#FFFFCC" 
                                BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" 
                                Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" Height="200px" 
                                SelectedDate='<%# Bind("startDate") %>' ShowGridLines="True" Width="220px">
                                <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                                <SelectorStyle BackColor="#FFCC66" />
                                <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#CC9966" />
                                <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                                <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                                <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" 
                                    ForeColor="#FFFFCC" />
                            </asp:Calendar>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Exam Time">
                        <InsertItemTemplate>
                            <asp:TextBox ID="startedAt" runat="server" 
                                Text='<%# Bind("startDate", "{0:T}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
        
        </td>
    </tr>
    <tr>
        <td>
        
        </td>
    </tr>
</table>
</asp:Content>

