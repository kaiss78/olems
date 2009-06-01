namespace OLEMS
{
    public partial class _Default : CPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}
