(function($) {
		$(document).ready(function() {
			$("#inputEmail5").val("Селектор по id");
			$("div").css("border", "9px solid red");
			$(".form-group").css("border", "3px solid green");
			$(".headerPhone.btn").css("border", "3px dashed rgb(128, 0, 115)");
			var count = $(".wrapper>*").length;
			alert(count);
			$("label+div").text("Мне нравится этот селектор");
			$("h4~button").text("вообще не приходилось никогда использовать этот селектор");

			}
		);
})(jQuery);

