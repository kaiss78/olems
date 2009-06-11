using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace OLEMS.QuestionDevelopment
{
    public partial class QuestionManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //
        }

        protected void QuestionDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Question successfully created");
            } 
        }
        protected void ShowMessageBox(string message)
        {
            // Define the name and type of the client scripts on the page.
            String csname = "MessageBox";
            Type cstype = this.GetType();

            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, csname))
            {
                String cstext = "alert('" + message + "');";
                cs.RegisterStartupScript(cstype, csname, cstext, true);
            }
            
        }

        protected void QuestionGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Question successfully deleted");
            }
            else
            {
                e.ExceptionHandled = true;
                if (e.Exception.Message.Contains("FK_Choice_Question") == true)
                {
                    LblError.Text = "Question has choices, You can't delete!";
                }else
                {
                    LblError.Text = "Question is used in a past exam, You can't delete!"; 
                }
            }
        }

        protected void QuestionGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            ApplyFilter();
            if (e.Exception == null)
            {
                ShowMessageBox("Question successfully updated");
            } 
        }

        protected void QuestionDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            ApplyFilter();
            //question owner
            Question_SqlDataSource.InsertParameters["createdBy"].DefaultValue = HttpContext.Current.User.Identity.Name.ToString();
            //question image file
            FileUpload fUpload = (FileUpload)QuestionDetailsView.Rows[0].FindControl("imageFileUpload");
            String txtPath = "~/QuestionFiles/" + fUpload.FileName;
            Question_SqlDataSource.InsertParameters["questionFilePath"].DefaultValue = txtPath;
            LblError.Text = "";
        }

        protected void QuestionGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplyFilter();
            Label questionOwner = (Label)QuestionGridView.Rows[e.NewEditIndex].FindControl("lblOwner");
            if (questionOwner.Text != HttpContext.Current.User.Identity.Name.ToString())
            {
                LblError.ForeColor = Color.Red;
                LblError.Text = "You can't edit unless you are the owner of the question!";
                e.Cancel = true;
            }else 
            {
                LblError.Text = "";
            }

        }

        protected void QuestionGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            ApplyFilter(); 
            Label questionOwner = (Label)QuestionGridView.Rows[e.RowIndex].FindControl("lblOwner");
            if (questionOwner.Text != HttpContext.Current.User.Identity.Name.ToString())
            {
                LblError.ForeColor = Color.Red;
                LblError.Text = "You can't delete unless you are the owner of the question!";
                e.Cancel = true;
            }else LblError.Text = "";
        }

        protected void QuestionDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            LblError.Text = "";
        }

        protected void QuestionGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            FileUpload fUpload = (FileUpload) QuestionGridView.Rows[e.RowIndex].FindControl("imageGVFileUpload");
            String txtPath = fUpload.FileName;
            if (txtPath != null && txtPath.Trim().Length>0) 
            {
                Question_SqlDataSource.UpdateParameters["questionFilePath"].DefaultValue = "~/QuestionFiles/" + txtPath;
                Question_SqlDataSource.UpdateCommand = "UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive,questionFilePath=@questionFilePath WHERE id=@id";
            }
            else
            {
                Question_SqlDataSource.UpdateCommand ="UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive WHERE id=@id";
            }
            
        }

        protected void QuestionGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
        
            Label questionID = (Label)QuestionGridView.Rows[e.NewSelectedIndex].FindControl("lblQuestionID");
            DropDownList questionType = (DropDownList)QuestionGridView.Rows[e.NewSelectedIndex].FindControl("qTypeDropDownList2");
            String url = null;
            int selectedType = questionType.SelectedIndex;
            switch (selectedType)
            {
                case 0: // Free Response 
                    url = "AnswersetManagement_FR.aspx?questionID=" + questionID.Text;
                    break;
                case 1: // Matching Choice
                    url = "AnswersetManagement_MTC.aspx?questionID=" + questionID.Text;
                    break;
                case 2: // Multiple Choice
                    url = "AnswersetManagement_MC.aspx?questionID=" + questionID.Text;
                    break;
                case 3: // True false 
                    url = "AnswersetManagement_TF.aspx?questionID=" + questionID.Text;
                    break;
            }
            OpenNewWindow(url);
            
        }
        public void OpenNewWindow(string url)
        {

            ClientScript.RegisterStartupScript(this.GetType(), "newWindow", String.Format("<script>window.open('{0}', '','toolbar=0,height=500,width=750,top=100,left=250,resizable=0,scrollbars=1');</script>", url));
        }

        protected void ApplyFilter()
        {
            //bu yordam filtrelenmiş bir satırın edit edilebilmesi ve herhangi bir işlem yapıldıktan sonra filtrenin hala kalması için yazıldı
            Question_SqlDataSource.FilterExpression = (string)(Session["SearchQuestionFilter"]);
            QuestionGridView.DataBind();
        }
     
        protected void lnkSearch_Click(object sender, EventArgs e)
        {
            String sorgu;
            sorgu = "1=1";
            QuestionGridView.EditIndex = -1;
            TextBox txtBody = (TextBox)QuestionDetailsView.Rows[0].FindControl("txtBody");
        
            //if ((txtBody.Text != "") && (txtBody.Text)==true) //boş değilse
            //{
            sorgu = sorgu + " AND body like '%" + txtBody.Text + "%'";
            

            if (SearchAllCheckBox.Checked == false) //eğer tüm sorularda arama yapılmak istenmiyorsa
            {
                DropDownList topic = (DropDownList)QuestionDetailsView.Rows[0].FindControl("topicDropDownList");
                sorgu = sorgu + " AND topicId ='" + topic.SelectedValue + "'";
                CheckBox chkStatus = (CheckBox)QuestionDetailsView.Rows[0].FindControl("chkStatus");
                if (chkStatus.Checked==true) //sadece aktif sorularda arama yapılacaksa
                {
                    sorgu = sorgu + " AND isActive = 'True'";
                }else
                    sorgu = sorgu + " AND isActive = 'False'";
            }

            Session["SearchQuestionFilter"] = sorgu; //filter bilgisini başka eventlerde kullanmak için session'da bir değişken olarak saklarız
            Question_SqlDataSource.FilterExpression = sorgu;
        }

    }

      

       

      

        

    }

