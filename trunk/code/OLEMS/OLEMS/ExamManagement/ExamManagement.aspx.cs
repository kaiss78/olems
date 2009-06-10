using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace OLEMS.ExamManagement
{
    public partial class ExamManagement1 : System.Web.UI.Page
    {
        int tol = 0;
        int dur = 0;
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

        protected void ExamGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            Label examID = (Label)ExamGridView.Rows[e.NewSelectedIndex].FindControl("lblExamID");
            
            String url = "AddQuestionsToExam.aspx";

            Session["edit"] = examID.Text;

            OpenNewWindow(url);
        }

        public void OpenNewWindow(string url)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "newWindow", String.Format("<script>window.open('{0}', '','toolbar=0,height=500,width=750,top=100,left=250,resizable=0,scrollbars=1');</script>", url));
        }

        protected void ExamDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Exam is successfully created");
            } 
        }

        private void DurationToleranceCheck()
        {
            TextBox txtTolerance = ExamDetailsView.FindControl("txtTolerance") as TextBox;
            TextBox txtDuration = ExamDetailsView.FindControl("txtDuration") as TextBox;

            if (txtTolerance.Text != null || !txtTolerance.Text.Equals(""))
            { tol = System.Convert.ToInt32(txtTolerance.Text); }

            if (txtDuration.Text != null || !txtDuration.Text.Equals(""))
            { dur = System.Convert.ToInt32(txtDuration.Text); }
        }

        protected void ExamDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (tol > (dur * 0.2))
            {
                ShowMessageBox("Tolerance should be less than or equal to 20% of the duration.");
                ExamDetailsView.FindControl("txtTolerance").Focus();
                e.Cancel = true;
            }
        }

        protected void ExamGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Label examId = (Label)ExamGridView.Rows[e.NewEditIndex].FindControl("lblExamID");

            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                SqlCommand cmdCount = new SqlCommand("SELECT DISTINCT COUNT(examId) FROM Examination WHERE examId=@examId", conn);
                cmdCount.Parameters.Add(new SqlParameter("@examId", examId.Text));

                int count = (int)cmdCount.ExecuteScalar();

                if (count > 0)
                {
                    ShowMessageBox("Exam cannot be allowed for editing. Exam is assigned to a section or taken by students.");
                    e.Cancel = true;
                }
                else
                {
                    if (tol > (dur * 0.2))
                    {
                        ShowMessageBox("Tolerance should be less than or equal to 20% of the duration.");
                        ExamGridView.Rows[e.NewEditIndex].FindControl("txtTolerance2").Focus();
                        e.Cancel = true;
                    }
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

        protected void ExamGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Exam is successfully updated");
            }
        }

        protected void ExamGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label examId = (Label)ExamGridView.Rows[e.RowIndex].FindControl("lblExamID");

            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                SqlCommand cmdCount = new SqlCommand("SELECT COUNT(*) FROM Examination WHERE examId = @examId", conn);
                cmdCount.Parameters.Add(new SqlParameter("@examId", examId.Text));

                int count = cmdCount.ExecuteNonQuery();

                if (count <= 0)
                {

                    SqlCommand cmd = new SqlCommand("DELETE FROM ExamQuestions WHERE examId = @examId", conn);
                    cmd.Parameters.Add(new SqlParameter("@examId", examId.Text));

                    cmd.ExecuteNonQuery();
                }
                else
                {
                    ShowMessageBox("Exam cannot be deleted. Exam is assigned to a section or taken by students.");
                    e.Cancel = true;
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

        protected void ExamGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Exam and questions of the exam are successfully deleted");
            }
        }

    }
}
