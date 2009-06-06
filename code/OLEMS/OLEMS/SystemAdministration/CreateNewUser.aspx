<%@ Page Language="C#" MasterPageFile="~/OLEMS.Master" AutoEventWireup="true" CodeBehind="CreateNewUser.aspx.cs"
    Inherits="OLEMS.SystemAdministration.CreateNewUser" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" ActiveStepIndex="1" BackColor="#FFFBD6"
        BorderColor="#FFDFAD" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"
        Font-Size="0.8em">
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
            <asp:CreateUserWizardStep runat="server" />
            <asp:CompleteWizardStep runat="server" />
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
