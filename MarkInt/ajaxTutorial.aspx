<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajaxTutorial.aspx.cs" Inherits="ajaxTutorial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>jQuery tutorial</title>
    <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
        <script type="text/javascript" >
    jQuery(function() {
        $('#btnClick').click(function () {
            console.log('button clicked');
            jQuery.ajax({
                type : "GET",
                url : "Handler.ashx",
                data : "MethodName=GetData",
                success: function (data) {
                    console.log('Сработал ajax');
                    $('#display').html("<h1> Hi, " + data.FirstName + " " + 
                      data.LastName + " your Blog Address is http://" + 
                      data.Blog + "</h1>");
                   }
        });
        });
    });
</script>
</head>
<body>
    <form id="form1" runat="server">
    <input id="btnClick" type="button" value="Ajax Call" />
    <div id="display">
    </div>
    </form>
</body>
</html>
