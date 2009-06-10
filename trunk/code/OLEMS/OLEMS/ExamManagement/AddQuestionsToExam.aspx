<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestionsToExam.aspx.cs" Inherits="OLEMS.ExamManagement.AddQuestionsToExam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Manage Questions of the Exam</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table width="100%">
        <tr>
            <td align="center" style="height: 21px">
                <asp:Label ID="baslik" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Medium"
                    ForeColor="#CC0000">ADD QUESTIONS TO THE EXAM 
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td>    
                
                <asp:SqlDataSource ID="ExamQuestionsSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT ExamQuestions.* FROM ExamQuestions">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="TopicSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT id, name FROM Topic"></asp:SqlDataSource>
                <asp:SqlDataSource ID="QuestionsOfExamSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT Question.topicId, Question.body, Topic.name AS topicName, QuestionType.name AS Expr2, Question.id FROM Exam INNER JOIN ExamQuestions ON Exam.id = ExamQuestions.examId INNER JOIN Question ON ExamQuestions.questionId = Question.id INNER JOIN Topic ON Question.topicId = Topic.id INNER JOIN QuestionType ON Question.questionTypeId = QuestionType.id WHERE (Exam.id = @id)"
                    
                    DeleteCommand="DELETE FROM ExamQuestions WHERE @examId NOT IN (SELECT Examination.examId FROM Examination) AND @examId IN (SELECT ExamQuestions.examId WHERE ExamQuestions.questionId = questionId)">
                    <DeleteParameters>
                        <asp:Parameter Name="examId" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="id" SessionField="edit" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="TopicDropDownList" runat="server" 
                    DataSourceID="TopicSqlDataSource" DataTextField="name" DataValueField="id" 
                    OnSelectedIndexChanged="TopicDropDownList_SelectedIndexChanged" 
                    AutoPostBack="True">
                </asp:DropDownList>
                <asp:DropDownList ID="QNumberDropDownList" runat="server" Enabled ="False" 
                    AutoPostBack="True">
                </asp:DropDownList>
                <asp:LinkButton ID="lnkAddQuestions" runat="server" 
                    onclick="lnkAddQuestions_Click" >Add Questions Randomly</asp:LinkButton>
                <br>
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" CellPadding="4" 
                    DataSourceID="QuestionsOfExamSqlDataSource" ForeColor="#333333" 
                    GridLines="None" DataKeyNames="id" onrowdeleting="GridView1_RowDeleting" 
                    EmptyDataText="There is no questions in the exam.">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:TemplateField HeaderText="Body" SortExpression="body">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("body") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Question Type" SortExpression="Expr2">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Expr2") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="id" SortExpression="id" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblQuestion" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Topic Name" SortExpression="topicName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("topicName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("topicName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                
                
                
            </td>
        </tr>
        
        </table>
    
    </div>
    
    </form>
</body>
</html>