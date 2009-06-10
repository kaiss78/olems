<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnswersetManagement_FR.aspx.cs" Inherits="OLEMS.QuestionDevelopment.AnswersetManagement_FR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AnswerSet (Free Response Questions)</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table width="100%">
        <tr>
            <td align="center" style="height: 21px">
                <asp:Label ID="baslik" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Medium"
                    ForeColor="#CC0000">FREE RESPONSE QUESTION ANSWERSET 
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td>    
                <asp:SqlDataSource ID="ChoicesSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [id], [questionId], [body], [truthValue] FROM [Choice]"                    
                    InsertCommand="INSERT INTO [Choice] (questionId,body,truthValue) VALUES (@questionId,@body,'True')" 
                    DeleteCommand="DELETE FROM [Choice] WHERE id=@id" 
                    UpdateCommand="UPDATE [Choice] SET body=@body WHERE id=@id" >
                    <DeleteParameters>
                        <asp:Parameter Name="id" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="body" />
                        <asp:Parameter Name="id" />
                    </UpdateParameters>
                    <InsertParameters>                        
                        <asp:Parameter Name="questionId" />
                        <asp:Parameter Name="body" />                        
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="QuestionSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT [body] FROM [Question] ">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="TFSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="Select 'True' as Value union Select 'False' as Value">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>       
            
                <asp:DetailsView ID="QuestionDetailsView" runat="server" 
                    AutoGenerateRows="False" CellPadding="4" DataSourceID="QuestionSqlDataSource" 
                    Font-Bold="True" Font-Names="Arial" Font-Size="Small" ForeColor="#333333" 
                    GridLines="None" Height="50px" Width="611px">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="body" HeaderText="Question Body" 
                            SortExpression="body">
                            <HeaderStyle Width="100px" />
                        </asp:BoundField>
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            
            
            </td>
        </tr>
        <tr>
            <td>            
                <asp:DetailsView ID="ChoicesDetailsView" runat="server" CellPadding="4" DataKeyNames="id" 
                    DataSourceID="ChoicesSqlDataSource" DefaultMode="Insert" Font-Names="Arial" 
                    Font-Overline="False" Font-Size="Small" ForeColor="#333333" GridLines="None" 
                    Height="50px" Width="479px" AutoGenerateInsertButton="True" 
                    AutoGenerateRows="False">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" 
                            SortExpression="id" Visible="False" />
                        <asp:BoundField DataField="questionId" HeaderText="questionId" 
                            SortExpression="questionId" Visible="False" />
                        <asp:TemplateField HeaderText="Choice Body" SortExpression="body">                            
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtBody" runat="server" Text='<%# Bind("body") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidator" runat="server" ErrorMessage="Please enter choice body"
                                    ControlToValidate="txtBody" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>                          
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            
            </td>
        </tr>
        <tr>
            <td>
                
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" 
                    DataSourceID="ChoicesSqlDataSource" Font-Names="Arial" Font-Size="Small" 
                    ForeColor="#333333" GridLines="None" Width="477px">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField ValidationGroup="GV" ShowEditButton="True">
                            <ControlStyle Font-Bold="True" />
                        </asp:CommandField>
                        <asp:CommandField ShowDeleteButton="True">
                            <ControlStyle Font-Bold="True" />
                        </asp:CommandField>
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" 
                            SortExpression="id" Visible="False" />
                        <asp:BoundField DataField="questionId" HeaderText="questionId" 
                            SortExpression="questionId" Visible="False" />
                        <asp:TemplateField HeaderText="Choice Body" SortExpression="body">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBodyGV" runat="server" Text='<%# Bind("body") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidator2" 
                                    ValidationGroup="GV" runat="server" ErrorMessage="Please enter choice body"
                                    ControlToValidate="txtBodyGV" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("body") %>'></asp:Label>
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
        
        </table>
    
    </div>
    
    </form>
</body>
</html>
