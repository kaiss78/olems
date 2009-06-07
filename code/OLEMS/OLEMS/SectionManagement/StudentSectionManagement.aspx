<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentSectionManagement.aspx.cs" 
    Title="Student Section Management" Inherits="OLEMS.SectionManagement.StudentSectionManagement" MasterPageFile="~/OLEMS.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        
        <tr>
            <td>
                <asp:SqlDataSource ID="StudentSectionSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT Student.UserId AS userId, Student.sectionId AS sectionId, Section.name AS sectionName, 
		vUsersNameSurname.UserName AS userName
FROM dbo.Student as Student, dbo.Section as Section, dbo.vUsersNameSurname as vUsersNameSurname
WHERE Section.id = Student.sectionId AND vUsersNameSurname.UserId = Student.UserId

UNION 

SELECT Student.UserId, Student.sectionId, NULL AS SectionName, vUsersNameSurname.UserName
FROM dbo.Student as Student, dbo.vUsersNameSurname as vUsersNameSurname
WHERE Student.sectionId IS NULL AND Student.UserId = vUsersNameSurname.UserId" 
                    
                    
                    UpdateCommand="UPDATE [Student] SET [sectionId] = @sectionId WHERE [UserId]=@userId">
                    <UpdateParameters>
                        <asp:Parameter Name="sectionId"/>
                        <asp:Parameter Name="userId" Type="Object" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SectionSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT [id], [name] FROM [Section]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        
        <tr>
            <td>
                
                <asp:GridView ID="StudentSectionGridView" runat="server" CellPadding="4" ForeColor="#333333" 
                    GridLines="None" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" 
                    DataSourceID="StudentSectionSqlDataSource" 
                    EmptyDataText="&lt;B&gt;No records found!&lt;/B&gt;" Font-Names="Arial" 
                    Font-Size="Small" onrowupdated="StudentSectionRowUpdated">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="userName" HeaderText="Student Username" ReadOnly="True" 
                            SortExpression="userName" />
                        <asp:TemplateField HeaderText="Section Name" SortExpression="sectionName">
                            <EditItemTemplate>
                                <asp:DropDownList ID="StudentSectionDropDownList2" runat="server" 
                                    DataSourceID="SectionSqlDataSource" DataTextField="name" DataValueField="id" 
                                    Height="16px" SelectedValue='<%# Bind("sectionId") %>' Width="109px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="SectionNameDropDownList1" runat="server" 
                                    DataSourceID="SectionSqlDataSource" DataTextField="name" DataValueField="id" 
                                    SelectedValue='<%# Bind("sectionId") %>' Width="102px" Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="userId" HeaderText="userId" SortExpression="userId" 
                            Visible="False" />
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
</asp:Content>
