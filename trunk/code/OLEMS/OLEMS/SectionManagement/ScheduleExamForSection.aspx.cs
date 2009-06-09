using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OLEMS.SectionManagement
{
    public partial class ScheduleExamForSection : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.ExaminationDetailsView.CurrentMode == DetailsViewMode.Insert)
            {
                TextBox txtBox = new TextBox();
                txtBox = (TextBox)this.ExaminationDetailsView.FindControl("startedAt");
                txtBox.Text = System.DateTime.Now.ToLongTimeString();
            }
        }

        protected void ExaminationDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ShowMessageBox("Could not schedule exam");
            }
            else // if (e.Exception == null)
            {
                ShowMessageBox("Exam is successfully scheduled for the section");
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
