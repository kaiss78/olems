<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="Examination.aspx.cs"
    Inherits="OLEMS.Examination.Examination" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="1" width="100%">
        <tr>
            <td rowspan="5" valign="top">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                    DataTextField="questionOrder" DataValueField="questionId" 
                    OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" 
                    ondatabound="RadioButtonList1_DataBound">
                </asp:RadioButtonList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="selListOfQuestionsInExamForStudent" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="studentExaminationId" SessionField="StudentExaminationGUID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [body], [questionFilePath], [questionTypeId] FROM [Question] WHERE ([id] = @id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
                    DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" Height="50px"
                    Width="100%">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="body" HeaderText="Question Body" NullDisplayText="No question body defined"
                            ReadOnly="True" ShowHeader="False" SortExpression="body" />
                        <asp:TemplateField HeaderText="questionFilePath" InsertVisible="False" ShowHeader="False"
                            SortExpression="questionFilePath">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("questionFilePath") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("questionFilePath") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="questionTypeId" HeaderText="questionTypeId" SortExpression="questionTypeId"
                            Visible="False" />
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
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
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="FreeResponse" runat="server">
                        FreeResponse
                    </asp:View>
                    <asp:View ID="Matching" runat="server">
                        Matching
                    </asp:View>
                    <asp:View ID="TrueFalse" runat="server">
                        TrueFalse
                    </asp:View>
                    <asp:View ID="MultipleChoice" runat="server">
                        MultipleChoice
                    </asp:View>
                </asp:MultiView>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
