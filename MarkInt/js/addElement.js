$(document).ready(function () {
    $(".btnAddElement").click(function () {
        $("body").append("<div id='newDiv'>New div</div>")
       
    });
    $("#newDiv").addClass("newDiv");
})