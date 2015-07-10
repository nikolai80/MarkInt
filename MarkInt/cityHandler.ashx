<%@ WebHandler Language="C#" Class="cityHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;

public class cityHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";
        //context.Response.Write("<span>Hello World</span>");
	    string connect = Constants.conString;
        string query = "SELECT cityID,countryID, city FROM Cities WHERE countryID=@CountryID";
        string countryId = context.Request.QueryString["CountryID"];

        if(countryId != null)
            {
            using(SqlConnection conn = new SqlConnection(connect))
                {
                using(SqlCommand cmd = new SqlCommand(query, conn))
                    {
                    cmd.Parameters.AddWithValue("CountryID", countryId);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if(rdr.HasRows)
                        {
                        while(rdr.Read())
                            {
                            context.Response.Write("<option value=\""+rdr["cityID"]+"\">" + rdr["city"].ToString() + "</option>");
                            }
                        }
                    }
                conn.Close();
                }
            }
        else
            {
            context.Response.Write("<tr><td>No</td><td>No</td></tr>");
            }

        context.Response.End();
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}