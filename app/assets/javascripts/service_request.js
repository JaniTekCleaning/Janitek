$(document).ready(service_request_ready);
$(document).on('page:load', service_request_ready);

function maxFormNumber(){
  var formNumber = 0;
  $('#EditServiceRequestFormItems li').each(function(){
    var curNumber = parseInt($(this).data('form-number'));
    if (curNumber > formNumber){
      formNumber = curNumber;
    }
    });
  return formNumber;
}

function isLastListElement(element){
  var list = element.parent();
  var last = list.children().last();
  return last.is(element);
}

function removeButtonPressed(index){
  $('li[data-form-number='+index+']').remove();
  checkLastEmpty();
}

function appendServiceRequestField(){
  $('#EditServiceRequestFormItems li a.btn.btn-hidden').removeClass('btn-hidden').removeAttr('disabled');
  var list = $('#EditServiceRequestFormItems');
  formNumber = maxFormNumber()+1;
  list.append("<li data-form-number='" + formNumber + "'>"
      +'<div class="form-wrapper">'
        +"<a disabled class='btn btn-danger btn-hidden remove-service-request-item-button' onclick='removeButtonPressed("+formNumber+")'>Remove</a> "
        +"<input type='text' id='field-title-"+formNumber+"' name='service_item_title["+formNumber+"]' placeholder='Title' class='item_title_input'>"
        +'<div class="field-type-wrapper">'
          +"<label for='field-type-"+formNumber+"'>Field Type</label>"
          +"<select id='field-type-"+formNumber+"' name='service_item_type["+formNumber+"]'>"
            +"<option value='shortText'>Short Text</option>"
            +"<option value='longText'>Long Text</option>"
            +"<option value='checkbox'>Checkbox</option>"
          +"</select>"
        +'</div>'
        //+'<div class="field-required-wrapper">'
        //  +"<input id='field-required-"+formNumber+"' type='checkbox' name='service_item_required["+formNumber+"]'>"
        //  +" <label for='field-required-"+formNumber+"'>Field Required</label>"
        //+'</div>'
      +"</div>"
      +"</li>");
  list.children().last().find('input').keyup(checkLastEmpty);
}

function checkLastEmpty(){
  $('.notice').remove();
  var list = $('#EditServiceRequestFormItems');
  var last = list.children().last();
  var input = last.find('input')
  if (input.val() || input.length==0 ){
    appendServiceRequestField();
  }
}

function service_request_ready(){
  $('#EditServiceRequestFormItems li input.item_title_input').each(function(){
    $(this).keyup(checkLastEmpty);
  })
  var list=$('#EditServiceRequestFormItems');
  list.focusout(function(){
    $('.item_title_input').each(function(){
      if(!$(this).val().trim()){
        if (!isLastListElement($(this).parent())){
          $(this).parent().remove();
        }
      }
    })
  });
  appendServiceRequestField();
  
  // checkLastEmpty(true);
}