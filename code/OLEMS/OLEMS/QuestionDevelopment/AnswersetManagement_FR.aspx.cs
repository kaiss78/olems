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
            String questionID = Request.QueryString["questionID"].ToString();
            ChoicesSqlDataSource.SelectCommand = "SELECT [id], [questionId], [body] FROM [Choice] where [questionId]='" + questionID + "'";
            ChoicesSqlDataSource.UpdateParameters["id"].DefaultValue = questionID;
            ChoicesSqlDataSource.DeleteParameters["id"].DefaultValue = questionID;
            ChoicesSqlDataSource.InsertParameters["questionId"].DefaultValue = questionID;
            QuestionSqlDataSource.SelectCommand = "SELECT [body] FROM [Question] where [id]='" + questionID + "'";
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
