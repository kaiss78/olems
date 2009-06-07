<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SectionInstructorManagement.aspx.cs" 
    Title="Section Instructor Management" Inherits="OLEMS.SectionManagement.SectionInstructorManagement" MasterPageFile="~/OLEMS.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 182px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 49%; height: 20px;">
        <tr>
            <td class="style1">
                <asp:SqlDataSource ID="SectionInstructorSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                    SelectCommand="SELECT [id], [instructorId], [name] FROM [Section]"
                    UpdateCommand="UPDATE [Section] SET [instructorId] =@instructorId WHERE [id] = @id"
                    >
                    <UpdateParameters>
                        <asp:Parameter Name="instructorId" />
                        <asp:Parameter Name="id" Type="Object" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td style="font-family: Arial, Helvetica, sans-serif; font-size: small" 
                class="style1">
                Instructor&#39;s Name</td>
            <td>
                <asp:DropDownList ID="InstructorDropDownList" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="SectionInstructorGridView" runat="server" 
                    AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" 
                    DataSourceID="SectionInstructorSqlDataSource" ForeColor="#333333" 
                    GridLines="None" Width="100%" AllowPaging="True" AllowSorting="True" 
                    Font-Names="Arial" Font-Size="Small" 
                    EmptyDataText="&lt;B&gt;No records found!&lt;/B&gt;" 
                    onrowediting="SectionInstructorGridView_RowEditing" 
                    onrowupdated="SectionInstructorGridView_RowUpdated">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <Columns>
                        <asp:CommandField EditText="Update" ShowEditButton="True" />
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" 
                            SortExpression="id" Visible="False" />
                        <asp:BoundField DataField="instructorId" HeaderText="instructorId" 
                            SortExpression="instructorId" Visible="False" />
                        <asp:BoundField DataField="name" HeaderText="Section Name" 
                            SortExpression="name" />
                        <asp:TemplateField HeaderText="Instructor Name" SortExpression="instructorId">
                            <EditItemTemplate>
                                <asp:DropDownList ID="SectionInstructorDropDownList2" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="SectionInstructorDropDownList" runat="server">
                                </asp:DropDownList>
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
