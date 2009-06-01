<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LocationManagement.aspx.cs" Inherits="OLEMS.SystemAdministration.LocationManagement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Location Management</title>
</head>
 <body>
    <form id="form1" runat="server">
        <table width="100%">
                <tr>
                    <td align="center" style="height: 21px">
                        <asp:Label ID="baslik" runat="server" Font-Bold="True" Font-Names="Arial" 
                         Font-Size ="Medium" ForeColor="#CC0000">LOCATION MANAGEMENT
                        </asp:Label>
                    </td>
                </tr>
            </table>
        <div>
<%-- Location sqldatasource-------------------------------------------------------------------------------------------------%>   
        <asp:SqlDataSource ID="Location_SqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                SelectCommand="SELECT * FROM [Location]"
                InsertCommand="INSERT INTO [Location] ([name],[capacity],[locationBuildingId]) VALUES (@name,@capacity,@locationBuildingId)"
                UpdateCommand="UPDATE [Location] SET [name] = @name, [capacity] =@capacity, [locationBuildingId]= @locationBuildingId WHERE [id] = @id"
                DeleteCommand="DELETE FROM [Location] WHERE [id] = @id">
                <InsertParameters>
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="capacity" Type="Int16" />
                    <%-- Aşağıdaki parametre gibi FK olan parametrelerde Type yazma, hata veriyor-------------%> 
                    <asp:Parameter Name="locationBuildingId" /> 
                    <asp:Parameter Name="id" Type="Object" />                    
                </InsertParameters>  
                <UpdateParameters>
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter Name="capacity" Type="Int16" />
                    <asp:Parameter Name="locationBuildingId" /> 
                    <asp:Parameter Name="id" Type="Object"  />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Object"  />
                </DeleteParameters>
            </asp:SqlDataSource>
<%--Building sqldatasource--------------------------------------------------------------------------------------%>   
         
        <asp:SqlDataSource ID="Building_SqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:IS50220082G4_ConnectionString %>" 
                SelectCommand="SELECT [id],[name] FROM [LocationBuilding]">
            </asp:SqlDataSource>
        
        </div>
<%--Detailsview------------------------------------------------------------------------------------------------%>   
        <asp:DetailsView ID="LocationDetailsView" 
            runat="server" AutoGenerateRows="False" 
            CellPadding="4" DataKeyNames="id" 
            DataSourceID="Location_SqlDataSource" 
            ForeColor="#333333" GridLines="None" 
            Style="z-index: 102; left: 187px; position: absolute; top: 53px; width: 500px;" 
            Height="50px"
            DefaultMode="Insert" 
            AutoGenerateInsertButton="True" Font-Names="Arial" 
            Font-Size="Small">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" Visible="False" />
                
                <asp:TemplateField HeaderText="Location Name" SortExpression="name">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic"                              
                              ID="reqValidator1" runat="server" 
                              ErrorMessage ="Please enter Location name"                      
                              ControlToValidate="txtName" 
                              Font-Names="Arial" Font-Size="Small">
                        </asp:RequiredFieldValidator>  
                    </InsertItemTemplate>                    
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Capacity" SortExpression="capacity">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtCapacity" runat="server" Text='<%# Bind("capacity") %>'></asp:TextBox>
                        <asp:RangeValidator 
                              Display="Dynamic" ID ="valCapacity" 
                              runat="server" ControlToValidate="txtCapacity" 
                              MaximumValue="255" MinimumValue="1" Type="Integer" 
                              Font-Names="Arial" Font-Size="Small" > Capacity should be between 1-255
                        </asp:RangeValidator>
                        <asp:RequiredFieldValidator Display="Dynamic" 
                              ID="reqValidator2" runat="server" 
                              ErrorMessage ="Please enter capacity"                      
                              ControlToValidate="txtCapacity" 
                              Font-Names="Arial" Font-Size="Small">
                        </asp:RequiredFieldValidator>  
                    </InsertItemTemplate>          
                </asp:TemplateField>      
                                
                <asp:TemplateField HeaderText="Building" SortExpression="locationBuildingId">           
                    <InsertItemTemplate>
                        <asp:DropDownList  
                            ID="buildingDropDownList" 
                            runat="server" 
                            DataSourceID="Building_SqlDataSource" 
                            AppendDataBoundItems="true"   
                            SelectedValue='<%#Bind("locationBuildingId") %>' 
                            DataMember="DefaultView"
                            DataTextField="name" 
                            DataValueField="id" >                        
                         </asp:DropDownList>
                    </InsertItemTemplate>                   
                </asp:TemplateField>
                                               
                <asp:BoundField DataField="createdBy" HeaderText="createdBy" 
                    SortExpression="createdBy" Visible="False" />
                                
                <asp:BoundField DataField="createdAt" HeaderText="createdAt" 
                    SortExpression="createdAt" Visible="False" />
            </Fields>
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
<%--check box----------------------------------------------------------------------------------------------%>   
        <asp:CheckBox ID="SearchAllCheckBox" runat="server" 
            Style="z-index: 101; left: 338px; position: absolute; top: 181px; height: 19px; right: 357px; width: 189px;"
            Font-Names="Arial" Font-Size="Small" Text="Search in All Buildings" />
