<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler {
    
   public void ProcessRequest (HttpContext context) {
    string method = context.Request.QueryString["MethodName"].ToString();
    context.Response.ContentType = "text/json";
    switch (method)
    {
        case "GetData" :
            context.Response.Write(GetData());
            break;
    }
}

    public bool IsReusable { get; private set; }

    protected string GetData()
{
    return (@"{""FirstName"":""Ravi"", ""LastName"":""Baghel"", 
               ""Blog"":""ravibaghel.wordpress.com""}");
}

}