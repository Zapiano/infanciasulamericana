$( "form#new_registration" ).submit(function( event ) {
  fileProps = $('input:file').prop('files')[0];
  fileSize = fileProps.size;
  fileType = fileProps.type;

  regexExe = new RegExp("application");
  regexDoc = new RegExp("office");

  var hasError = false;

  $('input:text').each(function(){
    if (this.value == "") {
      $(this).addClass('has-error');
      hasError = true;
    } else {
      $(this).removeClass('has-error');
    }
  });

  if (fileSize > 200000) {
    alert( "Tamanho do arquivo maior que o máximo permitido (200 Kb)." );
    event.preventDefault();
  }

  if ( regexExe.test(fileType) ) {
    alert( "Formato do arquivo inválido." );
    event.preventDefault();
  }

  if (hasError) {
    alert( "Verifique os campos em vermelho." );
    event.preventDefault();
  }

});
