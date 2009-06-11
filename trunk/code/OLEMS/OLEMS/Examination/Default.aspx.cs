using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace OLEMS.Examination
{
    public partial class Default : System.Web.UI.Page
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

        protected void btnTakeExam_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex == -1)
            {
                ShowMessageBox("Select section first!");
                return;
            }
            else
            {
                String pwd = txtPassword.Text; //öğrencinin elle girdiği password
                Label startingPassword = (Label)examPasswordDetailsView.Rows[0].FindControl("lblStartingPassword");
               

                    if (pwd == startingPassword.Text) // correct password
                    {
                        Session["StudentExaminationGUID"] = new Guid(GridView1.SelectedDataKey.Value.ToString());
                        Response.Redirect("~/Examination/Examination.aspx", true);
                    }
                    else
                    {
                        ShowMessageBox("Incorrect Password!");
                    }

            }
        }

        protected void btnDisplayExamResult_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex == -1)
            {
                return;
            }
            else
            {
                Session["StudentExaminationGUID"] = new Guid(GridView1.SelectedDataKey.Value.ToString());
                Response.Redirect("~/Examination/", true);

            }

        }

        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            Label examinationID = (Label)GridView1.Rows[e.NewSelectedIndex].FindControl("lblExaminationID");
            pwdSqlDataSource.SelectCommand = "SELECT [startingPassword] FROM [Examination] where [id]='" + examinationID.Text +"'";
           
        }
    }
}
