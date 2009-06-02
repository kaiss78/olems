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
                <asp:SqlDataSource ID="QuestionSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
        SelectCommand="SELECT id, topicId, body, point, questionTypeId, isActive, createdBy, createdAt, surum FROM Question"
        InsertCommand="INSERT INTO [Question] (topicId, body, point, questionTypeId, isActive) VALUES (@topicId, @body, @point, @questionTypeId, @isActive)" 
        UpdateCommand="UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive WHERE id=@id" 
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
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="topicId" />
            <asp:Parameter Name="body" />
            <asp:Parameter Name="point" />
            <asp:Parameter Name="questionTypeId" />
            <asp:Parameter Name="isActive" />
        </InsertParameters>
    </asp:SqlDataSource>
            </td> 
        </tr>
        <tr>
            <td>
              <asp:DetailsView ID="QuestionDetailsView" runat="server" CellPadding="4" 
                    ForeColor="#333333" GridLines="None" Height="50px" Width="297px" 
                    DataSourceID="QuestionSqlDataSource" DataKeyNames="id" 
                    DefaultMode="Insert">
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <Fields>
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            </td>
        </tr>
 
    
  
 </table>
    
</asp:Content>
