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
                SendMailNotification();
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
            

        }

        private void SendMail(string txtTo, string ExamLocation, string ExamName, string SectionName, string ExamDate, string ExamHour)
        {
            string txtFrom = "admin@olems.com";
            string txtSubject = "Exam Notification";
            string txtBody = "Exam " + ExamName + " for section " + SectionName + " will be held at location " + ExamLocation + " on " + ExamDate + " " + ExamHour;
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
            ShowMessageBox("Notification message sent!");
        }


        private void SendMailNotification()
        {
            
            SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

            string ExamLocation = "NotSelected";
            string ExamName = "NotSelected";
            string SectionName = "NotSelected";
            string ExamDate = "NotSelected";
            string ExamHour = "NotSelected";

            DateTime myStartDate = ((Calendar)ExaminationDetailsView.FindControl("startDate")).SelectedDate;
            ExamDate = myStartDate.ToString("dd/MM/yyyy");
            ExamHour = ((TextBox)ExaminationDetailsView.FindControl("startedAt")).Text;


            string txtSectionId = ((DropDownList)ExaminationDetailsView.FindControl("SectionDropDownList")).SelectedValue;
            Guid gSectionId = new Guid(txtSectionId);


            string txtExamId = ((DropDownList)ExaminationDetailsView.FindControl("ExamDropDownList")).SelectedValue;
            Guid gExamId = new Guid(txtExamId);

            string txtLocationId = ((DropDownList)ExaminationDetailsView.FindControl("LocationDropDownList")).SelectedValue;
            Guid gLocationId = new Guid(txtLocationId);

            SqlCommand sqlSelectCmdSection = new SqlCommand();
            sqlSelectCmdSection.CommandType = CommandType.Text;
            sqlSelectCmdSection.CommandText = "SELECT DISTINCT vUsersNameSurname.Email FROM Section INNER JOIN Student ON Section.id = Student.sectionId INNER JOIN Examination ON Section.id = Examination.sectionId INNER JOIN vUsersNameSurname ON dbo.Student.UserId = dbo.vUsersNameSurname.UserId WHERE (Examination.examId = @examId) AND (Examination.sectionId = @sectionId)";
            sqlSelectCmdSection.Connection = conn;

            SqlParameter SectionId = new SqlParameter("@sectionId", SqlDbType.UniqueIdentifier);
            SectionId.Value = gSectionId;
            sqlSelectCmdSection.Parameters.Add(SectionId);

            SqlParameter ExamId = new SqlParameter("@examId", SqlDbType.UniqueIdentifier);
            ExamId.Value = gExamId;
            sqlSelectCmdSection.Parameters.Add(ExamId);

            SqlCommand sqlSelectExamName = new SqlCommand();
            sqlSelectExamName.CommandType = CommandType.Text;
            sqlSelectExamName.CommandText = "SELECT Exam.name FROM Exam  WHERE(Exam.id = @examId);";
            sqlSelectExamName.Connection = conn;
            SqlParameter SelectExamId = new SqlParameter("@examId", SqlDbType.UniqueIdentifier);
            SelectExamId.Value = gExamId;
            sqlSelectExamName.Parameters.Add(SelectExamId);

            SqlCommand sqlSelectSectionName = new SqlCommand();
            sqlSelectSectionName.CommandType = CommandType.Text;
            sqlSelectSectionName.CommandText = "SELECT Section.name FROM Section  WHERE(Section.id = @sectionId);";
            sqlSelectSectionName.Connection = conn; 
            SqlParameter SelectSectionId = new SqlParameter("@sectionId", SqlDbType.UniqueIdentifier);
            SelectSectionId.Value = gSectionId;
            sqlSelectSectionName.Parameters.Add(SelectSectionId);

            SqlCommand sqlSelectLocationName = new SqlCommand();
            sqlSelectLocationName.CommandType = CommandType.Text;
            sqlSelectLocationName.CommandText = "SELECT Location.name FROM Location  WHERE(Location.id = @locationId);";
            sqlSelectLocationName.Connection = conn;
            SqlParameter LocationId = new SqlParameter("@locationId", SqlDbType.UniqueIdentifier);
            LocationId.Value = gLocationId;
            sqlSelectLocationName.Parameters.Add(LocationId);


            ConnectionState previousConnectionState = conn.State;

            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                SqlDataReader examNameDr = sqlSelectExamName.ExecuteReader(CommandBehavior.CloseConnection);
                if (examNameDr.Read())
                {
                    ExamName = (string)examNameDr["name"];
                }

            }
            finally
            {
                if (previousConnectionState == ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            ///////////////////////////
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                SqlDataReader sectionNameDr = sqlSelectSectionName.ExecuteReader(CommandBehavior.CloseConnection);
                if (sectionNameDr.Read())
                {
                    SectionName = (string)sectionNameDr["name"];
                }

            }
            finally
            {
                if (previousConnectionState == ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            ////////////////////////////
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                SqlDataReader locationNameDr = sqlSelectLocationName.ExecuteReader(CommandBehavior.CloseConnection);
                if (locationNameDr.Read())
                {
                    ExamLocation = (string)locationNameDr["name"];
                }

            }
            finally
            {
                if (previousConnectionState == ConnectionState.Closed)
                {
                    conn.Close();
                }
            }

            ////////////////////////////
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                SqlDataReader oDr = sqlSelectCmdSection.ExecuteReader(CommandBehavior.CloseConnection);
                while (oDr.Read())
                {
                    SendMail((string)oDr["Email"], ExamLocation, ExamName, SectionName, ExamDate, ExamHour );

                    System.Diagnostics.Debug.WriteLine("Email Address " + oDr["Email"]);
                }

            }
            finally
            {
                if (previousConnectionState == ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
        }

    }
}
