$( "form#new_registration" ).submit(function( event ) {
  //fileType = $('input:file').prop('files')[0]['type']
  var hasError = false;

  $('input:text').each(function(){
    if (this.value == "") {
      $(this).addClass('has-error');
      hasError = true;
    } else {
      $(this).removeClass('has-error');
    }
  });

  if (hasError) {
    alert( "Verifique os campos em vermelho." );
    event.preventDefault();
  }
});
