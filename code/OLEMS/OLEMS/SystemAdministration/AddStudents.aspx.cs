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
using System.IO;
using System.Data.SqlClient;

namespace OLEMS.SystemAdministration
{
    public partial class AddStudents : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                Stream uploadedFile = FileUpload1.PostedFile.InputStream;
                DataSet data = BuildDataSetFromDelimitedFile(uploadedFile, "MyTable", ",");
                GridView1.DataSource = data;
                GridView1.DataBind();
                LabelInfo.Text = "Text file read successfully.";
                divReadTextFile.Visible = true;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));
                int intLength = 0;
                bool resultLength = int.TryParse(ConfigurationManager.AppSettings["RandomPassword.length"], out intLength);
                int intAlphaChars = 0;
                bool resultAlphaChars = int.TryParse(ConfigurationManager.AppSettings["RandomPassword.numberOfNonAlphanumericCharacters"], out intAlphaChars);
                for (int i = 0; i < GridView1.Rows.Count; i++)
                {
                    string strStudentId = GridView1.Rows[i].Cells[0].Text.ToString();
                    string strStudentSurname = GridView1.Rows[i].Cells[1].Text.ToString();
                    string strStudentName = GridView1.Rows[i].Cells[2].Text.ToString();
                    string strStudentEmail = "e" + strStudentId + "@metu.edu.tr";
                    string strStudentUserName = "e" + strStudentId;
                    //string strStudentPassword = Membership.GeneratePassword(intLength, intAlphaChars);
                    string strStudentPassword = strStudentId;
                    MembershipCreateStatus mcs = new MembershipCreateStatus();
                    Membership.CreateUser(strStudentUserName, strStudentPassword, strStudentEmail, "Adın?", "Soyadın.", true, out mcs);
                    if (mcs == MembershipCreateStatus.Success)
                    {
                        try
                        {
                            if (Roles.IsUserInRole(strStudentUserName, "Student"))
                            {
                                break;
                            }
                        }
                        catch
                        {
                            break;
                        }
                        try
                        {
                            if (Roles.IsUserInRole(strStudentUserName, "StudentMustChangePassword"))
                            {
                                break;
                            }
                        }
                        catch
                        {
                            break;
                        }
                        Roles.AddUserToRole(strStudentUserName, "StudentMustChangePassword");

                        Guid gUserId = new Guid(Membership.GetUser(strStudentUserName).ProviderUserKey.ToString());

                        SqlCommand sqlInsertCmdUsers = new SqlCommand();
                        sqlInsertCmdUsers.CommandType = CommandType.Text;
                        sqlInsertCmdUsers.CommandText = "INSERT INTO Users(UserId, name, surname) VALUES (@UserId, @name, @surname)";
                        sqlInsertCmdUsers.Connection = conn;

                        SqlParameter UsersUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                        UsersUserId.Value = gUserId;
                        sqlInsertCmdUsers.Parameters.Add(UsersUserId);

                        SqlParameter name = new SqlParameter("@name", strStudentName);
                        sqlInsertCmdUsers.Parameters.Add(name);

                        SqlParameter surname = new SqlParameter("@surname", strStudentSurname);
                        sqlInsertCmdUsers.Parameters.Add(surname);

                        SqlCommand sqlInsertCmdStudent = new SqlCommand();
                        sqlInsertCmdStudent.CommandType = CommandType.Text;
                        sqlInsertCmdStudent.CommandText = "INSERT INTO Student (UserId,sectionId,totalProficiencyTrials) VALUES(@UserId, @sectionId, @totalProficiencyTrials)";
                        sqlInsertCmdStudent.Connection = conn;

                        SqlParameter StudentUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                        StudentUserId.Value = gUserId;
                        sqlInsertCmdStudent.Parameters.Add(StudentUserId);

                        SqlParameter sectionId = new SqlParameter("@sectionId", DBNull.Value);
                        sqlInsertCmdStudent.Parameters.Add(sectionId);

                        int intDefault = 0;
                        SqlParameter totalProficiencyTrials = new SqlParameter("@totalProficiencyTrials", intDefault);
                        sqlInsertCmdStudent.Parameters.Add(totalProficiencyTrials);

                        object resultRUsers;
                        object resultRStudent;
                        ConnectionState previousConnectionState = conn.State;
                        try
                        {
                            if (conn.State == ConnectionState.Closed)
                            {
                                conn.Open();
                            }
                            resultRUsers = sqlInsertCmdUsers.ExecuteScalar();
                            resultRStudent = sqlInsertCmdStudent.ExecuteScalar();
                        }
                        finally
                        {
                            if (previousConnectionState == ConnectionState.Closed)
                            {
                                conn.Close();
                            }
                        }

                    }
                    else
                    {
                    }
                }

            }
            else
            {
            }
        }
    }
}
