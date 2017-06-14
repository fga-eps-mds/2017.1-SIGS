$(document).ready(function (){
  addItem("Minha Conta", "minha_conta", "myNavBar");
  addItem("Logout", "../index", "myNavBar");
  menuDropdown("Usuários");
  addItem("Cadastros Pendentes", "cadastros_pendentes", "Usuários");
  addItem("Usuários Registrados", "usuarios_registrados", "Usuários");
  menuDropdown("Turmas");
  addItem("Nova Turma", "criar_turma", "Turmas");
  addItem("Meu Departamento", "visualizar_turmas", "Turmas");
  menuDropdown("Salas");
  addItem("Salas", "salas", "Salas");
  addItem("Categorias", "categorias", "Salas");
  menuDropdown("Alocações");
  addItem("Solicitações Pendentes", "visualizar_solicitacoes", "Alocações");
  addItem("Graduação", "home", "Alocações")
  addItem("Extensão", "home", "Alocações")
  addItem("Solicitar(alocacao)", "solicitar1", "Alocações")
  addItem("Solicitar(ajuste)", "solicitar2", "Alocações")
  menuDropdown("Relatórios");
  addItem("por Disciplina", "relatorio_por_disciplina", "Relatórios")
  addItem("por Sala", "relatorio_por_sala", "Relatórios")
  addItem("por Prédio", "relatorio_por_predio", "Relatórios")
});

function addItem(name, page, father) {
  father = "#" + father
  $(father).append("<li><a href='" + page + ".html'>" + name + "</a></li>")
}

function menuDropdown(name) {
  $("#myNavBar").append("<li class='dropdown'><a data-toggle='collapse' href='#" + name + "'>" + name + "</a><ul class='collapse' id='" + name + "'></ul></li>")
}
