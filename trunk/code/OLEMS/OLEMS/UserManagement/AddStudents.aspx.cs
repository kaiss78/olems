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
using System.IO;

namespace OLEMS.UserManagement
{
    public partial class AddStudents : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                Stream uploadedFile = FileUpload1.PostedFile.InputStream;
                DataSet data = BuildDataSet(uploadedFile, "MyTable", ",");
                GridView1.DataSource = data;
                GridView1.DataBind();
                LabelInfo.Text = "Text file read successfully.";
                divReadTextFile.Visible = true;
            }
        }
    }
}
