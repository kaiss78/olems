using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;

namespace OLEMS.UserManagement
{
    public partial class EditEmailAddress : COLEMSPage
    {
        private string a_strInitialEmail;
        private MembershipUser a_currentUser;

        public void seta_strInitialEmail(string strIn)
        {
            a_strInitialEmail = strIn;
        }
        public string geta_strInitialEmail()
        {
            return a_strInitialEmail;
        }
        public void seta_currentUser(MembershipUser objIn)
        {
            a_currentUser = objIn;
        }
        public MembershipUser geta_currentUser()
        {
            return a_currentUser;
        }
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

        protected void lnkUpdateEmailAddress_Click(object sender, EventArgs e)
        {
            if (lblDisplayMessage.Text == "")
            {
            }
            else
            {
                lblDisplayMessage.Text = "";

            }
            if (a_strInitialEmail == txtEmailAddress.Text)
            {
            }
            else
            {
                try
                {
                    a_currentUser.Email = txtEmailAddress.Text;
                    Membership.UpdateUser(a_currentUser);
                    lblDisplayMessage.Text = Resources.Errors.successfulEmailUpdate;
                }
                catch (System.Configuration.Provider.ProviderException mException)
                {
                    lblDisplayMessage.Text = mException.Message;
                }
                finally
                {
                }
            }
        }

        protected void lnkCancelUpdateEmailAddress_Click(object sender, EventArgs e)
        {
            if (lblDisplayMessage.Text == "")
            {
            }
            else
            {
                lblDisplayMessage.Text = "";
            }
            if (a_strInitialEmail == txtEmailAddress.Text)
            {
                divDiscardChanges.Visible = false;
                txtEmailAddress.Text = a_strInitialEmail;
            }
            else
            {
                divDiscardChanges.Visible = true;
            }
        }

        protected void lnkNoDiscardChanges_Click(object sender, EventArgs e)
        {
            divDiscardChanges.Visible = false;
        }

        protected void lnkYesDiscardChanges_Click(object sender, EventArgs e)
        {
            a_strInitialEmail = a_currentUser.Email;
            txtEmailAddress.Text = a_strInitialEmail;
            divDiscardChanges.Visible = false;

        }
    }
}
