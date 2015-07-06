<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dataLoadWithAjax.aspx.cs" Inherits="dataLoadWithAjax" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Load data with ajax</title>
</head>
<body>
<h3>Load data with ajax</h3>
   <form runat="server">
   <div class="contentData">
       <asp:DropDownList runat="server" ID="ddlCountries"/>
       <table><tr class="tblHeader"><th>Товар</th>
           <th>Страна</th>
              </tr>
           
       </table>
   </div></form> 
    <script type="text/javascript">
        $(Document).ready(function() {
            $('#ddlCountries').change(GetData()) ;
        });
        function GetData() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{}",
                url: "getDataHandler.ashx",
                dataType: "json",
                success: function(data) {
                }
            });
        }
    </script>
</body>
</html>
