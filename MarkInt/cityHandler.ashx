<%@ WebHandler Language="C#" Class="cityHandler" %>

using System;
using System.Web;

public class cityHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/json";
        //context.Response.Write("<span>Hello World</span>");
        string connect = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\rybchenko\programs\MarktInt\MarkInt\App_Data\GoodsDB.mdf;Integrated Security=True";
        string query = "SELECT g.name as name, c.name AS country FROM Goods g Left JOIN Countries c ON g.countryID=c.countryID WHERE g.countryID=@CountryID";
        string countryId = context.Request.QueryString["CountryID"];
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}