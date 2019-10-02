$(document).ready(function(){
  $('.fa-minus').parent('#minus').click(function(event){
    var input;
    var quantity;
    input = $(this).siblings('.quantity-input');
    quantity = +input.val();
    if (quantity > 1) {
      return input.val(quantity - 1);
    }
  });

  $('.fa-plus').parent('#plus').click(function(event) {
    var input;
    var quantity;
    input = $(this).siblings('.quantity-input');
    quantity = +input.val();
    return input.val(quantity + 1);
  });
});
