<%@Page Language="C#" %>
<%@Import Namespace="System.Web.Mail" %>
<%
    SmtpMail.SmtpServer = "smtp.gmail.com";
    MailMessage msgMail = new MailMessage();

    msgMail.To = "edaercan@gmail.com";
    msgMail.Cc = "edaercan@gmail.com";
    msgMail.From = "edaercan@gmail.com";
    msgMail.Subject = "Hi Chris, another mail";

    msgMail.BodyFormat = MailFormat.Html;
    string strBody = "<html><body><b>Hello World</b>" +
       " <font color=\"red\">ASP.NET</font></body></html>";
    msgMail.Body = strBody;

    SmtpMail.Send(msgMail);

    Response.Write("Email was queued to disk");
%>