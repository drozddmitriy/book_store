$(document).ready(function(){
  var checkbox = $('#use_billing');

  if (checkbox.is(':checked'))
  {
    $(".hideShipping").hide();
    $(this).val('true');
  }
  else
  {
    $(".hideShipping").show();
    $(this).val('false');
  }

  $(".checkbox-icon").click(function(){
    $('.hideShipping').toggle();
  })
});
