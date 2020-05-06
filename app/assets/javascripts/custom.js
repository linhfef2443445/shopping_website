$(document).ready(function () {
  $(".product-quantity").on("change", function() {
    product_id = $(this).data("product-id");
    hidden_field_id = "#product-quantity-hidden-" + product_id;
    $(hidden_field_id).val($(this).val());
  });
});
