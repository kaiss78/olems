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
                    SelectCommand="SELECT id, topicId, body, point, questionTypeId, isActive, questionFilePath, createdBy, createdAt, surum FROM Question"
                    InsertCommand="INSERT INTO [Question] (topicId, body, point, questionTypeId, isActive,questionFilePath,createdBy) VALUES (@topicId, @body, @point, @questionTypeId, @isActive,@questionFilePath,@createdBy)" 
                    UpdateCommand="UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive,questionFilePath=@questionFilePath WHERE id=@id" 
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
                        <asp:Parameter Name="questionFilePath" />
                        <asp:Parameter Name="id" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="topicId" />
                        <asp:Parameter Name="body" />
                        <asp:Parameter Name="point" />
                        <asp:Parameter Name="questionTypeId" />
                        <asp:Parameter Name="isActive"/>
                        <asp:Parameter Name="questionFilePath" />
                        <asp:Parameter Name="createdBy" />            
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
                    ForeColor="#333333" GridLines="None" Height="50px" Width="452px" 
                    DataSourceID="Question_SqlDataSource" DataKeyNames="id" 
                    DefaultMode="Insert" AutoGenerateInsertButton="True" 
                    AutoGenerateRows="False" Font-Names="Arial" Font-Size="Small" 
                    oniteminserted="QuestionDetailsView_ItemInserted" 
                    oniteminserting="QuestionDetailsView_ItemInserting" 
                    onitemcommand="QuestionDetailsView_ItemCommand">
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
                        <asp:TemplateField HeaderText="Body" SortExpression="body">                           
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtBody" runat="server" Text='<%# Bind("body") %>' Width ="350px"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidatorBody" runat="server" 
                                    ErrorMessage="Please enter body of the question"
                                    ControlToValidate="txtBody" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Point" SortExpression="point">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtPoint" runat="server" Text='<%# Bind("point") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidatorPoint" runat="server" 
                                    ErrorMessage="Please enter point"
                                    ControlToValidate="txtPoint" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator Display="Dynamic" ID="valPoint" runat="server" ControlToValidate="txtPoint"
                                    MaximumValue="100" MinimumValue="1" Type="Integer" Font-Names="Arial" Font-Size="Small"> Point should be between 1-100
                                </asp:RangeValidator>
                            </InsertItemTemplate>                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type" SortExpression="questionTypeId">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="qTypeDropDownList" runat="server" DataSourceID="QuestionType_SqlDataSource"
                                    AppendDataBoundItems="true" SelectedValue='<%#Bind("questionTypeId") %>'
                                    DataMember="DefaultView" DataTextField="name" DataValueField="id">
                                </asp:DropDownList>                            
                            </InsertItemTemplate>                           
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="isActive" HeaderText="Status" SortExpression="isActive" />
                        <asp:BoundField DataField="createdBy" HeaderText="createdBy" 
                            SortExpression="createdBy" Visible="False" />
                        <asp:BoundField DataField="createdAt" HeaderText="createdAt" SortExpression="createdAt" Visible="False" />
                        <asp:TemplateField HeaderText="Image File" SortExpression="questionFilePath">                           
                            <InsertItemTemplate>
                                <asp:FileUpload ID="imageFileUpload" runat="server"  />
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("questionFilePath") %>'></asp:Label>
                            </ItemTemplate>
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
              <asp:Label ID="LblError" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                    ForeColor="Red" Width="1091px" Height="18px" >
              </asp:Label>
            </td>
        </tr>
        <tr>
            <td>              
                <asp:GridView ID="QuestionGridView" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataKeyNames="id" DataSourceID="Question_SqlDataSource" 
                    EmptyDataText="No records found!" Font-Names="Arial" Font-Size="Small" 
                    ForeColor="#333333" GridLines="None" AllowPaging="True" 
                    AllowSorting="True" onrowdeleted="QuestionGridView_RowDeleted" 
                    onrowupdated="QuestionGridView_RowUpdated" 
                    onrowediting="QuestionGridView_RowEditing" 
                    onrowdeleting="QuestionGridView_RowDeleting" 
                    onrowupdating="QuestionGridView_RowUpdating">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <EmptyDataRowStyle ForeColor="Red" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" ValidationGroup="GV" SelectText="AnswerSet"><ControlStyle Font-Bold="True" /></asp:CommandField> 
                        <asp:CommandField ShowEditButton="True" ValidationGroup="GV"><ControlStyle Font-Bold="True" /></asp:CommandField>
                        <asp:CommandField ShowDeleteButton="True" ValidationGroup="GV"><ControlStyle Font-Bold="True" /></asp:CommandField>
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
                                <asp:TextBox ID="txtBody" Width ="300px" TextMode="MultiLine" runat="server" Text='<%# Bind("body") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidatorGVBody" ValidationGroup="GV" runat="server" 
                                    ErrorMessage="Please enter body"
                                    ControlToValidate="txtBody" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblBody" runat="server" Width ="300px" Text='<%# Bind("body") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Point" SortExpression="point">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPoint" runat="server" Text='<%# Bind("point") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="reqValidatorGVPoint" ValidationGroup="GV" runat="server" 
                                    ErrorMessage="Please enter point"
                                    ControlToValidate="txtPoint" Font-Names="Arial" Font-Size="Small">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator Display="Dynamic" ID="valGVPoint" runat="server" ValidationGroup="GV" ControlToValidate="txtPoint"
                                    MaximumValue="100" MinimumValue="1" Type="Integer" Font-Names="Arial" Font-Size="Small"> Point should be between 1-100
                                </asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPoint" runat="server" Text='<%# Bind("point") %>'></asp:Label>
                            </ItemTemplate>
                            <ControlStyle Width="40px" />
                            <HeaderStyle Width="40px" />
                            <ItemStyle Width="40px" />
                        </asp:TemplateField>
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
                        <asp:CheckBoxField DataField="isActive" HeaderText="Status" SortExpression="isActive" />
                        <asp:TemplateField HeaderText="Owner" SortExpression="createdBy">
                            <ItemTemplate>
                                <asp:Label ID="lblOwner" runat="server" Text='<%# Bind("createdBy") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="createdAt" HeaderText="Created At" ReadOnly="true" SortExpression="createdAt" >
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Image File" SortExpression="questionFilePath">
                            <EditItemTemplate>
                               <asp:FileUpload ID="imageGVFileUpload" runat="server"  />
                            </EditItemTemplate>
                            <ItemTemplate>
                             <%--   <asp:Label ID="Label1" runat="server" Text='<%# Bind("questionFilePath") %>'></asp:Label>--%>
                                <asp:HyperLink runat="server" Target="_blank" Text='<%# HttpUtility.UrlPathEncode(Eval("questionFilePath").ToString()) %>' NavigateUrl='<%# string.Concat("../QuestionFiles/",Eval("questionFilePath").ToString())%>'  />
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
            <td>
                &nbsp;
            </td>
        </tr>
 
    
  
 </table>
    
</asp:Content>
