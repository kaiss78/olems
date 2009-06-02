using System;
using System.Web.Security;
namespace OLEMS
{
    public partial class Login : CPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx", true);
            }
        }

        protected void LoginOLEMS_LoggedIn(object sender, EventArgs e)
        {
            Response.Redirect("~/Springboard.aspx", true);
        }
    }
}
