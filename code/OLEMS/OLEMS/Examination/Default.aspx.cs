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

namespace OLEMS.Examination
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnTakeExam_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex == -1)
            {
                return;
            }
            else
            {
                Session["StudentExaminationGUID"] = new Guid(GridView1.SelectedDataKey.Value.ToString());
                Response.Redirect("~/Examination/", true);

            }
        }

        protected void btnDisplayExamResult_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex == -1)
            {
                return;
            }
            else
            {
                Session["StudentExaminationGUID"] = new Guid(GridView1.SelectedDataKey.Value.ToString());
                Response.Redirect("~/Examination/", true);

            }

        }
    }
}
