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

namespace OLEMS.SectionManagement
{
    public partial class CreateSection : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            String sorgu = "";
            TextBox txtSection = (TextBox)SectionDetailsView.Rows[0].FindControl("txtName");
            sorgu = "name like '%" + txtSection.Text + "%'";
            Session["TopicFilter"] = sorgu;//filter bilgisini başka eventlerde kullanmak için session'da bir değişken olarak saklarız
            Section_SqlDataSource.FilterExpression = sorgu;
        }

        protected void ApplyFilter()
        {
            //bu yordam filtrelenmiş bir satırın edit edilebilmesi ve herhangi bir işlem yapıldıktan sonra filtrenin hala kalması için yazıldı
            Section_SqlDataSource.FilterExpression = (string)(Session["SectionFilter"]);
            SectionGridView.DataBind();
        }

        protected void SectionGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplyFilter();
        }

        protected void SectionGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            ApplyFilter();
            if (e.Exception == null)
            {
                ShowMessageBox("Section successfully updated");
            }
        }

        protected void SectionDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ShowMessageBox("Existing Section");
            }
            else // if (e.Exception == null)
            {
                ShowMessageBox("Section successfully created");
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
        }

        protected void SectionGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ShowMessageBox("Section deletion is unsuccessful" );
            }
            else //if (e.Exception == null)
            {
                ShowMessageBox("Section successfully deleted");
            }
        }
    }
}
