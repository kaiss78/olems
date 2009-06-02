<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="QuestionManagement.aspx.cs" Inherits="OLEMS.QuestionDevelopment.QuestionManagement" Title="Question Management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <table width="100%">
        <tr>
            <td align="center" style="height: 21px">
                <asp:Label ID="baslik" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Medium"
                    ForeColor="#CC0000">QUESTION MANAGEMENT
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td>  
                <asp:SqlDataSource ID="Question_SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT id, topicId, body, point, questionTypeId, isActive, createdBy, createdAt, surum FROM Question"
        InsertCommand="INSERT INTO [Question] (topicId, body, point, questionTypeId, isActive) VALUES (@topicId, @body, @point, @questionTypeId, @isActive)" 
        UpdateCommand="UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive WHERE id=@id" 
        DeleteCommand="DELETE FROM  [Question]  WHERE id=@id">
        <DeleteParameters>
            <asp:Parameter Name="id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="topicId" />
            <asp:Parameter Name="body" />
            <asp:Parameter Name="point" />
            <asp:Parameter Name="questionTypeId" />
            <asp:Parameter Name="isActive" />
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="topicId" />
            <asp:Parameter Name="body" />
            <asp:Parameter Name="point" />
            <asp:Parameter Name="questionTypeId" />
            <asp:Parameter Name="isActive" />
        </InsertParameters>
    </asp:SqlDataSource>
                <asp:SqlDataSource ID="Topic_SqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT [id], [name] FROM [Topic] order by 2">
                </asp:SqlDataSource>                
                <asp:SqlDataSource ID="QuestionType_SqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT [id], [name] FROM [QuestionType] order by 2">
                </asp:SqlDataSource>                
            </td>       
        </tr>
        <tr>
            <td>
              <asp:DetailsView ID="QuestionDetailsView" runat="server" CellPadding="4" 
                    ForeColor="#333333" GridLines="None" Height="50px" Width="297px" 
                    DataSourceID="Question_SqlDataSource" DataKeyNames="id" 
                    DefaultMode="Insert" AutoGenerateInsertButton="True" 
                    AutoGenerateRows="False" Font-Names="Arial" Font-Size="Small" 
                    oniteminserted="QuestionDetailsView_ItemInserted">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" 
                            SortExpression="id" Visible="False" />
                        <asp:TemplateField HeaderText="Topic" SortExpression="topicId">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="topicDropDownList" runat="server" DataSourceID="Topic_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("topicId") %>'
                                    DataMember="DefaultView" DataTextField="name" DataValueField="id">
                                </asp:DropDownList>
                            </InsertItemTemplate>                              
                        </asp:TemplateField>
                        <asp:BoundField DataField="body" HeaderText="Body" SortExpression="body" />
                        <asp:BoundField DataField="point" HeaderText="Point" SortExpression="point" />
                        <asp:TemplateField HeaderText="Type" SortExpression="questionTypeId">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="qTypeDropDownList" runat="server" DataSourceID="QuestionType_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("questionTypeId") %>'
                                    DataMember="DefaultView" DataTextField="name" DataValueField="id">
                                </asp:DropDownList>                            
                            </InsertItemTemplate>                           
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="isActive" HeaderText="Status" SortExpression="isActive" />
                        <asp:BoundField DataField="createdBy" HeaderText="createdBy" SortExpression="createdBy" Visible="False" />
                        <asp:BoundField DataField="createdAt" HeaderText="createdAt" SortExpression="createdAt" Visible="False" />
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>                
                <asp:GridView ID="QuestionGridView" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataKeyNames="id" DataSourceID="Question_SqlDataSource" 
                    EmptyDataText="No records found!" Font-Names="Arial" Font-Size="Small" 
                    ForeColor="#333333" GridLines="None" AllowPaging="True" 
                    AllowSorting="True" onrowdeleted="QuestionGridView_RowDeleted" 
                    onrowupdated="QuestionGridView_RowUpdated">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <EmptyDataRowStyle ForeColor="Red" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="AnswerSet"><ControlStyle Font-Bold="True" /></asp:CommandField> 
                        <asp:CommandField ShowEditButton="True"><ControlStyle Font-Bold="True" /></asp:CommandField>
                        <asp:CommandField ShowDeleteButton="True"><ControlStyle Font-Bold="True" /></asp:CommandField>
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" Visible="False" />
                        <asp:TemplateField HeaderText="Topic" SortExpression="topicId">
                            <EditItemTemplate>
                                <asp:DropDownList ID="topicDropDownList" runat="server" DataSourceID="Topic_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("topicId") %>'
                                    DataMember="DefaultView" DataTextField="name" DataValueField="id">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="topicDropDownList2" runat="server" DataSourceID="Topic_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("topicId") %>'
                                    DataMember="DefaultView" Enabled="False" DataTextField="name" DataValueField="id">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Body" SortExpression="body">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBody"  Width ="100" runat="server" Text='<%# Bind("body") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblBody" runat="server" Width ="200" Text='<%# Bind("body") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="point" HeaderText="Point" SortExpression="point" />
                        <asp:TemplateField HeaderText="Type" SortExpression="questionTypeId">
                            <EditItemTemplate>
                                <asp:DropDownList ID="qTypeDropDownList" runat="server" DataSourceID="QuestionType_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("questionTypeId") %>'
                                    DataMember="DefaultView" DataTextField="name" DataValueField="id">
                                </asp:DropDownList> 
                            </EditItemTemplate>
                            <ItemTemplate>
                                 <asp:DropDownList ID="qTypeDropDownList2" runat="server" DataSourceID="QuestionType_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("questionTypeId") %>'
                                    DataMember="DefaultView" Enabled="False" DataTextField="name" DataValueField="id">
                                </asp:DropDownList> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="isActive" HeaderText="Status" 
                            SortExpression="isActive" />
                        <asp:BoundField DataField="createdBy" HeaderText="Owner" 
                            SortExpression="createdBy" />
                        <asp:BoundField DataField="createdAt" HeaderText="Created At" 
                            SortExpression="createdAt" />
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
            <td>
                &nbsp;</td>
        </tr>
 
    
  
 </table>
    
</asp:Content>
