<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnswersetManagement_TF.aspx.cs" Inherits="OLEMS.QuestionDevelopment.AnswersetManagement_TF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AnswerSet (True/False Questions)</title>
</head>
    <form id="form1" runat="server">
    <div>
    
        <table width="100%">
        <tr>
            <td align="center" style="height: 21px">
                <asp:Label ID="baslik" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Medium"
                    ForeColor="#CC0000">TRUE/FALSE QUESTION ANSWERSET 
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
                    UpdateCommand="UPDATE [Choice] SET body=@body,truthValue=@truthValue WHERE id=@id" >
                    <DeleteParameters>
                        <asp:Parameter Name="id" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="body" />
                        <asp:Parameter Name="truthValue" />
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
                    Height="50px" Width="311px" AutoGenerateInsertButton="True" 
                    AutoGenerateRows="False" oniteminserted="ChoicesDetailsView_ItemInserted" 
                    oniteminserting="ChoicesDetailsView_ItemInserting">
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
                                <asp:DropDownList ID="TFDropDownList1" runat="server" DataSourceID="TFSqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("body") %>'
                                    DataMember="DefaultView" DataTextField="value" DataValueField="value">
                                </asp:DropDownList>   
                            </InsertItemTemplate>                          
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Choice Truth Value" SortExpression="truthValue" 
                            Visible="False">                      
                            <InsertItemTemplate>
                               <asp:DropDownList ID="TFDropDownList" runat="server" DataSourceID="TFSqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("truthValue") %>'
                                    DataMember="DefaultView" DataTextField="value" DataValueField="value">
                                </asp:DropDownList>   
                            </InsertItemTemplate>                           
                            <HeaderStyle Wrap="False" />
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
                    ForeColor="#333333" GridLines="None" Width="312px">
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
                                <asp:DropDownList ID="TFDropDownList1" runat="server" 
                                    AppendDataBoundItems="true" DataMember="DefaultView" 
                                    DataSourceID="TFSqlDataSource" DataTextField="value" DataValueField="value" 
                                    SelectedValue='<%#Bind("body") %>'>
                                </asp:DropDownList>                                
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("body") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Choice Truth Value" SortExpression="truthValue">
                            <EditItemTemplate>                               
                                <asp:DropDownList ID="TFDropDownList" runat="server" 
                                    AppendDataBoundItems="true" DataMember="DefaultView" 
                                    DataSourceID="TFSqlDataSource" DataTextField="value" DataValueField="value" 
                                    SelectedValue='<%#Bind("truthValue") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("truthValue") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Wrap="False" />
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
</html>