<%--search button-------------------------------------------------------------------------------------------%>                   
        <asp:LinkButton ID="lnkSearch" 
                Font-Bold="true"  runat="server" CausesValidation ="false"
                Style="z-index: 101; left: 188px; position: absolute; top: 184px; height: 19px; right: 488px; width: 123px;" Font-Names="Arial" 
                Font-Size="Small" ForeColor="Black" onclick="lnkSearch_Click"                 
                ToolTip="Type a keyword in location name or a number for capacity and press this button for search">Search Location(s)
            </asp:LinkButton>
<%--Gridview-------------------------------------------------------------------------------------------------%>               
        <asp:GridView ID="LocationGridView" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False"             
            CellPadding="4" 
            DataKeyNames="id" 
            EmptyDataText="<B>No records found!</B>" 
            Style="z-index: 101; left: 191px; position: absolute; top: 215px; height: 414px; width: 496px;" 
            DataSourceID="Location_SqlDataSource" 
            ForeColor="#333333" GridLines="None" 
            Font-Names="Arial" Font-Size="Small" 
            onrowediting="LocationGridView_RowEditing" 
            onrowupdated="LocationGridView_RowUpdated">
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333"/>
            <Columns>
              
                <asp:CommandField ValidationGroup ="GV" ShowEditButton="True" ><ControlStyle Font-Bold="True" /></asp:CommandField>
                <asp:CommandField ShowDeleteButton="True"><ControlStyle Font-Bold="True" /></asp:CommandField>

                <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" Visible="False" />
                
                <asp:TemplateField HeaderText="Location Name" SortExpression="name">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtLocationName" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" 
                              ValidationGroup ="GV" 
                              ID="reqValidator1" runat="server" 
                              ErrorMessage ="Please enter Location name"                      
                              ControlToValidate="txtLocationName" 
                              Font-Names="Arial" Font-Size="Small">
                        </asp:RequiredFieldValidator>  
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Italic="False" Wrap="False" />
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Capacity" SortExpression="capacity">
                    <EditItemTemplate>
                        <asp:TextBox ID="tCapacity" runat="server" Text='<%# Bind("capacity") %>'></asp:TextBox>
                        <asp:RangeValidator Display="Dynamic" 
                              ID ="valCapacity" ValidationGroup ="GV" 
                              runat="server" ControlToValidate="tCapacity" 
                              MaximumValue="255" MinimumValue="1" Type="Integer" 
                              Font-Names="Arial" Font-Size="Small" > Capacity should be between 1-255
                        </asp:RangeValidator>    
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("capacity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Building" SortExpression="locationBuildingId">
                    <EditItemTemplate>                         
                        <asp:DropDownList  
                            ID="buildingDropDownList" 
                            runat="server" 
                            DataSourceID="Building_SqlDataSource" 
                            AppendDataBoundItems="true"   
                            SelectedValue='<%#Bind("locationBuildingId") %>' 
                            DataMember="DefaultView"
                            DataTextField="name" 
                            DataValueField="id" >                        
                         </asp:DropDownList>                                     
                    </EditItemTemplate>
                    <ItemTemplate>
                    <asp:DropDownList  
                            ID="buildingDropDownList2" 
                            runat="server" 
                            DataSourceID="Building_SqlDataSource" 
                            AppendDataBoundItems="true"   
                            Enabled ="false" 
                            SelectedValue='<%#Bind("locationBuildingId") %>' 
                            DataMember="DefaultView"
                            DataTextField="name" 
                            DataValueField="id" >                        
                         </asp:DropDownList>     
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="createdBy" HeaderText="createdBy" 
                    SortExpression="createdBy" Visible="False" />
                <asp:BoundField DataField="createdAt" HeaderText="createdAt" 
                    SortExpression="createdAt" Visible="False" />
            </Columns>
            <EmptyDataRowStyle ForeColor="Red" />  
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" 
                HorizontalAlign="Left" Width="100px" Wrap="True" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
                      
    </form>
</body>
</html>
