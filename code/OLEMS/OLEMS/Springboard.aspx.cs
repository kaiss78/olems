using System;
using System.Web.Security;
namespace OLEMS.UserManagement
{
    public partial class Springboard : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Student"))
            {
                Response.Redirect("~/ExamManagement/", true);
            }
            else if (Roles.IsUserInRole("Exam Creator"))
            {
                Response.Redirect("~/ExamManagement/", true);
            }
            else if (Roles.IsUserInRole("Instructor"))
            {
                Response.Redirect("~/SectionManagement/", true);
            }
            else if (Roles.IsUserInRole("Question Developer"))
            {
                Response.Redirect("~/QuestionDevelopment/", true);
            }
            else if (Roles.IsUserInRole("Admin"))
            {
                Response.Redirect("~/SystemAdministration/", true);
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }
        }
    }
}
