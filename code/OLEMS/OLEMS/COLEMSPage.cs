using System;
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
    public class COLEMSPage : Page
    {
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
        public void PImportExcelFile(string strFileName, GridView dg)
        {
            
            string strConn;
            strConn = "Provider=Microsoft.Jet.OLEDB.4.0;" +
            "Data Source=" + strFileName + ";" +
            "Extended Properties=Excel 8.0;";
            //You must use the $ after the object you reference in the spreadsheet
            OleDbDataAdapter myCommand = new OleDbDataAdapter("SELECT * FROM [Sheet1$]", strConn);
            DataSet myDataSet = new DataSet();
            myCommand.Fill(myDataSet, "ExcelInfo");
            dg.DataSource = myDataSet.Tables["ExcelInfo"].DefaultView;
            dg.DataBind();
        }
        public string PImportTextFile(string strFilePath, GridView dg)
        {
            int tabSize = 4;
            string[] arInfo;
            string line, contents;
            DataTable table = CreateTable();
            DataRow row;
            try
            {
                StreamReader objStreamReader;
                objStreamReader = File.OpenText(strFilePath);
                //Get a StreamReader class that can be used to read the file
                while ((line = objStreamReader.ReadLine()) != null)
                {
                    contents = line.Replace(("").PadRight(tabSize, ' '), "\t");
                    // define which character is seperating fields
                    char[] textdelimiter = { ']' };
                    arInfo = contents.Split(textdelimiter);
                    for (int i = 0; i <= arInfo.Length; i++)
                    {
                        row = table.NewRow();
                        if (i < arInfo.Length)
                            row["Type"] = arInfo[i].ToString().Replace("[", " ");
                        if (i + 1 < arInfo.Length)
                            row["Source"] = arInfo[i + 1].ToString().Replace("[", " ");
                        if (i + 2 < arInfo.Length)
                            row["Time"] = arInfo[i + 2].ToString().Substring(1);
                        if (i + 3 < arInfo.Length)
                        {
                            row["Description"] = arInfo[i + 3].ToString().Replace("[", " ");
                            table.Rows.Add(row);
                        }
                        i = i + 2;
                    }
                }
                objStreamReader.Close();
                // Set to DataGrid.DataSource property to the table.
                dg.DataSource = table;
                dg.DataBind();
                return "success";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        private DataTable CreateTable()
        {
            try
            {
                DataTable table = new DataTable();
                // Declare DataColumn and DataRow variables.
                DataColumn column;
                // Create new DataColumn, set DataType, ColumnName
                // and add to DataTable.    
                column = new DataColumn();
                column.DataType = System.Type.GetType("System.String");
                column.ColumnName = "Type";
                table.Columns.Add(column);
                // Create second column.
                column = new DataColumn();
                column.DataType = Type.GetType("System.String");
                column.ColumnName = "Time";
                table.Columns.Add(column);
                column = new DataColumn();
                column.DataType = System.Type.GetType("System.String");
                column.ColumnName = "Source";
                table.Columns.Add(column);
                column = new DataColumn();
                column.DataType = System.Type.GetType("System.String");
                column.ColumnName = "Description";
                table.Columns.Add(column);
                return table;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

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