<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dataLoadWithAjax.aspx.cs" Inherits="dataLoadWithAjax" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Load data with ajax</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />

</head>
<body>
    <div class="row">
        <div class="col-lg-4 col-lg-offset-1">
            <h3>Load data with ajax</h3>
        </div>
    </div>
    <div class="row">
        <form runat="server">
            <div class="contentData col-lg-4 col-lg-offset-1">
                <asp:DropDownList runat="server" ID="ddlCountries" class="col-lg-5" />
                <table class="tableData table" id="tblGoods">
                    <tr class="tblHeader">
                        <th>Товар</th>
                        <th>Страна</th>
                        <th>Заказать</th>
                    </tr>
                </table>
            </div>
            <asp:DropDownList runat="server" ID="city" class="col-lg-2" />

            <div class="shoppingCart row">
                <div class="col-lg-5 col-lg-offset-1">
                    <h4>Карта №</h4>
                    <table class="tableData table" id="tblShoppinCart">
                        <tr>
                            <th>Наименование товара</th>
                        </tr>
                    </table>
                    <button class="function-button">Оформить заказ</button>
                </div>
            </div>

        </form>

    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-1.11.3.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            console.log("Перед выбором списка");
            $('#ddlCountries').change(function () {
                GetData();
                GetCities();
            });
            
        });
        $(document).ready(function() {
            $('#tblGoods').on('click', '#linkOrder', function (event) {
                InsertOrderedPart($(this).attr('value'));
                GetOrderedParts($(this).attr('value'));
            });
        });
        function GetData() {
            console.log("Перед срабатыванием ajax");
            $('.tableData').find("tr:gt(0)").remove();
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                data: "CountryID=" + $('#ddlCountries').val(),
                url: "getDataHandler.ashx",
                dataType: "html",
                success: function (html) {
                    $('#tblGoods').append(html);
                }
            });
            
        };
        function GetCities() {
            $('#city').find("option").remove();
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                data: "CountryID=" + $('#ddlCountries').val(),
                url: "cityHandler.ashx",
                dataType: "html",
                success: function (html) {
                    $('#city').append(html);
                }
            });
        };

        function InsertOrderedPart(id) {
            console.log("Значение Id " + id);
            var dataValue = { productId: id };
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                data:JSON.stringify(dataValue),
                url: "dataLoadWithAjax.aspx/AddProductToCart",
                dataType: "json",
                success: function (response) {
                    alert("User has been added successfully."+response);
                    //window.location.reload();;
                }
            });
        }

        function GetOrderedParts(productId) {
            $.ajax({
                type: "get",
                contentType: "application/json; charset=utf-8",
                data: "ProductId=" + productId,
                url: "getProductHandler.ashx",
                dataType: "html",
                success: function (html) {
                    $('#tblShoppinCart').append(html);
                }
            });
        }
    </script>
</body>
</html>
