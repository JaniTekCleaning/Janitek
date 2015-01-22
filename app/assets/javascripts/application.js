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
//= require angular
//= require_tree .

$(document).ready(ready);
$(document).on('page:load', ready);

function isLastListElement(element){
	var list=element.parent();
	var last=list.children().last();
	return last.is(element);
}

function checkLastEmpty(){
	$('.notice').remove();
	var list=$('#EditHotButtonList');
	var last=list.children().last();
	var input=last.find('input')
	if (input.val()){
		list.append("<li><input type='text' name='hotbutton_item[]' class='hotbutton_item'></li>")
		var last=list.children().last();
		var input=last.find('input')
		input.keyup(checkLastEmpty);
	}
}

function ready(){
	$('.hotbutton_item').each(function(){
		$(this).keyup(checkLastEmpty);
	})
	var list=$('#EditHotButtonList');
	list.focusout(function(){
		$('.hotbutton_item').each(function(){
			if(!$(this).val().trim()){
				if (!isLastListElement($(this).parent())){
					$(this).parent().remove();
				}
			}
		})
	});

	list.append("<li><input type='text' name='hotbutton_item[]' class='hotbutton_item'></li>")
	list.children().last().find('input').keyup(checkLastEmpty);
	// checkLastEmpty(true);
}