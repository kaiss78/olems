using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OLEMS.SectionManagement
{
    public partial class StudentSectionManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void StudentSectionRowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

            //            ApplyFilter();
            //            if (e.Exception == null)
            {
                ShowMessageBox("Section successfully updated");
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

    }
}
