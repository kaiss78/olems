using System;
using System.Web.Security;
namespace OLEMS.Restricted
{
    public partial class ChangePassword : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ChangePasswordOLEMS_ChangedPassword(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("StudentMustChangePassword"))
            {
                Roles.AddUserToRole(User.Identity.Name.ToString(), "Student");
                Roles.RemoveUserFromRole(User.Identity.Name.ToString(), "StudentMustChangePassword");
                Response.Redirect("~/Springboard.aspx");
            }
        }
    }
}
