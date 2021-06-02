$(document).ready(function(){
  $('#request_type_request').on('change',function(){
    var text = $(this).val()
    $.ajax({
      method: "GET",
      url: '/employee/requests/change_select',
      data: { type_request: text },
      success: function(data){
        console.log(data)        
      }
    })
  });
});
