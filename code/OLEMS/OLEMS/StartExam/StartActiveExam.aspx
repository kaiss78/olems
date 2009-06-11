<%@ Page Title="" Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="StartActiveExam.aspx.cs" Inherits="OLEMS.StartExam.StartActiveExam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 366px;
        }
        .style2
        {
            width: 293px;
        }
        .style3
        {
            height: 46px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<table cellpadding="0" cellspacing="1">
        <tr>
            <td valign="top" colspan="2" class="style3">
               
               <asp:Label ID="lblSection" runat="server" Text="Section"></asp:Label>
                <asp:DropDownList ID="ddlSection" runat="server" Height="25px" Width="100px" 
                    DataSourceID="SqlDataSource_Section" DataTextField="name" DataValueField="id" 
                    AutoPostBack = "True" >
                </asp:DropDownList>
                <asp:Label ID="lblExam" runat="server" Text="Exam"></asp:Label>
                <asp:DropDownList ID="ddlExam" runat="server" Height="22px" Width="160px" 
                    DataSourceID="SqlDataSource_Exam" DataTextField="name" DataValueField="id" 
                    AutoPostBack="true" >
                </asp:DropDownList>
                <br /><br />
            </td>
        </tr>
        <tr>
            <td class="style1" >
                <asp:DetailsView ID="DetailsViewExamination" runat="server" Height="50px" 
                    Width="474px" AutoGenerateRows="False" CellPadding="4" 
                    DataSourceID="SqlDataSource_Examination" ForeColor="#333333" 
                    GridLines="None" 
                    EmptyDataText="There is no examination with selected exam and section." 
                    DataKeyNames="id" Font-Bold="False">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:TemplateField HeaderText="id" SortExpression="id" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblExaminationId" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Location Name" SortExpression="name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Section Name" SortExpression="sectionName">
                            <ItemTemplate>
                                <asp:Label ID="lblSectionName" runat="server" Text='<%# Bind("sectionName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Exam Name" SortExpression="examName">
                            <ItemTemplate>
                                <asp:Label ID="lblExamName" runat="server" Text='<%# Bind("examName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Start Date" SortExpression="startDate">
                            <ItemTemplate>
                                <asp:Label ID="lblStartDate" runat="server" Text='<%# Bind("startDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Started At" SortExpression="startedAt">
                            <ItemTemplate>
                                <asp:Label ID="lblStartedAt" runat="server" Text='<%# Bind("startedAt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            </td>
            <td class="style2" >
                
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" >
                
                <br />
                <asp:Label ID="lblStartActiveExam" runat="server" Font-Bold="True" 
                    Text="Please give your students the password below to start their exams:"></asp:Label>
                <br />
                <asp:Button ID="btnStartActiveExam" runat="server" Text="Start Active Exam" 
                    Enabled="False" onclick="btnStartActiveExam_Click" />
                <asp:TextBox ID="txtPassword" runat="server" AutoPostBack="True" 
                    Enabled="False"></asp:TextBox>
                <asp:Button ID="btnGeneratePasswd" runat="server" onclick="btnGeneratePasswd_Click" 
                    Text="Generate Password" />
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" Font-Bold="True" 
                    Text="Please select the student(s) and extend their exams:"></asp:Label>
                <br />
                <asp:Button ID="btnExtendExam" runat="server" onclick="btnExtendExam_Click" 
                    Text="Extend Student(s) Exam" />
                <asp:TextBox ID="txtMin" runat="server"></asp:TextBox>
                <asp:Label ID="lblMin" runat="server" Font-Bold="True" Text="min."></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label8" runat="server" Font-Bold="True" 
                    Text="Please select student(s) to finalize their exams:"></asp:Label>
                <br />
                <asp:Button ID="btnFinalize" runat="server" Text="Finalize Student(s) Exam" 
                    onclick="btnFinalize_Click" />
                <br />
                <br />
                <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <br />
                <br />
                
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataSourceID="SqlDataSource_StudentExamination" 
                    ForeColor="#333333" GridLines="None" DataKeyNames="UserId">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:TemplateField HeaderText="UserId" SortExpression="UserId" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("UserId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="name">
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Surname" SortExpression="surname">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("surname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Examination Id" SortExpression="sexaminationId" 
                            Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblSexaminationId" runat="server" Text='<%# Bind("id") %>' 
                                    Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Finalized At" SortExpression="finalizedAt">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("finalizedAt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                
                &nbsp;</td>
        </tr>
        <asp:SqlDataSource ID="SqlDataSource_Exam" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
            SelectCommand="SELECT [id], [name], [duration], [tolerance], [isActive], [createdBy], [createdAt], [examTypeId] FROM [Exam]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Section" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
            
            SelectCommand="SELECT [id], [name], [instructorId], [capacity], [createdBy], [createdAt] FROM [Section]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_StudentExamination" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" SelectCommand="SELECT     Users.UserId, 
            Users.name, Users.surname, StudentExamination.id, StudentExamination.startedAt,
            StudentExamination.finalizedAt, StudentExamination.finishedAt 
FROM         Users,StudentExamination 
WHERE    (StudentExamination.examinationId = @examinationId)
AND			Users.UserId = StudentExamination.studentId">
            <SelectParameters>
                <asp:ControlParameter ControlID="DetailsViewExamination" Name="examinationId" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Examination" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
            SelectCommand="SELECT     Examination.id, Examination.startedAt, Examination.startDate, Location.name, Section.name AS sectionName, Exam.name AS examName
FROM         Examination INNER JOIN
                      Location ON Examination.locationId = Location.id INNER JOIN
                      Section ON Examination.sectionId = Section.id INNER JOIN
                      Exam ON Examination.examId = Exam.id
WHERE     (Examination.sectionId = @sectionId) AND (Examination.examId = @examId)
AND Examination.startDate &gt; (SELECT getdate())
AND Examination.startedAt IS NULL">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSection" Name="sectionId" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlExam" Name="examId" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </table>

</asp:Content>
