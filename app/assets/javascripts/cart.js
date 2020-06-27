$(document).ready(function () {
  // function myFunction(current_select){
  //   val size = current_select.value 
  // };
  $('.action_link').click(function() {
  debugger
      $.ajax({
        type: 'POST',
        url: '/carts',
        data: { "product_id": "<%=@product.id=%>" },
        success:function(data){
        alert('ok')
        },
        error:function(){
          $('#ajax_response').html('<p class="error"><strong>Oops!</strong> Try that again in a few moments.</p>');
        }
      });
  }); 
});