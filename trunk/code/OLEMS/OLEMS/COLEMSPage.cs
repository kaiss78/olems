using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;
using System.Data.OleDb;
using System.Data;

namespace OLEMS
{
    public class COLEMSPage : System.Web.UI.Page
    {
        #region PExportToExcel
        /// <summary>
        /// method to export Excel files from the GridView with the given file name
        /// </summary>
        /// <param name="strFileName">Name of the file</param>
        /// <param name="dg">GridView control of which the contents to be exported</param>
        /// <remarks>Need a reference to the System.IO Namespace</remarks>
        /// <returns></returns>
        public void PExportToExcel(string strFileName, GridView dg)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
            //'Response.Charset = "ISO-8859-1"
            this.EnableViewState = false;
            StringWriter oStringWriter = new StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            dg.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        #endregion
        #region GetConnectionstring
        /// <summary>
        /// method to retrieve connection stringed in the web.config file
        /// </summary>
        /// <param name="str">Name of the connection</param>
        /// <remarks>Need a reference to the System.Configuration Namespace</remarks>
        /// <returns></returns>
        public string GetConnectionString(string str)
        {
            //variable to hold our return value
            string strConn = string.Empty;
            //check if a value was provided
            if (!string.IsNullOrEmpty(str))
            {
                //name provided so search for that connection
                strConn = ConfigurationManager.ConnectionStrings[str].ConnectionString.ToString();
            }
            else
            //name not provided, get the 'default' connection
            {
                strConn = ConfigurationManager.ConnectionStrings["IS50220082G4_ConnectionString"].ConnectionString.ToString();
            }
            //return the value
            return strConn;
        }
        #endregion
        #region BuildDataSet
        /// <summary>
        /// method to read a text file into a DataSet
        /// </summary>
        /// <param name="file">file to read from</param>
        /// <param name="tableName">name of the DataTable we want to add</param>
        /// <param name="delimeter">delimiter to split on</param>
        /// <returns>a populated DataSet</returns>
        public DataSet BuildDataSet(Stream uploadedContent, string tableName, string delimeter)
        {
            //create our DataSet
            DataSet domains = new DataSet();
            //add our table
            domains.Tables.Add(tableName);
            try
            {
                //create a StreamReader and open our text file
                StreamReader reader = new StreamReader(uploadedContent);
                //read the first line in and split it into columns
                string[] columns = reader.ReadLine().Split(delimeter.ToCharArray());
                //now add our columns (we will check to make sure the column doesnt exist before adding it)
                foreach (string col in columns)
                {
                    //variable to determine if a column has been added
                    bool added = false;
                    //string next = "";
                    //our counter
                    int i = 0;
                    while (!(added))
                    {
                        string columnName = col;
                        //now check to see if the column already exists in our DataTable
                        if (!(domains.Tables[tableName].Columns.Contains(columnName)))
                        {
                            //since its not in our DataSet we will add it
                            domains.Tables[tableName].Columns.Add(columnName, typeof(string));
                            added = true;
                        }
                        else
                        {
                            //we didnt add the column so increment out counter
                            i++;
                        }
                    }
                }
                //now we need to read the rest of the text file
                string data = reader.ReadToEnd();
                //now we will split the file on the carriage return/line feed
                //and toss it into a string array
                string[] rows = data.Split("\r".ToCharArray());
                //now we will add the rows to our DataTable
                foreach (string r in rows)
                {
                    string[] items = r.Split(delimeter.ToCharArray());
                    //split the row at the delimiter
                    domains.Tables[tableName].Rows.Add(items);
                }
            }
            catch (FileNotFoundException ex)
            {
                string inner_message = ex.Message;
                return null;
            }
            catch (Exception ex)
            {
                string outer_message = ex.Message;
                return null;
            }

            //now return the DataSet
            return domains;
        }
        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}