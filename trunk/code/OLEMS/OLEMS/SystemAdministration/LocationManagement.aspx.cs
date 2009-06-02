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

namespace OLEMS.SystemAdministration
{
    public partial class LocationManagement : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            String sorgu;
            sorgu = "1=1";
            LocationGridView.EditIndex = -1;
            TextBox txtLocation = (TextBox)LocationDetailsView.Rows[0].FindControl("txtName");
            sorgu = sorgu + " AND name like '%" + txtLocation.Text + "%'";
            TextBox txtCapacity = (TextBox)LocationDetailsView.Rows[0].FindControl("txtCapacity");
            if (txtCapacity.Text != "") //boş değilse
            {
                sorgu = sorgu + " AND capacity =" + Convert.ToInt16(txtCapacity.Text);
            }
            if (SearchAllCheckBox.Checked == false) //eğer tek bir bina seçildiyse
            {
                DropDownList building = (DropDownList)LocationDetailsView.Rows[0].FindControl("buildingDropDownList");
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
            if (e.Exception == null)
            {
                ShowMessageBox("Location successfully updated");
            }
        }

        protected void ShowMessageBox(string message)
        {
            // Define the name and type of the client scripts on the page.
            String csname = "MessageBox";
            Type cstype = this.GetType();

            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, csname))
            {
                String cstext = "alert('" + message + "');";
                cs.RegisterStartupScript(cstype, csname, cstext, true);
            }
            //string sJavaScript = "<script language=javascript>\n";
            //sJavaScript += "alert('" + message + "');\n";
            //sJavaScript += "</script>";
            //this.RegisterStartupScript("MessageBox", sJavaScript);
        }

        protected void LocationDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Location successfully created");
            } 
        }

        protected void LocationGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Location successfully deleted");
            }
        }

    }
}
