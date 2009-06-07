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

namespace OLEMS.QuestionDevelopment
{
    public partial class AnswersetManagement_FR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //int questionID = Convert.ToInt32(Request.QueryString["questionID"].ToString());
            //int questionType = Convert.ToInt32(Request.QueryString["questionType"].ToString());
            ShowMessageBox("gelen q ID=" + Request.QueryString["questionID"].ToString()) ;
        }
    }
}
