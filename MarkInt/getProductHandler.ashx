<%@ WebHandler Language="C#" Class="getProductHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;

public class getProductHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";

        string connect = Constants.conString;
        string query = "SELECT cg.goodsID as goodsID, g.name as name FROM CardsGoods cg LEFT JOIN Goods g ON cg.goodsID=g.goodsID WHERE cg.cardID=@CardId";

        HttpCookie cookie = context.Request.Cookies["shopingCartCookies"];
        string cardId = context.Request.QueryString["CardId"];

        if(!String.IsNullOrEmpty(cardId))
            {
            using(SqlConnection conn = new SqlConnection(connect))
                {
                using(SqlCommand cmd = new SqlCommand(query, conn))
                    {
                    cmd.Parameters.AddWithValue("CardId", cardId);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if(rdr.HasRows)
                        {
                        while(rdr.Read())
                            {
                            context.Response.Write("<tr>");
                            context.Response.Write("<td value=\""+rdr["goodsID"]+"\">" + rdr["name"] + "</td>");
                            context.Response.Write("</tr>");
                            }
                        }
                    }
                conn.Close();
                }
            }
        else
            {
            context.Response.Write("");
            }

        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}