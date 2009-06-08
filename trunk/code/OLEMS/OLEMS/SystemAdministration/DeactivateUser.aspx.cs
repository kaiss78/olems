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

namespace OLEMS.SystemAdministration
{
    public partial class DeactivateUser : COLEMSPage
    {
        private MembershipUserCollection users;
        private MembershipUser u;

        protected void Page_Load(object sender, EventArgs e)
        {
            users = Membership.GetAllUsers();

            if (!IsPostBack)
            {
                // Bind users to ListBox.
                UsersListBox.DataSource = users;
                UsersListBox.DataBind();
            }


            // If a user is selected, show the properties for the selected user.

            if (UsersListBox.SelectedItem != null)
            {
                u = users[UsersListBox.SelectedItem.Value];

                EmailLabel.Text = u.Email;
                IsOnlineLabel.Text = u.IsOnline.ToString();
                LastLoginDateLabel.Text = u.LastLoginDate.ToString();
                CreationDateLabel.Text = u.CreationDate.ToString();
                LastActivityDateLabel.Text = u.LastActivityDate.ToString();
                CanLoginLabel.Text = u.IsApproved.ToString();
            }
        }

        protected void DeactivateUserButton_Click(object sender, EventArgs e)
        {
            if (UsersListBox.SelectedItem == null)
            {
                return;
            }
            else if (u.IsApproved == true)
            {
                u.IsApproved = false;
                Membership.UpdateUser(u);
            }
            else
            {
                return;
            }

        }


    }
}
