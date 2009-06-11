using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace OLEMS.StartExam
{
    public partial class StartActiveExam : System.Web.UI.Page
    {

        static SqlConnection conn = null;

        private static SqlConnection getConnection()
        {
            if (conn == null)
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["IS50220082G4_ConnectionString"].ConnectionString);
            }
            return conn;
        }

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

        protected void btnGeneratePasswd_Click(object sender, EventArgs e)
        {
            
            String passwd = "";

            Random random = new Random();
            int passwdCount = random.Next(7, 10);

            for (int i = 1; i <= passwdCount; i++)
            {
                int randnum = random.Next(10);
                passwd = passwd + System.Convert.ToString(randnum);
            }

            txtPassword.Text = passwd;
            btnStartActiveExam.Enabled = true;

        }

        protected void btnStartActiveExam_Click(object sender, EventArgs e)
        {
            Label lblExamination = (Label)DetailsViewExamination.FindControl("lblExaminationId");
            String passwd = txtPassword.Text;

            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                SqlCommand comm = new SqlCommand("UPDATE Examination SET startingPassword = @startingPassword, startedAt = (SELECT getdate()) WHERE id = @examinationId", conn);
                comm.Parameters.Add(new SqlParameter("@examinationId", lblExamination.Text));
                comm.Parameters.Add(new SqlParameter("@startingPassword", passwd));

                int result = comm.ExecuteNonQuery();

                if (result > 0)
                {
                    ShowMessageBox("Exam is started successfully.");
                }
                else
                {
                    ShowMessageBox("Exam cannot be started. Please try again.");
                }

            }
            finally
            {

                if (conn != null)
                {
                    conn.Close();
                }
            }

            GridView1.DataBind();
            //DetailsViewExamination.DataBind();
        }

        protected void btnExtendExam_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedRow == null)
            {
                ShowMessageBox("Please select a student");
                return;
            }

            int extensionMinutes = 0;
            try
            {
                extensionMinutes = System.Convert.ToInt16(txtMin.Text);
                if (extensionMinutes == 0)
                {
                    lblError.Text = "Please enter number for extension minutes.";
                    return;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Please enter number for extension minutes.";
                return;
            }

            Label lblStudentExamination = (Label)GridView1.SelectedRow.FindControl("lblSexaminationId");

            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                SqlCommand comm = new SqlCommand("INSERT INTO StudentExaminationExtended(studentExaminationId, extendedMinutes) VALUES(@examinationId,@extension)", conn);
                comm.Parameters.Add(new SqlParameter("@extension", extensionMinutes));
                comm.Parameters.Add(new SqlParameter("@examinationId", lblStudentExamination.Text));

                int result = comm.ExecuteNonQuery();

                if (result > 0)
                {
                    ShowMessageBox("Students duration is extended successfully.");
                    lblError.Text = "";
                }
                else
                {
                    ShowMessageBox("Error. Please try again.");
                }

            }
            finally
            {

                if (conn != null)
                {
                    conn.Close();
                }
            }

        }

        protected void btnFinalize_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedRow == null)
            {
                lblError.Text = "Please select a student";
                return;
            }

            Label lblStudentExamination = (Label)GridView1.SelectedRow.FindControl("lblSexaminationId");

            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                SqlCommand comControl = new SqlCommand("SELECT finalizedAt FROM StudentExamination WHERE id = @studentExaminationId", conn);
                comControl.Parameters.Add(new SqlParameter("@studentExaminationId", lblStudentExamination.Text));

                Object onull = (Object)comControl.ExecuteScalar();
                if (!onull.Equals(System.DBNull.Value))
                {
                    lblError.Text = "Student's exam has been already finalized.";
                    return;
                }

                SqlCommand comm = new SqlCommand("UPDATE StudentExamination SET finalizedAt = (SELECT getdate()) WHERE id = @studentExaminationId", conn);
                comm.Parameters.Add(new SqlParameter("@studentExaminationId", lblStudentExamination.Text));

                int result = (int)comm.ExecuteNonQuery();

                if (result > 0)
                {
                    ShowMessageBox("Student's exam is finalized successfully.");
                    lblError.Text = "";
                }
                else
                {
                    lblError.Text = "Error. Please try again.";
                }

            }
            finally
            {

                if (conn != null)
                {
                    conn.Close();
                }
            }

        }
    }
}
