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
    public partial class RemoveUsersFromRole : COLEMSPage
    {
        string[] rolesArray;
        string[] users;

        protected void Page_Load()
        {
            Msg.Text = "";

            if (!IsPostBack)
            {
                // Bind roles to ListBox.

                rolesArray = Roles.GetAllRoles();
                RolesListBox.DataSource = rolesArray;
                RolesListBox.DataBind();
            }
        }

        public void RolesListBox_OnSelectedIndexChanged(object sender, EventArgs args)
        {
            // Bind users to ListBox.

            users = Roles.GetUsersInRole(RolesListBox.SelectedItem.Value);
            UsersListBox.DataSource = users;
            UsersListBox.DataBind();
        }

        public void RemoveUsers_OnClick(object sender, EventArgs args)
        {
            // Verify that at least one user and a role are selected.

            int[] user_indices = UsersListBox.GetSelectedIndices();

            if (user_indices.Length == 0)
            {
                Msg.Text = "Please select one or more users.";
                return;
            }

            if (RolesListBox.SelectedItem == null)
            {
                Msg.Text = "Please select a role.";
                return;
            }


            // Create list of users to be removed from the selected role.

            string[] usersList = new string[user_indices.Length];

            for (int i = 0; i < usersList.Length; i++)
            {
                usersList[i] = UsersListBox.Items[user_indices[i]].Value;
            }


            // Remove the users from the selected role.

            try
            {
                Roles.RemoveUsersFromRole(usersList, RolesListBox.SelectedItem.Value);
                Msg.Text = "User(s) removed from Role.";

                // Rebind users to ListBox.

                users = Roles.GetUsersInRole(RolesListBox.SelectedItem.Value);
                UsersListBox.DataSource = users;
                UsersListBox.DataBind();
            }
            catch (HttpException e)
            {
                Msg.Text = e.Message;
            }
        }
    }
}
