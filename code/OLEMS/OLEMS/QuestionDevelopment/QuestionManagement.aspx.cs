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
        }

        protected void QuestionGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessageBox("Question successfully updated");
            } 
        }

        protected void QuestionDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            //question owner
            Question_SqlDataSource.InsertParameters["createdBy"].DefaultValue = HttpContext.Current.User.Identity.Name.ToString();
            //question image file
            FileUpload fUpload = (FileUpload)QuestionDetailsView.Rows[0].FindControl("imageFileUpload");
            String txtPath = fUpload.FileName;
            Question_SqlDataSource.InsertParameters["questionFilePath"].DefaultValue = txtPath;
            LblError.Text = "";
        }

        protected void QuestionGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
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
                Question_SqlDataSource.UpdateParameters["questionFilePath"].DefaultValue = txtPath;
                Question_SqlDataSource.UpdateCommand = "UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive,questionFilePath=@questionFilePath WHERE id=@id";
            }
            else
            {
                Question_SqlDataSource.UpdateCommand ="UPDATE Question SET topicId=@topicId , body=@body, point=@point, questionTypeId=@questionTypeId, isActive=@isActive WHERE id=@id";
            }
            
        }
    }

      

       

      

        

    }

