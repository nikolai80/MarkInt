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
			 val= $(this).text();
			flagFirstNumber = false;
		} else {
			val += $(this).text();
			
		}
		$("#display").data("firstNumber", val);
		$("#display").val(val);

		
		//if ($("#display").data("fromPrevious") == true) { 

		//	resetCalculator($(this).text()); 

		//}
		//else if (($("#display").data("isPendingFunction") == false) && ($("#display").data("valueOneLocked") == false)) {

		//	$("#display").data("valueOne", $("#display").val()); 
		//	$("#display").data("valueOneLocked", true); 

		//	$("#display").val($(this).text()); 
		//	$("#display").data("valueTwo", $("#display").val()); 
		//	$("#display").data("valueTwoLocked", true); 

		//	// Clicking a number AGAIN, after first number locked and already value for second number    
		//} else if (($("#display").data("isPendingFunction") == true) && ($("#display").data("valueOneLocked") == true)) { 

		//	var curValue = $("#display").val(); 
		//	var toAdd = $(this).text(); 

		//	var newValue = curValue+toAdd; 

		//	$("#display").val(newValue); 

		//	$("#display").data("valueTwo", $("#display").val()); 
		//	$("#display").data("valueTwoLocked", true); 

		//	// Clicking on a number fresh    
		//} else { 

		//	var curValue = $("#display").val(); 
		//	if (curValue == "0") { 
		//		curValue = ""; 
		//	} 

		//	var toAdd = $(this).text(); 

		//	var newValue = curValue.toAdd; 

		//	$("#display").val(newValue); 

		//}
	});

	$(".clear-button").click(function () {
		resetCalculator("0");
	});

	$(".function-button").click(function () {
		num1 = val;
		val = "";
		operationType = $(this).text();
		alert("'"+operationType+"'");
		flagOperation = true;


		//if ($("#display").data("fromPrevious") == true) { 
		//	resetCalculator($("#display").val()); 
		//	$("#display").data("valueOneLocked", false);
		//	$("#display").data("fromPrevious", false);
		//} 

		//// Let it be known that a function has been selected 
		//var pendingFunction = $(this).text(); 
		//$("#display").data("isPendingFunction", true); 
		//$("#display").data("thePendingFunction", pendingFunction); 

		//// Visually represent the current function 
		//$(".function-button").removeClass("pendingFunction"); 
		//$(this).addClass("pendingFunction"); 
	});

	$(".equals-button").click(function () {
		if (flagOperation) {
			num2 = val;
		} else {
			num2 = 0;
		}

		alert("число 1:" + num1 + "число 2:" + num2);

		switch (operationType) {
			case "+":
				alert("тип операции: " + operationType);
				result = parseFloat(num1) + parseFloat(num2);
				break;
			case "-":
				alert("тип операции: " + operationType);
				result = parseFloat(num1) - parseFloat(num2);
				break;
			case "*":
				alert("тип операции: " + operationType);
				result = parseFloat(num1) * parseFloat(num2);
				break;
			case "/":
				alert("тип операции: " + operationType);
				result = parseFloat(num1) / parseFloat(num2);
				break;
		default:
			alert("Ошибка вычисления");
		}

		$("#display").val(result);
		flagOperation = false;


//if (($("#display").data("valueOneLocked") == true) && ($("#display").data("valueTwoLocked") == true)) { 

		//	if ($("#display").data("thePendingFunction") == "+") { 
		//		var finalValue = parseFloat($("#display").data("valueOne"))+ parseFloat($("#display").data("valueTwo")); 
		//	} else if ($("#display").data("thePendingFunction") == "%u2013") { 
		//		var finalValue = parseFloat($("#display").data("valueOne")) - parseFloat($("#display").data("valueTwo")); 
		//	} else if ($("#display").data("thePendingFunction") == "x") { 
		//		var finalValue = parseFloat($("#display").data("valueOne")) * parseFloat($("#display").data("valueTwo")); 
		//	} else if ($("#display").data("thePendingFunction") == "/") { 
		//		var finalValue = parseFloat($("#display").data("valueOne")) / parseFloat($("#display").data("valueTwo")); 
		//	} 

		//	$("#display").val(finalValue); 

		//	resetCalculator(finalValue); 
		//	$("#display").data("fromPrevious", true); 

		//} else { 
		//	// both numbers are not locked, do nothing. 
		//}
	});

	//$("#calculator").draggable();

	$("#opener, #closer").click(function () {
		$("#opener").toggle();
		$("#calculator").toggle();
	});

});

function resetCalculator(curValue) {
	$("#display").val(curValue);
	$(".function-button").removeClass("pendingFunction");
	$("#display").data("isPendingFunction", false);
	$("#display").data("thePendingFunction", "");
	$("#display").data("valueOneLocked", false);
	$("#display").data("valueTwoLocked", false);
	$("#display").data("valueOne", curValue);
	$("#display").data("valueTwo", 0);
	$("#display").data("fromPrevious", false);
}