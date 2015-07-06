<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/dropDownList.css" rel="stylesheet" />
</head>
<body>
<div class="box">
    <h3>Список №1<span class="expand">+</span></h3>
    <ul>
        <li>Пункт №1</li>
        <li>Пункт №2</li>
        <li>Пункт №3</li>
        <li>Пункт №4</li>
        <li>Пункт №5</li>
        <li>Пункт №6</li>
        <li>Пункт №7</li>
        <li>Пункт №8</li>
        <li>Пункт №9</li>
        <li>Пункт №10</li>
    </ul>
</div>
    <form id="form1" runat="server">
    <input id="btnClick" type="button" value="Ajax Call" />
    <div id="display">
    </div>
    </form>
    <script src="js/jquery-1.11.3.js"></script>
    <script src="js/dropDownList.js"></script>
    
        <script type="text/javascript" >
    jQuery(function() {
        $('#btnClick').click(function(){
            jQuery.ajax({
                type : "GET",
                url : "Data.ashx",
                data : "MethodName=GetData",
                success : function(data){
                    $('#display').html("<h1> Hi, " + data.FirstName + " " + 
                      data.LastName + " your Blog Address is http://" + 
                      data.Blog + "</h1>");
                   }
        });
        });
    });
</script>
</body>
</html>
