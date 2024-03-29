﻿using System;
using System.Web.Security;
namespace OLEMS
{
    public partial class Springboard : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("Student"))
            {
                Session["StudentGUID"] = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                Response.Redirect("~/Examination/", true);
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
            else if (Roles.IsUserInRole("StudentMustChangePassword"))
            {
                Response.Redirect("~/Restricted/ChangePassword.aspx", true);
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }
        }
    }
}
