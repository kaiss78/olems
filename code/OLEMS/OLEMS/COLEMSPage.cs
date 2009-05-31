using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;

namespace OLEMS
{
    public class COLEMSPage : System.Web.UI.Page
    {
        public void PExportToExcel(string strFileName, GridView dg)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
        //'Response.Charset = "ISO-8859-1"
            this.EnableViewState = false;
            StringWriter oStringWriter = new StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            dg.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }

        private void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
            }
            else
            {
                Response.Redirect("~/Login.aspx");

            }
        }
    }
}