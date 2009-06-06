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
    public partial class CreateNewUser : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            if (e.CurrentStepIndex == 1)
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                Guid gUserId = new Guid(Membership.GetUser(CreateUserWizard1.UserName).ProviderUserKey.ToString());

                SqlCommand sqlInsertCmdUsers = new SqlCommand();
                sqlInsertCmdUsers.CommandType = CommandType.Text;
                sqlInsertCmdUsers.CommandText = "INSERT INTO Users(UserId, name, surname) VALUES (@UserId, @name, @surname)";
                sqlInsertCmdUsers.Connection = conn;

                SqlParameter UsersUserId = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
                UsersUserId.Value = gUserId;
                sqlInsertCmdUsers.Parameters.Add(UsersUserId);

                SqlParameter name = new SqlParameter("@name", firstName.Text);
                sqlInsertCmdUsers.Parameters.Add(name);

                SqlParameter surname = new SqlParameter("@surname", lastName.Text);
                sqlInsertCmdUsers.Parameters.Add(surname);

                object resultRUsers;
                ConnectionState previousConnectionState = conn.State;
                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    resultRUsers = sqlInsertCmdUsers.ExecuteScalar();
                }
                finally
                {
                    if (previousConnectionState == ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
            }
        }
    }
}
