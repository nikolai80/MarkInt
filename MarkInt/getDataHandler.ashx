<%@ WebHandler Language="C#" Class="getDataHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;


public class getDataHandler : IHttpHandler
    {
    public void ProcessRequest(HttpContext context)
        {
        context.Response.ContentType = "text/html";
        string connect = Constants.conString;
        string query = "SELECT g.goodsID as ID, g.name as name, c.name AS country FROM Goods g Left JOIN Countries c ON g.countryID=c.countryID WHERE g.countryID=@CountryID";
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
                            context.Response.Write("<td>" + rdr["country"].ToString() + "</td>");
                            context.Response.Write("<td><a class=\"btn btn-primary\" id=\"linkOrder\" value=\"" + rdr["ID"] + "\">Заказать</a></td>");
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
    public bool IsReusable
        {
        get
            {
            return false;
            }
        }

    }