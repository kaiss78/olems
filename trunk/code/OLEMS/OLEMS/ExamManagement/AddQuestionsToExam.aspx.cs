using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Drawing;

namespace OLEMS.ExamManagement
{
    public partial class AddQuestionsToExam : System.Web.UI.Page
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
            TableRow tr = new TableRow();
        }

        protected void TopicDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            String tId = TopicDropDownList.SelectedValue;
            SqlConnection conn = getConnection();

            try
            {
                conn.Open();

                QNumberDropDownList.Items.Clear();

                SqlCommand cmdCount = new SqlCommand("SELECT COUNT(*) FROM Question where topicId=@topicId", conn);
                cmdCount.Parameters.Add(new SqlParameter("@topicId", tId));
                int questionNumber = (int)cmdCount.ExecuteScalar();
                if (questionNumber > 0)
                {
                    QNumberDropDownList.Enabled = true;
                    for (int i = 1; i <= questionNumber; i++)
                    {
                        QNumberDropDownList.Items.Add(i.ToString());
                    }
                }
                else
                {
                    QNumberDropDownList.Enabled = false;
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

        protected void lnkAddQuestions_Click(object sender, EventArgs e)
        {
            if (QNumberDropDownList.SelectedValue != null && !QNumberDropDownList.SelectedValue.Equals(""))
            {
                String examId = (String)Session["edit"];
                int questionCount = System.Convert.ToInt16(QNumberDropDownList.SelectedValue);
                String selectedTopic = TopicDropDownList.SelectedValue;
                SqlConnection conn = getConnection();

                try
                {
                    conn.Open();

                    SqlCommand cmdCount = new SqlCommand("SELECT DISTINCT COUNT(examId) FROM Examination WHERE examId=@examId", conn);
                    cmdCount.Parameters.Add(new SqlParameter("@examId", examId));

                    int count = (int)cmdCount.ExecuteScalar();

                    if (count > 0)
                    {
                        lblError.ForeColor = Color.Red;
                        lblError.Text = "Exam cannot be allowed for editing. Exam is assigned to a section or taken by students.";
                    }
                    else
                    {

                        SqlCommand qNumber = new SqlCommand("SELECT Count(questionId) FROM ExamQuestions WHERE questionId IN (SELECT Question.id FROM Question WHERE Question.topicId = @topicId) AND ExamQuestions.examId = @examId", conn);
                        qNumber.Parameters.Add(new SqlParameter("@topicId", selectedTopic));
                        qNumber.Parameters.Add(new SqlParameter("@examId", examId));
                        int qCount = (int)qNumber.ExecuteScalar();

                        SqlCommand qBankNumber = new SqlCommand("SELECT Count(*) FROM Question WHERE Question.topicId = @topicId", conn);
                        qBankNumber.Parameters.Add(new SqlParameter("@topicId", selectedTopic));
                        int qBankCount = (int)qBankNumber.ExecuteScalar();

                        if ((qBankCount - qCount) == 0)
                        {
                            lblError.Text = "All questions from selected topic have been added to the exam before.";
                        }
                        else if ((qBankCount - qCount) < questionCount)
                        {
                            lblError.Text = "Please choose a small number of questions. Only -" + (qBankCount - qCount) + "- question(s) can be added from selected topic.";
                        }
                        else
                        {
                            SqlCommand cmd = new SqlCommand("SELECT TOP " + questionCount + " id FROM Question where topicId=@topicId and id not in(select questionId from ExamQuestions where examId=@examId) ORDER BY NEWID()", conn);


                            cmd.Parameters.Add(new SqlParameter("@topicId", selectedTopic));
                            cmd.Parameters.Add(new SqlParameter("@examId", examId));

                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                            DataSet dataSet = new DataSet();

                            adapter.Fill(dataSet);

                            foreach (DataRow dRow in dataSet.Tables[0].Rows)
                            {
                                SqlCommand cmd2 = new SqlCommand("INSERT INTO ExamQuestions (examId, questionId) VALUES ('" + examId + "', '" + dRow.ItemArray[0].ToString() + "')", conn);
                                cmd2.ExecuteNonQuery();
                            }

                            lblError.Text = "";
                            ShowMessageBox("Question(s) is added to the exam successfully.");
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

                GridView1.DataBind();
                
            }
            else
            {
                lblError.ForeColor = Color.Red;
                lblError.Text = "Please choose another topic. There is no questions from the selected topic.";
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lblQuestionId = (Label)GridView1.Rows[e.RowIndex].FindControl("lblQuestion");

            SqlConnection conn = getConnection();

            try {
                conn.Open();
                String examId = (String)Session["edit"];

                SqlCommand sqlCom = new SqlCommand (
                "DELETE FROM ExamQuestions " +
                "WHERE '" + examId + "' NOT IN (SELECT Examination.examId FROM Examination) " +
                "AND '" + examId + "' IN " +
                "(SELECT ExamQuestions.examId WHERE ExamQuestions.questionId = '" + lblQuestionId.Text + "')", conn);

                int deletedRowNumber = (int)sqlCom.ExecuteNonQuery();
                
                if (deletedRowNumber == 0)
                {
                    lblError.ForeColor = Color.Red;
                    lblError.Text = "Question of the exam cannot be deleted. Exam is assigned to a section or taken by students.";
                    e.Cancel = true;
                }
                else
                {
                    lblError.Text = "";
                    ShowMessageBox("Question of exam is deleted successfully.");
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
