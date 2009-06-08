using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace OLEMS.SectionManagement
{
    public partial class SectionInstructorManagement : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ApplyFilter()
        {
            //bu yordam filtrelenmiş bir satırın edit edilebilmesi ve herhangi bir işlem yapıldıktan sonra filtrenin hala kalması için yazıldı
            SectionInstructorSqlDataSource.FilterExpression = (string)(Session["SectionInstructorFilter"]);
            SectionInstructorGridView.DataBind();
        }

        protected void SectionInstructorGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplyFilter();
        }

        protected void SectionInstructorGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            ApplyFilter();
            if (e.Exception == null)
            {
                ShowMessageBox("Section Instructor successfully updated");
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

    }
}
