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
    public partial class Examination : COLEMSPage
    {
        private Boolean booQuestionAnswered;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (booQuestionAnswered)
                {
                    RadioButtonList1.SelectedIndex = -1;
                    booQuestionAnswered = false;
                    RadioButtonList1.DataBind();
                }
                else
                {
                }
            }
            else
            {
                booQuestionAnswered = false;
            }
            if (RadioButtonList1.SelectedIndex == -1)
            {
                MultiView1.Visible = false;
                booQuestionAnswered = false;
            }
            else
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gQuestionId = new Guid(RadioButtonList1.SelectedValue.ToString());

                SqlCommand sqlQueryString = new SqlCommand();
                sqlQueryString.CommandType = CommandType.Text;
                sqlQueryString.CommandText = "SELECT QuestionType.pagePath FROM Question INNER JOIN QuestionType ON Question.questionTypeId = QuestionType.id WHERE (Question.id = @questionId)";
                sqlQueryString.Connection = conn;

                SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                QuestionId.Value = gQuestionId;
                sqlQueryString.Parameters.Add(QuestionId);

                object resultR = null;
                ConnectionState previousConnectionState = conn.State;
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    resultR = sqlQueryString.ExecuteScalar();
                }
                finally
                {
                    if (previousConnectionState == ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
                if (resultR == null)
                {
                    MultiView1.Visible = false;
                }
                else
                {
                    switch (resultR.ToString())
                    {
                        case "FreeResponse":
                            MultiView1.Visible = true;
                            MultiView1.SetActiveView(FreeResponse);
                            break;
                        case "Matching":
                            MultiView1.Visible = true;
                            MultiView1.SetActiveView(Matching);
                            break;
                        case "TrueFalse":
                            MultiView1.Visible = true;
                            MultiView1.SetActiveView(TrueFalse);
                            break;
                        case "MultipleChoice":
                            MultiView1.Visible = true;
                            MultiView1.SetActiveView(MultipleChoice);
                            break;
                        default:
                            MultiView1.Visible = false;
                            break;
                    }
                }
            }
        }

        protected void RadioButtonList1_DataBound(object sender, EventArgs e)
        {
            if (RadioButtonList1.Items.Count > 0)
            {
                foreach (ListItem li in RadioButtonList1.Items)
                {
                    SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                    Guid gQuestionId = new Guid(li.Value.ToString());
                    Guid gStudentExaminationId = new Guid(Session["StudentExaminationGUID"].ToString());

                    SqlCommand sqlQueryString = new SqlCommand();
                    sqlQueryString.CommandType = CommandType.Text;
                    sqlQueryString.CommandText = "SELECT CASE " +
    "WHEN COUNT(StudentExaminationQuestionsResponse.id) = 0 THEN 'True' " +
    "ELSE 'False' END AS 'Enabled' " +
    "FROM StudentExaminationQuestions INNER JOIN " +
    "Question ON dbo.StudentExaminationQuestions.questionId = Question.id LEFT OUTER JOIN " +
    "StudentExaminationQuestionsResponse ON " +
    "StudentExaminationQuestions.id = StudentExaminationQuestionsResponse.studentExaminationQuestionsId " +
    "WHERE ((StudentExaminationQuestions.studentExaminationId = @studentExaminationId) AND (StudentExaminationQuestions.questionId = @questionId))";
                    sqlQueryString.Connection = conn;

                    SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                    QuestionId.Value = gQuestionId;
                    sqlQueryString.Parameters.Add(QuestionId);

                    SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                    StudentExaminationId.Value = gStudentExaminationId;
                    sqlQueryString.Parameters.Add(StudentExaminationId);

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

                    }
                    else
                    {
                        Boolean boolEnabled = new Boolean();
                        Boolean.TryParse(resultE.ToString(), out boolEnabled);
                        li.Enabled = boolEnabled;
                    }
                }
            }
        }

        protected void ButtonMultipleChoice_Click(object sender, EventArgs e)
        {
            if (RadioButtonListMultipleChoice.SelectedIndex == -1)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gStudentExaminationId = new Guid(Session["StudentExaminationGUID"].ToString());
                Guid gQuestionId = new Guid(RadioButtonList1.SelectedValue.ToString());

                Guid gChoiceId = new Guid(RadioButtonListMultipleChoice.SelectedValue.ToString());

                SqlCommand sqlQueryString = new SqlCommand();
                sqlQueryString.CommandType = CommandType.StoredProcedure;
                sqlQueryString.CommandText = "upStudentExaminationQuestionsResponse";
                sqlQueryString.Connection = conn;

                SqlParameter type = new SqlParameter("@type", "MultipleChoice");
                sqlQueryString.Parameters.Add(type);

                SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                StudentExaminationId.Value = gStudentExaminationId;
                sqlQueryString.Parameters.Add(StudentExaminationId);

                SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                QuestionId.Value = gQuestionId;
                sqlQueryString.Parameters.Add(QuestionId);

                SqlParameter ChoiceId = new SqlParameter("@choiceId", SqlDbType.UniqueIdentifier);
                ChoiceId.Value = gChoiceId;
                sqlQueryString.Parameters.Add(ChoiceId);

                SqlParameter responseValue = new SqlParameter("@responseValue", "True");
                sqlQueryString.Parameters.Add(responseValue);

                sqlQueryString.Connection.Open();
                sqlQueryString.ExecuteNonQuery();
                sqlQueryString.Connection.Close();

                booQuestionAnswered = true;
                RadioButtonList1.DataBind();
                MultiView1.Visible = false;

            }
        }

        protected void ButtonTrueFalse_Click(object sender, EventArgs e)
        {
            if (RadioButtonListTrueFalse.SelectedIndex == -1)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gStudentExaminationId = new Guid(Session["StudentExaminationGUID"].ToString());
                Guid gQuestionId = new Guid(RadioButtonList1.SelectedValue.ToString());

                Guid gChoiceId = new Guid(RadioButtonListTrueFalse.SelectedValue.ToString());

                SqlCommand sqlQueryString = new SqlCommand();
                sqlQueryString.CommandType = CommandType.StoredProcedure;
                sqlQueryString.CommandText = "upStudentExaminationQuestionsResponse";
                sqlQueryString.Connection = conn;

                SqlParameter type = new SqlParameter("@type", "TrueFalse");
                sqlQueryString.Parameters.Add(type);

                SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                StudentExaminationId.Value = gStudentExaminationId;
                sqlQueryString.Parameters.Add(StudentExaminationId);

                SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                QuestionId.Value = gQuestionId;
                sqlQueryString.Parameters.Add(QuestionId);

                SqlParameter ChoiceId = new SqlParameter("@choiceId", SqlDbType.UniqueIdentifier);
                ChoiceId.Value = gChoiceId;
                sqlQueryString.Parameters.Add(ChoiceId);

                SqlParameter responseValue = new SqlParameter("@responseValue", "True");
                sqlQueryString.Parameters.Add(responseValue);

                sqlQueryString.Connection.Open();
                sqlQueryString.ExecuteNonQuery();
                sqlQueryString.Connection.Close();

                booQuestionAnswered = true;
                RadioButtonList1.DataBind();
                MultiView1.Visible = false;
            }
        }

        protected void ButtonFreeResponse_Click(object sender, EventArgs e)
        {
            if (TextBoxFreeResponse.Text == String.Empty)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gStudentExaminationId = new Guid(Session["StudentExaminationGUID"].ToString());
                Guid gQuestionId = new Guid(RadioButtonList1.SelectedValue.ToString());

                SqlCommand sqlQueryString = new SqlCommand();
                sqlQueryString.CommandType = CommandType.StoredProcedure;
                sqlQueryString.CommandText = "upStudentExaminationQuestionsResponse";
                sqlQueryString.Connection = conn;

                SqlParameter type = new SqlParameter("@type", "FreeResponse");
                sqlQueryString.Parameters.Add(type);

                SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                StudentExaminationId.Value = gStudentExaminationId;
                sqlQueryString.Parameters.Add(StudentExaminationId);

                SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                QuestionId.Value = gQuestionId;
                sqlQueryString.Parameters.Add(QuestionId);

                SqlParameter ChoiceId = new SqlParameter("@choiceId", DBNull.Value);
                sqlQueryString.Parameters.Add(ChoiceId);

                SqlParameter responseValue = new SqlParameter("@responseValue", TextBoxFreeResponse.Text.Trim().ToString());
                sqlQueryString.Parameters.Add(responseValue);

                sqlQueryString.Connection.Open();
                sqlQueryString.ExecuteNonQuery();
                sqlQueryString.Connection.Close();

                booQuestionAnswered = true;
                RadioButtonList1.DataBind();
                MultiView1.Visible = false;
            }
        }

        protected void ButtonMatching_Click(object sender, EventArgs e)
        {
            if (ListBoxMatchingResponse.Items.Count == 0)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                if (ListBoxMatchingBody.Items.Count != 0)
                {
                    booQuestionAnswered = false;
                    return;
                }
                else
                {
                    if (ListBoxMatchingTruthValue.Items.Count != 0)
                    {
                        booQuestionAnswered = false;
                        return;
                    }
                    else
                    {
                        SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                        Guid gStudentExaminationId = new Guid(Session["StudentExaminationGUID"].ToString());
                        Guid gQuestionId = new Guid(RadioButtonList1.SelectedValue.ToString());

                        for (int i = 0; i < ListBoxMatchingResponse.Items.Count-1; i++)
                        {
                            Guid gChoiceId = new Guid(ListBoxMatchingResponse.Items[i].Value.ToString());

                            SqlCommand sqlQueryString = new SqlCommand();
                            sqlQueryString.CommandType = CommandType.StoredProcedure;
                            sqlQueryString.CommandText = "upStudentExaminationQuestionsResponse";
                            sqlQueryString.Connection = conn;

                            SqlParameter type = new SqlParameter("@type", "Matching");
                            sqlQueryString.Parameters.Add(type);

                            SqlParameter StudentExaminationId = new SqlParameter("@studentExaminationId", SqlDbType.UniqueIdentifier);
                            StudentExaminationId.Value = gStudentExaminationId;
                            sqlQueryString.Parameters.Add(StudentExaminationId);

                            SqlParameter QuestionId = new SqlParameter("@questionId", SqlDbType.UniqueIdentifier);
                            QuestionId.Value = gQuestionId;
                            sqlQueryString.Parameters.Add(QuestionId);

                            SqlParameter ChoiceId = new SqlParameter("@choiceId", SqlDbType.UniqueIdentifier);
                            ChoiceId.Value = gChoiceId;
                            sqlQueryString.Parameters.Add(ChoiceId);

                            int intWhereToSeparate;
                            string strSeparator = ConfigurationManager.AppSettings["Default.MatchingQuestionMatchSeparator"];
                            string strToSeparate = ListBoxMatchingResponse.Items[i].Text.ToString();
                            intWhereToSeparate = strToSeparate.IndexOf(strSeparator);
                            string strTruthValue = strToSeparate.Substring(intWhereToSeparate + strSeparator.Length);

                            SqlParameter responseValue = new SqlParameter("@responseValue", strTruthValue);
                            sqlQueryString.Parameters.Add(responseValue);

                            sqlQueryString.Connection.Open();
                            sqlQueryString.ExecuteNonQuery();
                            sqlQueryString.Connection.Close();

                            booQuestionAnswered = true;
                            RadioButtonList1.DataBind();
                            MultiView1.Visible = false;
                        }
                    }
                }
            }
        }

        protected void ButtonMatch_Click(object sender, EventArgs e)
        {
            if (ListBoxMatchingBody.SelectedIndex == -1)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                if (ListBoxMatchingTruthValue.SelectedIndex == -1)
                {
                    booQuestionAnswered = false;
                    return;
                }
                else
                {
                    ListItem li = new ListItem(ListBoxMatchingBody.SelectedItem.Text.ToString() + ConfigurationManager.AppSettings["Default.MatchingQuestionMatchSeparator"] + ListBoxMatchingTruthValue.SelectedItem.Text.ToString(), ListBoxMatchingBody.SelectedItem.Value.ToString());
                    ListBoxMatchingResponse.Items.Add(li);
                    ListBoxMatchingBody.Items.RemoveAt(ListBoxMatchingBody.SelectedIndex);
                    ListBoxMatchingTruthValue.Items.RemoveAt(ListBoxMatchingTruthValue.SelectedIndex);

                    booQuestionAnswered = false;
                }
            }
        }

        protected void ButtonUnmatch_Click(object sender, EventArgs e)
        {
            if (ListBoxMatchingResponse.SelectedIndex == -1)
            {
                booQuestionAnswered = false;
                return;
            }
            else
            {
                int intWhereToSeparate;
                string strSeparator = ConfigurationManager.AppSettings["Default.MatchingQuestionMatchSeparator"];
                string strToSeparate = ListBoxMatchingResponse.SelectedItem.Text.ToString();
                intWhereToSeparate = strToSeparate.IndexOf(strSeparator);
                string strBody = strToSeparate.Substring(0, intWhereToSeparate + 1);
                string strTruthValue = strToSeparate.Substring(intWhereToSeparate + strSeparator.Length);

                ListItem liBody = new ListItem(strBody, ListBoxMatchingResponse.SelectedValue.ToString());
                ListBoxMatchingBody.Items.Add(liBody);

                ListItem liTruthValue = new ListItem(strTruthValue, strTruthValue);
                ListBoxMatchingTruthValue.Items.Add(liTruthValue);

                ListBoxMatchingResponse.Items.RemoveAt(ListBoxMatchingResponse.SelectedIndex);

                booQuestionAnswered = false;
            }
        }

        protected void ListBoxMatchingTruthValue_DataBound(object sender, EventArgs e)
        {
            ListBoxMatchingResponse.Items.Clear();
        }
    }
}
