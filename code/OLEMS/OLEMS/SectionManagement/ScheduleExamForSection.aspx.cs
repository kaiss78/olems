using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Mail;
using System.Data.SqlClient;
using System.Data;

namespace OLEMS.SectionManagement
{
    public partial class ScheduleExamForSection : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ExaminationDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ShowMessageBox("Could not schedule exam");
            }
            else // if (e.Exception == null)
            {
                ShowMessageBox("Exam is successfully scheduled for the section");
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

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (ExaminationDetailsView.FindControl("SectionDropDownList") == null)
                return;

            SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));    
          
            string txtSectionId = ((DropDownList)ExaminationDetailsView.FindControl("SectionDropDownList")).SelectedValue;
            
            SqlCommand sqlSelectCmdSection = new SqlCommand();
            sqlSelectCmdSection.CommandType = CommandType.Text;
            sqlSelectCmdSection.CommandText = "SELECT * FROM IS50220082G4.dbo.vUsersNameSurname as vUsersNameSurname, IS50220082G4.dbo.Student as Student WHERE(Student.sectionId = @sectionId AND Student.UserId = vUsersNameSurname.UserId);";
            sqlSelectCmdSection.Connection = conn;

            SqlParameter sectionId = new SqlParameter("@sectionId", DBNull.Value);
            sectionId.Value = txtSectionId;
            sqlSelectCmdSection.Parameters.Add(sectionId);

            ConnectionState previousConnectionState = conn.State;
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                SqlDataReader oDr = sqlSelectCmdSection.ExecuteReader(CommandBehavior.CloseConnection);
                while (oDr.Read())
                {
                    SendMail((string)oDr["email"]);

                    System.Diagnostics.Debug.WriteLine("Email Address " + oDr["email"]);
                }

            }
            finally
            {
                if (previousConnectionState == ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            //SendMail();
        }

        private void SendMail(string txtTo)
        {
            string txtFrom = "edaercan@gmail.com";
            string txtSubject = "subject";
            string txtBody = "body";
            //Create message object and populate w/ data from form
            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
            message.From = new System.Net.Mail.MailAddress(txtFrom.Trim());
            message.To.Add(txtTo.Trim());
            message.Subject = txtSubject.Trim();
            message.Body = txtBody.Trim();

            //Setup SmtpClient to send email. Uses web.config settings.
            System.Net.Mail.SmtpClient smtpClient = new System.Net.Mail.SmtpClient();

            //Error handling for sending message
            try
            {
                smtpClient.Send(message);
                //Exception contains information on each failed receipient
            }
            catch (System.Net.Mail.SmtpFailedRecipientsException recExc)
            {
                for (int recipient = 0; recipient < recExc.InnerExceptions.Length - 1; recipient++)
                {
                    System.Net.Mail.SmtpStatusCode statusCode;
                    //Each InnerException is an System.Net.Mail.SmtpFailed RecipientException
                    statusCode = recExc.InnerExceptions[recipient].StatusCode;

                    if ((statusCode == System.Net.Mail.SmtpStatusCode.MailboxBusy) || (statusCode == System.Net.Mail.SmtpStatusCode.MailboxUnavailable))
                    {
                        //Log this to event log: recExc.InnerExceptions[recipient].FailedRecipient
                        System.Threading.Thread.Sleep(5000);
                        smtpClient.Send(message);
                    }
                    else
                    {
                        //Log error to event log.
                        //recExc.InnerExceptions[recipient].StatusCode or use statusCode
                        ShowMessageBox(recExc.StatusCode.ToString());
                    }

                }
            }
            //General SMTP execptions
            catch (System.Net.Mail.SmtpException smtpExc)
            {
                ShowMessageBox(smtpExc.StatusCode.ToString());
                //Log error to event log using StatusCode information in
                //smtpExc.StatusCode
            }
            catch (Exception ex)
            {

                ShowMessageBox(ex.Message);   //Log error to event log.
            }
            ShowMessageBox("Message sent!");
        }
    }
}
