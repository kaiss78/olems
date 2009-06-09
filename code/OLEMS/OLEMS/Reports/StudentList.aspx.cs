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
using System.Data.SqlClient;

namespace OLEMS.Reports
{
    public partial class StudentList : COLEMSPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strSectionIDs = null;
            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (li.Selected)
                {
                    if (strSectionIDs == null)
                    {
                        strSectionIDs = "N'" + li.Value + "'";
                    }
                    else
                    {
                        strSectionIDs = strSectionIDs + ", N'" + li.Value + "'";
                    }
                }
            }
            if (strSectionIDs == null)
            {
                return;
            }
            else
            {
                SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

                SqlCommand sqlQuery = new SqlCommand();
                sqlQuery.CommandType = CommandType.Text;
                sqlQuery.CommandText = "SELECT Exam.id, Exam.name FROM Examination INNER JOIN Exam ON Examination.examId = Exam.id INNER JOIN Section ON Examination.sectionId = Section.id WHERE (Section.id IN (" + strSectionIDs + ")) ORDER BY Exam.name";
                sqlQuery.Connection = conn;

                ConnectionState previousConnectionState = conn.State;

                SqlDataAdapter dbAdapter = new SqlDataAdapter();
                dbAdapter.SelectCommand = sqlQuery;
                DataSet resultsDataSet = new DataSet();
                try
                {
                    dbAdapter.Fill(resultsDataSet);
                }
                catch
                {
                    return;
                }
                if (resultsDataSet.Tables.Count > 0)
                {
                    CheckBoxList2.Items.Clear();
                    foreach (DataRow row in resultsDataSet.Tables[0].Rows)
                    {
                        ListItem NewLI = new ListItem();
                        NewLI.Text = row["name"].ToString();
                        NewLI.Value = row["id"].ToString();
                        CheckBoxList2.Items.Add(NewLI);
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string strSectionIDs = null;
            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (li.Selected)
                {
                    if (strSectionIDs == null)
                    {
                        strSectionIDs = "N'" + li.Value + "'";
                    }
                    else
                    {
                        strSectionIDs = strSectionIDs + ", N'" + li.Value + "'";
                    }
                }
            }

            string strExamIDs = null;
            foreach (ListItem li in CheckBoxList2.Items)
            {
                if (li.Selected)
                {
                    if (strExamIDs == null)
                    {
                        strExamIDs = "N'" + li.Value + "'";
                    }
                    else
                    {
                        strExamIDs = strExamIDs + ", N'" + li.Value + "'";
                    }
                }
            }
            SqlConnection conn = new SqlConnection(GetConnectionString("IS50220082G4_ConnectionString"));

            SqlCommand sqlQuery = new SqlCommand();
            sqlQuery.CommandType = CommandType.Text;
            sqlQuery.CommandText = "SELECT Exam.name AS Exam, LocationBuilding.name AS Building, Location.name AS Location, Section.name AS Section, Users.name, Users.surname " +
"FROM Exam INNER JOIN Section INNER JOIN Student INNER JOIN Users ON Student.UserId = Users.UserId ON Section.id = Student.sectionId INNER JOIN Examination ON Section.id = Examination.sectionId ON Exam.id = Examination.examId INNER JOIN Location INNER JOIN " +
"LocationBuilding ON Location.locationBuildingId = LocationBuilding.id ON Examination.locationId = Location.id " +
"WHERE (Examination.sectionId IN (" + strSectionIDs + ")) AND (Examination.examId IN (" + strExamIDs + "))";
            sqlQuery.Connection = conn;

            ConnectionState previousConnectionState = conn.State;

            SqlDataAdapter dbAdapter = new SqlDataAdapter();
            dbAdapter.SelectCommand = sqlQuery;
            DataSet resultsDataSet = new DataSet();
            try
            {
                dbAdapter.Fill(resultsDataSet);
            }
            catch
            {
                return;
            }
            if (resultsDataSet.Tables.Count > 0)
            {
                GridView1.DataSource = resultsDataSet;
                GridView1.DataBind();

                //CheckBoxList2.Items.Clear();
                //foreach (DataRow row in resultsDataSet.Tables[0].Rows)
                //{
                //    ListItem NewLI = new ListItem();
                //    NewLI.Text = row["name"].ToString();
                //    NewLI.Value = row["id"].ToString();
                //    CheckBoxList2.Items.Add(NewLI);
                //}
            }

        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // Confirms that an HtmlForm control is rendered for the
            //specified ASP.NET server control at run time.
            return;
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            PExportToExcel("deneme", GridView1);
        }
    }
}