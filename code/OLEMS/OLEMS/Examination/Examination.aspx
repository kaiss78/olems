<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="Examination.aspx.cs"
    Inherits="OLEMS.Examination.Examination" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="1" width="100%">
        <tr>
            <td rowspan="5" valign="top">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                    DataTextField="questionOrder" DataValueField="questionId" OnDataBound="RadioButtonList1_DataBound">
                </asp:RadioButtonList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="selListOfQuestionsInExamForStudent" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="studentExaminationId" SessionField="StudentExaminationGUID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="HeaderCell">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                    SelectCommand="SELECT [body], [questionFilePath], [questionTypeId] FROM [Question] WHERE ([id] = @id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="HeaderCellRight">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:Timer ID="Timer1" runat="server">
                </asp:Timer>
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
            <td colspan="2" style="text-align: center">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="FreeResponse" runat="server">
                        <table width="100%">
                            <tr>
                                <td colspan="2" class="HeaderCell">
                                    <asp:Label ID="LabelFreeResponseHeader" runat="server" Text="<%$ Resources:LabelFreeResponseHeader %>" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBoxFreeResponse" runat="server" MaxLength="250" Rows="2" TextMode="MultiLine" />
                                </td>
                            </tr>
                            <tr>
                                <td class="ExplanationCell">
                                    <asp:Label ID="LabelFreeResponsePressSubmit" runat="server" Text="<%$ Resources:LabelPressSubmit %>" />
                                </td>
                                <td align="right">
                                    <asp:Button ID="ButtonFreeResponse" runat="server" OnClick="ButtonFreeResponse_Click"
                                        Text="<%$ Resources:SubmitButton %>" />
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="Matching" runat="server">
                        <table width="100%">
                            <tr>
                                <td class="HeaderCell">
                                    <asp:Label ID="LabelMatchingHeader" runat="server" Text="<%$ Resources:LabelMatchingHeader %>" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td rowspan="2">
                                    <asp:SqlDataSource ID="SqlDataSourceMatchingBody" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                                        SelectCommand="SELECT [id], [body] FROM [Choice] WHERE ([questionId] = @questionId) ORDER BY NewID()">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadioButtonList1" Name="questionId" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:ListBox ID="ListBoxMatchingBody" runat="server" DataSourceID="SqlDataSourceMatchingBody"
                                        DataTextField="body" DataValueField="id"></asp:ListBox>
                                </td>
                                <td rowspan="2">
                                    <asp:SqlDataSource ID="SqlDataSourceMatchingTruthValue" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                                        SelectCommand="SELECT [id], [truthValue] FROM [Choice] WHERE ([questionId] = @questionId) ORDER BY NewID()">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadioButtonList1" Name="questionId" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:ListBox ID="ListBoxMatchingTruthValue" runat="server" DataSourceID="SqlDataSourceMatchingTruthValue"
                                        DataTextField="truthValue" DataValueField="id" OnDataBound="ListBoxMatchingTruthValue_DataBound">
                                    </asp:ListBox>
                                </td>
                                <td valign="top">
                                    <asp:Button ID="ButtonMatch" runat="server" Text="<%$ Resources:ButtonMatch %>" OnClick="ButtonMatch_Click" />
                                    <br />
                                </td>
                                <td rowspan="2">
                                    <asp:ListBox ID="ListBoxMatchingResponse" runat="server"></asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <asp:Button ID="ButtonUnmatch" runat="server" OnClick="ButtonUnmatch_Click" Text="<%$ Resources:ButtonUnmatch %>" />
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td class="ExplanationCell">
                                    <asp:Label ID="LabelMatchingPressSubmit" runat="server" Text="<%$ Resources:LabelPressSubmit %>" />
                                </td>
                                <td>
                                    <asp:Button ID="ButtonMatching" runat="server" Text="<%$ Resources:SubmitButton %>"
                                        OnClick="ButtonMatching_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="TrueFalse" runat="server">
                        <table width="100%">
                            <tr>
                                <td colspan="2" class="HeaderCell">
                                    <asp:Label ID="LabelTrueFalseHeader" runat="server" Text="<%$ Resources:LabelTrueFalseHeader %>" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:SqlDataSource ID="SqlDataSourceTrueFalse" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                                        SelectCommand="SELECT [id], [body] FROM [Choice] WHERE ([questionId] = @questionId) ORDER BY NewID()">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadioButtonList1" Name="questionId" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RadioButtonList ID="RadioButtonListTrueFalse" runat="server" DataSourceID="SqlDataSourceTrueFalse"
                                        DataTextField="body" DataValueField="id" RepeatColumns="2" RepeatDirection="Horizontal"
                                        Width="100%">
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td class="ExplanationCell">
                                    <asp:Label ID="LabelTrueFalsePressSubmit" runat="server" Text="<%$ Resources:LabelPressSubmit %>" />
                                </td>
                                <td align="right">
                                    <asp:Button ID="ButtonTrueFalse" runat="server" OnClick="ButtonTrueFalse_Click" Text="<%$ Resources:SubmitButton %>" />
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="MultipleChoice" runat="server">
                        <table width="100%">
                            <tr>
                                <td colspan="2" class="HeaderCell">
                                    <asp:Label ID="LabelMultipleChoiceHeader" runat="server" Text="<%$ Resources:LabelMultipleChoiceHeader %>" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:SqlDataSource ID="SqlDataSourceMultipleChoice" runat="server" ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>"
                                        SelectCommand="SELECT [id], [body] FROM [Choice] WHERE ([questionId] = @questionId) ORDER BY NewID()">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="RadioButtonList1" Name="questionId" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RadioButtonList ID="RadioButtonListMultipleChoice" runat="server" DataSourceID="SqlDataSourceMultipleChoice"
                                        DataTextField="body" DataValueField="id">
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td class="ExplanationCell">
                                    <asp:Label ID="LabelMultipleChoicePressSubmit" runat="server" Text="<%$ Resources:LabelPressSubmit %>" />
                                </td>
                                <td align="right">
                                    <asp:Button ID="ButtonMultipleChoice" runat="server" OnClick="ButtonMultipleChoice_Click"
                                        Text="<%$ Resources:SubmitButton %>" />
                                </td>
                            </tr>
                        </table>
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
