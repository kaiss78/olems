<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="CreateNewUser.aspx.cs"
    Inherits="OLEMS.SystemAdministration.CreateNewUser" Title="<%$ Resources:PageTitle %>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="PageHeader" runat="server" Text="<%$ Resources:PageHeader %>"></asp:Label>
    </h3>
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#FFFBD6" BorderColor="#FFDFAD"
        BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
        OnNextButtonClick="CreateUserWizard1_NextButtonClick" ContinueDestinationPageUrl="~/SystemAdministration/AddUserToRole.aspx"
        OnFinishButtonClick="CreateUserWizard1_FinishButtonClick">
        <SideBarStyle BackColor="#990000" Font-Size="0.9em" VerticalAlign="Top" />
        <SideBarButtonStyle ForeColor="White" />
        <ContinueButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#990000" />
        <NavigationButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#990000" />
        <HeaderStyle BackColor="#FFCC66" BorderColor="#FFFBD6" BorderStyle="Solid" BorderWidth="2px"
            Font-Bold="True" Font-Size="0.9em" ForeColor="#333333" HorizontalAlign="Center" />
        <CreateUserButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#990000" />
        <TitleTextStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <WizardSteps>
            <asp:CreateUserWizardStep ID="Createuserwizardstep1" runat="server" Title="Sign Up for Your New Account">
            </asp:CreateUserWizardStep>
            <asp:WizardStep ID="Wizardstep1" runat="server" Title="Identification">
                <asp:Label BackColor="#FFCC66" BorderColor="#FFFBD6" BorderStyle="Solid" BorderWidth="2px"
                    Font-Bold="True" Font-Size="0.9em" ForeColor="#333333" HorizontalAlign="Center"
                    ID="LabelDetails" runat="server" Text="<%$ Resources:LabelDetails %>"></asp:Label><br />
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="LabelName" runat="server" Text="<%$ Resources:LabelName %>" AssociatedControlID="firstName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="firstName" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="LabelSurname" runat="server" Text="<%$ Resources:LabelName %>" AssociatedControlID="lastName"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="lastName" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
            <asp:CompleteWizardStep runat="server">
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
