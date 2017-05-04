$(document).ready(function(){

  $("#dropdown-department-assistant").hide();
  $("#dropdown-coordinator").hide();

  $('input[name="type"]').change(function () {
    if ($('input[name="type"]:checked').val() === "coordinator") {
      $("#dropdown-department-assistant").hide();
      $('#dropdown-coordinator').show();
    } else if ($('input[name="type"]:checked').val() === "department_assistant") {
      $("#dropdown-coordinator").hide();
      $("#dropdown-department-assistant").show();
    } else {
      $("#dropdown-coordinator").hide();
      $("#dropdown-department-assistant").hide();
    }
  });

  $(".enterForm").bind('submit', function(e) {
    if ($("#session_email").val() == '' || $("#session_password") == '') {
      e.preventDefault();
      $("#errorModal").modal('show');
      $(".errorTxt").html("Por favor, preencha os campos <strong>Nome de Usuário</strong> e <strong>Senha</strong> corretamente.");
    }
  });

  $('#errorModal').on('hidden.bs.modal', function () {
    $(".enterForm").unbind('submit').submit();
  })

  $(".alert").hide().fadeIn(3000);
  setTimeout("$(\".alert-success\").show().fadeOut(3000);", 10000);
  setTimeout("$(\".alert-notice\").show().fadeOut(3000);", 10000);

});
