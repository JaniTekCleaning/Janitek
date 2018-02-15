$(document).ready(function(){
  $('#BuildingSelect').change(function(){
    var id = $(this).val();
    $('#BuildingSelectIdentifier').val(id)
    $('#BuildingSelectForm').submit()
  });
});