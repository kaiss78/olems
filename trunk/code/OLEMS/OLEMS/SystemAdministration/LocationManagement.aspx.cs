using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class UI_QuestionDevelopment_LocationManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lnkSearch_Click(object sender, EventArgs e)
    {
        String sorgu;
        sorgu = "1=1";
        LocationGridView.EditIndex = -1;
        TextBox txtLocation = (TextBox) LocationDetailsView.Rows[0].FindControl("txtName");
        sorgu = sorgu + " AND name like '%" + txtLocation.Text + "%'";
        TextBox txtCapacity = (TextBox) LocationDetailsView.Rows[0].FindControl("txtCapacity");
        if (txtCapacity.Text != "") //boş değilse
        {
            sorgu = sorgu + " AND capacity =" + Convert.ToInt16(txtCapacity.Text);
        }
        if (SearchAllCheckBox.Checked == false) //eğer tek bir bina seçildiyse
        {
            DropDownList building = (DropDownList) LocationDetailsView.Rows[0].FindControl("buildingDropDownList");
            sorgu = sorgu + " AND locationBuildingId ='" + building.SelectedValue + "'";
        }
        Session["LocationFilter"] = sorgu; //filter bilgisini başka eventlerde kullanmak için session'da bir değişken olarak saklarız
        Location_SqlDataSource.FilterExpression = sorgu;
    }
   
    protected void ApplyFilter()
    {
       //bu yordam filtrelenmiş bir satırın edit edilebilmesi ve herhangi bir işlem yapıldıktan sonra filtrenin hala kalması için yazıldı
        Location_SqlDataSource.FilterExpression = (string)(Session["LocationFilter"]);
        LocationGridView.DataBind();
    }

    protected void LocationGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        ApplyFilter();
    }
    
    protected void LocationGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        ApplyFilter();
    }
}
