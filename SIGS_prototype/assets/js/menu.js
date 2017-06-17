$(document).ready(function (){
  // addItem("Minha Conta", "minha_conta", "myNavBar");
  // addItem("Logout", "../index", "myNavBar");
  addItem("Alocar", "visualizar_turmas", "myNavBar");
  addItem("Cadastros Pendentes", "cadastros_pendentes", "Usuários");
  addItem("Usuários Registrados", "usuarios_registrados", "Usuários");
  // menuDropdown("Turmas");
  menuDropdown("Salas");
  menuDropdown("Relatórios");
  addItem("Salas", "salas", "Salas");
  addItem("Categorias", "categorias", "Salas");
  // menuDropdown("Alocar");
  // addItem("Nova Turma", "criar_turma", "Alocar");
  // addItem("Meu Departamento", "visualizar_turmas", "Alocar");
  // addItem("Graduação", "home", "Alocar")
  // addItem("Extensão", "home", "Alocar")
  // addItem("Solicitar(alocacao)", "solicitar1", "Alocar")
  // addItem("Solicitar(ajuste)", "solicitar2", "Alocar")
  addItem("por Disciplina", "relatorio_por_disciplina", "Relatórios")
  addItem("por Sala", "relatorio_por_sala", "Relatórios")
  addItem("por Prédio", "relatorio_por_predio", "Relatórios")
  menuDropdown("Usuários");
});

function addItem(name, page, father) {
  father = "#" + father
  $(father).append("<li><a href='" + page + ".html'>" + name + "</a></li>")
}

function menuDropdown(name) {
  $("#myNavBar").append("<li class='dropdown'><a data-toggle='collapse' href='#" + name + "'>" + name + "</a><ul class='collapse' id='" + name + "'></ul></li>")
}
