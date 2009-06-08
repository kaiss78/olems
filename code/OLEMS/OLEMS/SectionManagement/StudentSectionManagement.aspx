<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentSectionManagement.aspx.cs"
    Title="Student Section Management" Inherits="OLEMS.SectionManagement.StudentSectionManagement"
    MasterPageFile="~/OLEMS.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%">
        <tr>
            <td>
                <asp:SqlDataSource ID="StudentSectionSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT Student.UserId, Section.id, isnull(Section.name, '') as name, vUsersNameSurname.UserName FROM vUsersNameSurname INNER JOIN Student ON vUsersNameSurname.UserId = Student.UserId LEFT OUTER JOIN Section ON Student.sectionId = Section.id"
                    UpdateCommand="UPDATE [Student] SET [sectionId] = @id WHERE [UserId]=@UserId">
                    <UpdateParameters>
                        <asp:Parameter Name="id" />
                        <asp:Parameter Name="UserId" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SectionSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [id], [name] FROM [Section] UNION SELECT NULL as id, '' as name">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="StudentSectionGridView" runat="server" CellPadding="4" ForeColor="#333333"
                    GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    DataSourceID="StudentSectionSqlDataSource" EmptyDataText="&lt;B&gt;No records found!&lt;/B&gt;"
                    Font-Names="Arial" Font-Size="Small" OnRowUpdated="StudentSectionRowUpdated"
                    Width="100%" DataKeyNames="userId">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" Visible="False" />
                        <asp:BoundField DataField="UserName" HeaderText="Student Username" ReadOnly="True"
                            SortExpression="UserName" />
                        <asp:TemplateField HeaderText="Section Name" SortExpression="name">
                            <EditItemTemplate>
                                <asp:DropDownList ID="StudentSectionDropDownList2" runat="server" DataSourceID="SectionSqlDataSource"
                                    DataTextField="name" DataValueField="id" SelectedValue='<%# Bind("id") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("name") %>'></asp:Label>
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
</asp:Content>
