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
//= require_tree .

/* Script para Página de Cadastro */

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


});

// $("#dropdown-department-assistant").hide();
// $("#dropdown-coordinator").hide();
//
// $("input:radio[name='type']").change(function(){
//
//     if(this.value == 'department_assistant' && this.checked){
//       $("#dropdown-department-assistant").show();
//     }else{
//       $("#dropdown-department-assistant").hide();
//     }
//
//     if(this.value == 'coordinator' && this.checked){
//       $("#dropdown-coordinator").show();
//     }else{
//       $("#dropdown-coordinator").hide();
//     }
// });
