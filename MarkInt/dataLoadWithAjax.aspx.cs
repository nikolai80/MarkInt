using System;
using System.Activities.Statements;
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
	private string connect = Constants.conString;
	string query = "SELECT countryID, name FROM Countries";
    protected void Page_Load(object sender, EventArgs e)
    {

	    if (!Page.IsPostBack)
	    {
		    BindData();
	    }
    }

	private void BindData()
		{
		using(SqlConnection conn = new SqlConnection(connect))
			{
			using(SqlCommand cmd = new SqlCommand(query, conn))
				{
				conn.Open();
				ddlCountries.DataSource = cmd.ExecuteReader();
				ddlCountries.DataValueField = "countryID";
				ddlCountries.DataTextField = "name";
				ddlCountries.DataBind();
				}
			}
		}
}