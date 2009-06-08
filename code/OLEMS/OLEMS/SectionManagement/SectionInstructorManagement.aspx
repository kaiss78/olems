<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SectionInstructorManagement.aspx.cs"
    Title="Section Instructor Management" Inherits="OLEMS.SectionManagement.SectionInstructorManagement"
    MasterPageFile="~/OLEMS.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%">
        <tr>
            <td>
                <asp:SqlDataSource ID="SectionInstructorSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT Section.id, Section.name, Section.instructorId, vUsersNameSurname.UserName FROM vUsersNameSurname INNER JOIN Users ON vUsersNameSurname.UserId = Users.UserId RIGHT OUTER JOIN Section ON Users.UserId = Section.instructorId"
                    UpdateCommand="UPDATE [Section] SET [instructorId] =@instructorId WHERE [id] = @id">
                    <UpdateParameters>
                        <asp:Parameter Name="instructorId" />
                        <asp:Parameter Name="id" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="InstructorSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [UserId], [UserName] FROM [vUsersNameSurname] WHERE ([RoleName] = @RoleName) UNION SELECT NULL as UserId, 'Not Assigned' as UserName">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Instructor" Name="RoleName" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="SectionInstructorGridView" runat="server" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="id" DataSourceID="SectionInstructorSqlDataSource"
                    ForeColor="#333333" GridLines="None" Width="100%" AllowPaging="True" AllowSorting="True"
                    Font-Names="Arial" Font-Size="Small" EmptyDataText="&lt;B&gt;No records found!&lt;/B&gt;"
                    OnRowEditing="SectionInstructorGridView_RowEditing" OnRowUpdated="SectionInstructorGridView_RowUpdated">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField EditText="Update" ShowEditButton="True" />
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id"
                            Visible="False" />
                        <asp:BoundField DataField="instructorId" HeaderText="instructorId" SortExpression="instructorId"
                            Visible="False" />
                        <asp:BoundField DataField="name" HeaderText="Section Name" SortExpression="name" />
                        <asp:TemplateField HeaderText="Instructor Name" SortExpression="instructorId">
                            <EditItemTemplate>
                                <asp:DropDownList ID="SectionInstructorDropDownList2" runat="server" DataSourceID="InstructorSqlDataSource"
                                    DataTextField="UserName" DataValueField="UserId" SelectedValue='<%# Bind("instructorId") %>'
                                    AppendDataBoundItems="true">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
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
