$("document").ready(function () {

	resetCalculator("0");

	var flagFirstNumber = true;
	var val = "";
	var num1 = parseFloat(val);
	var num2 = parseFloat(val);
	var flagOperation = false;
	var operationType = "";
	var result = 0;

	$(".num-button").click(function () {
		if (flagFirstNumber) {
			if ($(this).text() != ".") {
				val = $(this).text();
			} else {
				val = "0" + $(this).text();
			}
			flagFirstNumber = false;
		} else {
			if ($(this).text() != ".") {
				val += $(this).text();
			} else if ($(this).text() == "." && val.indexOf(".") == -1) {
				val += $(this).text();
			}
		}
		$("#display").data("firstNumber", val);
		$("#display").val(val);
	});

	function resetCalculator(curValue) {
		$("#display").val(curValue);
		flagFirstNumber = true;
		num1 = parseFloat(val);
		num2 = parseFloat(val);
		flagOperation = false;
		operationType = "";
		result = 0;
	}

	$(".clear-button").click(function () {
		resetCalculator("0");
	});

	$(".function-button").click(function () {
		num1 = val;
		val = "";
		operationType = $(this).text();
		flagOperation = true;
	});

	$(".equals-button").click(function () {
		if (flagOperation) {
			num2 = val;
		} else {
			num2 = 0;
		}
		switch (operationType) {
			case "+":
				result = parseFloat(num1) + parseFloat(num2);
				break;
			case "-":
				result = parseFloat(num1) - parseFloat(num2);
				break;
			case "x":
				result = parseFloat(num1) * parseFloat(num2);
				break;
			case "/":
				result = parseFloat(num1) / parseFloat(num2);
				break;
			default:
				alert("Ошибка вычисления");
		}

		$("#display").val(result);
		flagOperation = false;
	});

	$("#opener, #closer").click(function () {
		$("#opener").toggle();
		$("#calculator").toggle();
	});

	function decimalPoint(textPoint, val) {
		if (textPoint == "." && val.indexOf(textPoint) == -1) {
			val += textPoint;
		} else if (textPoint == "." && val.indexOf(textPoint) == 0) {
			val = "0.";
		} else {
			val = val;
		}
	}
});

