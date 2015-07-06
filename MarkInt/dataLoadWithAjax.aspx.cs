using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dataLoadWithAjax : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
	if(!IsPostBack)
		{
		BindDummyRow();
		}
    }

	private void BindDummyRow()
		{
		DataTable dummy = new DataTable();
		dummy.Columns.Add("goodsID");
		dummy.Columns.Add("name");
		dummy.Columns.Add("countryID");
		dummy.Rows.Add();
		gvCustomers.DataSource = dummy;
		gvCustomers.DataBind();
		}

	[WebMethod]
	private static string GetData()
	{
	string strConnString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
	using(SqlConnection con = new SqlConnection(strConnString))
		{
		using(SqlDataAdapter sda = new SqlDataAdapter())
			{
			cmd.Connection = con;
			sda.SelectCommand = cmd;
			using(DataSet ds = new DataSet())
				{
				sda.Fill(ds, "Customers");
				DataTable dt = new DataTable("Pager");
				dt.Columns.Add("PageIndex");
				dt.Columns.Add("PageSize");
				dt.Columns.Add("RecordCount");
				dt.Rows.Add();
				dt.Rows[0]["PageIndex"] = pageIndex;
				dt.Rows[0]["PageSize"] = PageSize;
				dt.Rows[0]["RecordCount"] = cmd.Parameters["@RecordCount"].Value;
				ds.Tables.Add(dt);
				return ds;
				}
			}
		}
		return "";
	}
}