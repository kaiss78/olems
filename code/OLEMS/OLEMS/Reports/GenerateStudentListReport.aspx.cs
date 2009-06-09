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

namespace OLEMS.Reports
{
    public partial class GenerateStudentListReport : COLEMSPage
    {
        //SqlConnection myCon = new SqlConnection("Data Source=localhost;Initial Catalog=IS50220082G4;uid=sa;pwd=seamaster");

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write("asdf");
            //myCon.Open();

            //SqlCommand myCommand = new SqlCommand("SELECT id, name FROM Section order by name ASC", myCon);
            ////myCommand.CommandType = CommandType.StoredProcedure ;

            //SqlDataReader myReader;
            //myReader = myCommand.ExecuteReader();

            ////while (myReader.Read())

            ////    SectionDropDownList.Items.Add(new ListItem(myReader["name"].ToString(), myReader["id"].ToString()));

            //myReader.Close();
            //myCon.Close();
        }

        protected void SectionDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //}

        protected void DropDownList13_SelectedIndexChanged(object sender, EventArgs e)
        {
            //myCon.Open();

            //Guid sectionId = new Guid(SectionDropDownList.SelectedItem.Value);

            //SqlCommand myCommand = new SqlCommand("SELECT Exam.name, Exam.id FROM Exam, Examination where Examination.sectionId=" + sectionId + " and Exam.id = Examination.examId", myCon);
            //SqlDataReader myReader;
            //myReader = myCommand.ExecuteReader();

            ////while (myReader.Read())
            ////    DropDownList2.Items.Add(new ListItem(myReader["name"].ToString(), myReader["id"].ToString()));

            //myReader.Close();
            //myCon.Close();

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}

