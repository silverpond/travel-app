function airport_autocomplete(selector){
  $(selector).autocomplete({
    source: function(arg, response_call_back ){
      $.ajax({
        url: '/airports/autocomplete_by_name',
        data: {
          term : arg.term
        },
        success: function(data){
          if (data.length > 0) {
            response_call_back(data);
        } else {
          $(selector).val('');
        }
        }
      })
    },
    select: function(event, ui){
      var airport_code = ui.item.value
      $(selector).val(airport_code)
    }
  });
}


$(function(){

  airport_autocomplete("#travel_from")
  airport_autocomplete("#travel_to")

})
