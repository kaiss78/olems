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
using System.Data.SqlClient;

namespace OLEMS.Examination
{
    public partial class Default : COLEMSPage
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
                ShowMessageBox("Select exam to take!");
                return;
            }
            else
            {
                String strStartingPassword = txtPassword.Text.Trim().ToString(); //öğrencinin elle girdiği password
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gStudentExaminationId = new Guid(GridView1.SelectedDataKey.Value.ToString());

                SqlCommand sqlQueryString = new SqlCommand();
                sqlQueryString.CommandType = CommandType.Text;
                sqlQueryString.CommandText = "SELECT 'True' " +
"FROM StudentExamination INNER JOIN " +
"Examination ON StudentExamination.examinationId = Examination.id " +
"WHERE (StudentExamination.id = @StudentExaminationId) AND (Examination.startingPassword = @startingPassword)";
                sqlQueryString.Connection = conn;

                SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                StudentExaminationId.Value = gStudentExaminationId;
                sqlQueryString.Parameters.Add(StudentExaminationId);

                SqlParameter startingPassword = new SqlParameter("@startingPassword", strStartingPassword);
                sqlQueryString.Parameters.Add(startingPassword);

                object resultE = null;
                ConnectionState previousConnectionState = conn.State;
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    resultE = sqlQueryString.ExecuteScalar();
                }
                finally
                {
                    if (previousConnectionState == ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
                if (resultE == null)
                {
                    ShowMessageBox("Incorrect Password!");
                }
                else
                {
                    Session["StudentExaminationGUID"] = new Guid(GridView1.SelectedDataKey.Value.ToString());
                    Response.Redirect("~/Examination/Examination.aspx", true);
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
    }
}
