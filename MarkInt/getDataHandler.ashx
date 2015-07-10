<%@ WebHandler Language="C#" Class="getDataHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;


public class getDataHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";
        //context.Response.Write("<span>Hello World</span>");
        string connect = Constants.conString;
	string query = "SELECT g.name as name, c.name AS country FROM Goods g Left JOIN Countries c ON g.countryID=c.countryID WHERE g.countryID=@CountryID";
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
                            context.Response.Write("<tr>");
                            context.Response.Write("<td>" + rdr["name"].ToString() + "</td>");
                            context.Response.Write("<td>"+rdr["country"].ToString() + "</td>");
                            context.Response.Write("<td><a id=\"linkOrder\">Заказать</></td>");
                            context.Response.Write("</tr>");
                           
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