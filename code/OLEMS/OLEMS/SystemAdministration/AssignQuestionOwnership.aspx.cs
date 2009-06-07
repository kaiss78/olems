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

namespace OLEMS.SystemAdministration
{
    public partial class AssignQuestionOwnership : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Msg.Text = "";

        }

        protected void AssignQuestion_OnClick(object sender, EventArgs e)
        {
            // Verify that at least ex-instructor or new instructor is selected.

            if (AssignFromListBox.SelectedItem == null)
            {
                Msg.Text = GetLocalResourceObject("AssignFromMsg").ToString();
                return;
            }

            if (AssignToListBox.SelectedItem == null)
            {
                Msg.Text = GetLocalResourceObject("AssignToMsg").ToString();
                return;
            }
            try
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                SqlCommand sqlUpdateCmdQuestion = new SqlCommand();
                sqlUpdateCmdQuestion.CommandType = CommandType.Text;
                sqlUpdateCmdQuestion.CommandText = "UPDATE Question SET createdBy = @createdByNew WHERE createdBy = @createdByOld";
                sqlUpdateCmdQuestion.Connection = conn;

                SqlParameter createdByNew = new SqlParameter("@createdByNew", AssignToListBox.SelectedItem.Value);
                sqlUpdateCmdQuestion.Parameters.Add(createdByNew);

                SqlParameter createdByOld = new SqlParameter("@createdByOld", AssignFromListBox.SelectedItem.Value);
                sqlUpdateCmdQuestion.Parameters.Add(createdByOld);

                object resultR;
                ConnectionState previousConnectionState = conn.State;
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    resultR = sqlUpdateCmdQuestion.ExecuteScalar();
                }
                finally
                {
                    if (previousConnectionState == ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
            }
            catch
            {
                Msg.Text = "An error condition has prevented from updating questions.";
            }
            Msg.Text = GetLocalResourceObject("AssignSuccessMsg").ToString();

        }
    }
}
