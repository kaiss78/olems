using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace OLEMS.QuestionDevelopment
{
    public partial class TopicManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            String sorgu = "";
            TextBox txtTopic = (TextBox)TopicDetailsView.Rows[0].FindControl("txtName");
            sorgu = "name like '%" + txtTopic.Text + "%'";
            Session["TopicFilter"] = sorgu;//filter bilgisini başka eventlerde kullanmak için session'da bir değişken olarak saklarız
            Topic_SqlDataSource.FilterExpression = sorgu;
        }

        protected void ApplyFilter()
        {
            //bu yordam filtrelenmiş bir satırın edit edilebilmesi ve herhangi bir işlem yapıldıktan sonra filtrenin hala kalması için yazıldı
            Topic_SqlDataSource.FilterExpression = (string)(Session["TopicFilter"]);
            TopicGridView.DataBind();
        }

        protected void TopicGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplyFilter();
        }

        protected void TopicGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            ApplyFilter();
        }
    }
}
