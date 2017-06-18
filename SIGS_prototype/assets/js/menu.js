$(document).ready(function () {
  addItem("Alocar", "visualizar_turmas", "myNav", "col2");
  menuDropdown("Usuários");
  addItem("Cadastros Pendentes", "cadastros_pendentes", "Usuários", "col1");
  addItem("Usuários Registrados", "usuarios_registrados", "Usuários", "col1");
  menuDropdown("Salas");
  menuDropdown("Relatórios");
  addItem("Salas", "salas", "Salas", "col1");
  addItem("Categorias", "categorias", "Salas", "col1");
  addItem("Relatório por Disciplina", "relatorio_por_disciplina", "Relatórios", "col2");
  addItem("Relatório por Sala", "relatorio_por_sala", "Relatórios", "col2");
  addItem("Relatório por Prédio", "relatorio_por_predio", "Relatórios", "col2");
});

function addItem(name, page, father, colFooter) {
  $("#" + father).append("<li><a href='" + page + ".html'>" + name + "</a></li>");
  $("#" + colFooter).find(".myList").append("<li><a href='" + page + ".html'>" + name + "</a></li>");
}

function menuDropdown(name) {
  $("#myNav").append('<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">' + name + '<span class="caret"></span></a><ul class="dropdown-menu" id="' + name + '"></ul></li>');
}
