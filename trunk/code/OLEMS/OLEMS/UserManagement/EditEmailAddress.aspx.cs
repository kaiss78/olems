using System;
using System.Web.Security;
namespace OLEMS.UserManagement
{
    public partial class EditEmailAddress : COLEMSPage
    {
        private string a_strInitialEmail;
        private MembershipUser a_currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            a_currentUser = Membership.GetUser();
            a_strInitialEmail = a_currentUser.Email;
            if (Page.IsPostBack)
            {
            }
            else
            {
                if (lblDisplayMessage.Text == "")
                {
                }
                else
                {
                    lblDisplayMessage.Text = "";
                }
            }
            txtEmailAddress.Text = a_strInitialEmail;
            divDiscardChanges.Visible = false;


        }
    }
}
