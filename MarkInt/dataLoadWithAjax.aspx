<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dataLoadWithAjax.aspx.cs" Inherits="dataLoadWithAjax" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" RowStyle-BackColor="#A1DCF2"
        HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White">
        <Columns>
            <asp:BoundField ItemStyle-Width="150px" DataField="goodsID" HeaderText="GoodsID" />
            <asp:BoundField ItemStyle-Width="150px" DataField="name" HeaderText="Name" />
            <asp:BoundField ItemStyle-Width="150px" DataField="countryID" HeaderText="countryID" />
        </Columns>
    </asp:GridView>
    <script type="text/javascript">
        $(function () {
            GetCustomers();
        });
        
        function GetCustomers() {
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetCustomers",
                data: '{pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Customers");
            var row = $("[id*=gvCustomers] tr:last-child").clone(true);
            $("[id*=gvCustomers] tr").not($("[id*=gvCustomers] tr:first-child")).remove();
            $.each(customers, function () {
                var customer = $(this);
                $("td", row).eq(0).html($(this).find("CustomerID").text());
                $("td", row).eq(1).html($(this).find("ContactName").text());
                $("td", row).eq(2).html($(this).find("City").text());
                $("[id*=gvCustomers]").append(row);
                row = $("[id*=gvCustomers] tr:last-child").clone(true);
            });
            var pager = xml.find("Pager");
            $(".Pager").ASPSnippets_Pager({
                ActiveCssClass: "current",
                PagerCssClass: "pager",
                PageIndex: parseInt(pager.find("PageIndex").text()),
                PageSize: parseInt(pager.find("PageSize").text()),
                RecordCount: parseInt(pager.find("RecordCount").text())
            });
        };
    </script>
</body>
</html>
