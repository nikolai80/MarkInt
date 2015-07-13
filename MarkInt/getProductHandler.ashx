<%@ WebHandler Language="C#" Class="getProductHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;

public class getProductHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";

        string connect = Constants.conString;
        string query = "SELECT goodsID, name FROM Goods WHERE goodsID=@goodsID";
        string productId = context.Request.QueryString["ProductId"];

        if(productId != null)
            {
            using(SqlConnection conn = new SqlConnection(connect))
                {
                using(SqlCommand cmd = new SqlCommand(query, conn))
                    {
                    cmd.Parameters.AddWithValue("ProductId", productId);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if(rdr.HasRows)
                        {
                        while(rdr.Read())
                            {
                            context.Response.Write("<tr>");
                            context.Response.Write("<td>" + rdr["name"] + "</td>");
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