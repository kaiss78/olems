<%@ Page Title="" Language="C#" MasterPageFile="~/OLEMS.Master" CodeBehind="EditEmailAddress.aspx.cs"
    Inherits="OLEMS.UserManagement.EditEmailAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="style1">
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lnkUpdateEmailAddress" runat="server" Text="<%$ Resources:UILabels, lnkUpdateEmailAddress %>"></asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lnkCancelUpdateEmailAddress" runat="server" Text="<%$ Resources:UILabels, lnkCancelUpdateEmailAddress %>"></asp:LinkButton>
            </td>
            <td>
                <asp:TextBox ID="txtEmailAddress" runat="server" MaxLength="40"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmailAddress" runat="server"
                    ControlToValidate="txtEmailAddress" ErrorMessage="<%$ Resources:Errors, requiredEmailAddress %>"
                    Text="<%$ Resources:Errors, requiredEmailAddressText %>" ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmailAddress" runat="server"
                    ControlToValidate="txtEmailAddress" Display="Dynamic" ErrorMessage="<%$ Resources:Errors, invalidEmailFormat %>"
                    Text="<%$ Resources:Errors, invalidEmailFormatText %>" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ValidationGroup="AllValidators"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
            <td>
                <asp:ValidationSummary ID="ValidationSummaryManageProfile" runat="server" ValidationGroup="AllValidators" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
            </td>
            <td>
                <asp:Label ID="lblDisplayMessage" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divDiscardChanges" runat="server">
        <table class="style1">
            <tr>
                <td>
                    <asp:Label ID="lblDiscardChanges" runat="server" Text="<%$ Resources:UILabels, lblDiscardChanges %>"></asp:Label>
                </td>
                <td>
                    <asp:LinkButton ID="lnkYesDiscardChanges" runat="server" Text="<%$ Resources:UILabels, lnkYesDiscardChanges %>"></asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="lnkNoDiscardChanges" runat="server" Text="<%$ Resources:UILabels, lnkNoDiscardChanges %>"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
