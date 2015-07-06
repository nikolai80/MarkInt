<%@ WebHandler Language="C#" Class="getDataHandler" %>

using System;
using System.Web;

public class getDataHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}