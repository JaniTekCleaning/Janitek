// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap/modal
//= require_tree .

$(document).on('turbolinks:load', ready);

function addNewHotButtonElement(buttonText) {
	if (buttonText == "" || buttonText == undefined || buttonText == null) {
		return false;
	}
	var buttonList = $("#hot-button-task-list");
	buttonList.append('<li><a href="#remove"><i class="glyphicon glyphicon-minus-sign"></i></a> <span>' + buttonText + '</span></li>');
	return true;
}

function removeNewHotButtonElement(targetElement) {
	/*
	targetElement is the icon that is clicked.
	*/
	
	console.log(targetElement);
	if (!targetElement) {
		console.log("No element to remove");
		return false;
	}
	var targetParent = $(targetElement).parent().parent();
	console.log(targetParent);
	targetParent.remove();
	return true;
}

function saveTheTaskList() {
	var newItems = [];
	var currentItems = $("#hot-button-task-list li");
	$.each(currentItems, function(itemIdx, itemElem) {
		var me = $(itemElem);
		var myText = encodeURIComponent(me.find('span').text());
		newItems.push(myText);
	});
	
	var form = $("#hot-buttons-container form");
				
	var authenticity_token = form.find("input[name='authenticity_token']").val();
	var utf8 = form.find("input[name='utf8']").val();
	var method = form.find("input[name='_method']").val();
	
	var variableItemText = "";
	$.each(newItems, function(itemIdx, item) {
		variableItemText += "&variable_item[]="+item;
	});
	var postData = "authenticity_token="+authenticity_token + variableItemText;

	$.ajax({
		type: "PUT",
		url: postUrl,
		data: postData,
		success: function(returnData) {
			/*Yay!*/
		},
		error: function (errormessage) {
			/*Boo!*/
		}
	});
}

function focusHotButtonInput() {
	$("#hot_button_input").focus();
}

function addHotButtonItem(){
	var hotButtonInput = $("#hot_button_input");
	hotButtonInput.removeClass('invalid');
	var inputValue = hotButtonInput.val().trim();
	if (inputValue == "" || inputValue == undefined || inputValue == null) {
		hotButtonInput.addClass('invalid');
		return false;
	} else {
		/*Gather Up this item and all others and post them.*/
		var newItems = [];
		var currentItems = $("#hot-button-task-list li");
		$.each(currentItems, function(itemIdx, itemElem) {
			var me = $(itemElem);
			var myText = encodeURIComponent(me.find('span').text());
			newItems.push(myText);
		});
		
		newItems.push(encodeURIComponent(inputValue));
		
		if (postUrl == undefined || postUrl == "") {
			return false;
		}
		if (clientId == undefined || clientId == "") {
			return false;
		}
		
		var form = $("#hot-buttons-container form");
		
		var authenticity_token = form.find("input[name='authenticity_token']").val();
		var utf8 = form.find("input[name='utf8']").val();
		var method = form.find("input[name='_method']").val();
		
		var variableItemText = "";
		$.each(newItems, function(itemIdx, item) {
			variableItemText += "&variable_item[]="+item;
		});
		var postData = "authenticity_token="+authenticity_token + variableItemText;
		addNewHotButtonElement(inputValue);
		$.ajax({
			type: "PUT",
			url: postUrl,
			data: postData,
			success: function(returnData) {
				hotButtonInput.val('');
			},
			error: function (errormessage) {
				hotButtonInput.addClass('invalid');
			}
		});
		focusHotButtonInput();
	}
	
	return false;
}

function ready(){
	
	if ($("#hot_button_input").length) {
		//$('.widget-tab').on('click', function() {
		//	var me = $(this);
		//	if (me.hasClass('inactive')) {
		//		$('.widget-tab').addClass('inactive');
		//		me.removeClass('inactive');
		//		var myTarget = me.attr('data-target');
		//		var target = $("#"+myTarget);
		//		if (!target.is(":visible")) {
		//			$(".tab-active").removeClass('tab-active');
		//			target.addClass('tab-active');
		//		}
		//	}
		//});
		
		$('#hot-button-task-list').on('click', '.glyphicon-minus-sign', function(e) {
			e.preventDefault();
			/*
			Save the task list and remove it.
			*/
			removeNewHotButtonElement(this);
			saveTheTaskList();
			focusHotButtonInput();
		});
		
		focusHotButtonInput();
		$("#add-new-hotbutton a").on('click', function(e) {
			e.preventDefault();
			addHotButtonItem();
		});
		$("#hot_button_input").keypress(function(e) {
			if (e.keyCode==13){
				e.preventDefault();
				addHotButtonItem();
			}
		});
	}
}