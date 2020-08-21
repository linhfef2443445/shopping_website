$(document).ready(function () {
  $('.action_link').click(function() {
    $.ajax({
      type: 'POST',
      url: '/carts',
      data: { "stt": $(this).data("stt") + 1,
              "product_id": $(this).data("id"),
              "size": $("#size").val() },
      error:function(){
        $('#ajax_response').html('<p class="error"><strong>Oops!</strong> Try that again in a few moments.</p>');
      }
    });
  }); 
});
