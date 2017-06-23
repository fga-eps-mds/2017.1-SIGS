// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require data-confirm-modal
//= require_tree .

/* Script para Página de Cadastro */

$(document).ready(function(){

  $("#dropdown-coordinator").hide();

  $('input[name="type"]').change(function () {
    if ($('input[name="type"]:checked').val() === "coordinator") {
      $('#dropdown-coordinator').show();
    } else {
      $("#dropdown-coordinator").hide();
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

  $(".sala").val($("#sala").val());

  $('#select-Segunda').on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('#select-Terça').on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('#select-Quarta').on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('#select-Quinta').on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('#select-Sexta').on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('#select-Sábado').on('click',
    function () {
      $(this).addClass("not-modify");
  });


  $(".autofill-field").on('click',
    function () {
      $(this).addClass("not-modify");
  });

  $('.label-check').empty();

  //remove 'can't be blank' error mensage from registration pg when password is send empty
  $('#erro-message').find('li:contains("can\'t be blank")').remove();

});
