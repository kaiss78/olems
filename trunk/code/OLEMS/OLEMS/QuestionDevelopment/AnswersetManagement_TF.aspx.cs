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
    public partial class AnswersetManagement_TF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String questionID = Request.QueryString["questionID"].ToString();
            ChoicesSqlDataSource.SelectCommand = "SELECT [id], [questionId], [body],[truthValue] FROM [Choice] where [questionId]='" + questionID + "'";
            ChoicesSqlDataSource.UpdateParameters["id"].DefaultValue = questionID;
            ChoicesSqlDataSource.DeleteParameters["id"].DefaultValue = questionID;
            ChoicesSqlDataSource.InsertParameters["questionId"].DefaultValue = questionID;
            QuestionSqlDataSource.SelectCommand = "SELECT [body] FROM [Question] where [id]='" + questionID + "'";
        }
  
        protected void ChoicesDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
           //seçilen şıkkın tersini truth value false olacak şekilde tabloya yazarız
            String questionID = Request.QueryString["questionID"].ToString();
            String body = (String) Session["TFChoice"].ToString();
            if (body == "True") body = "False";
                else body = "True";
            ChoicesSqlDataSource.InsertCommand = "INSERT INTO [Choice](questionId,body,truthValue) VALUES ('" + questionID + "','" + body + "','False')";
            ChoicesSqlDataSource.Insert();
        }

        protected void ChoicesDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            DropDownList body = (DropDownList)ChoicesDetailsView.Rows[0].FindControl("TFDropDownList1");
            Session["TFChoice"] = body.SelectedValue; 

        }
    }
}
