$(document).ready(function (){
  addItem("Minha Conta", "minha_conta", "myNavBar");
  addItem("Logout", "../index", "myNavBar");
  menuDropdown("Usuários");
  addItem("Cadastros Pendentes", "cadastros_pendentes", "Usuários")
  addItem("Usuários Registrados", "usuarios_registrados", "Usuários")
  menuDropdown("Turmas")
  addItem("Nova Turma", "criar_turma", "Turmas");
  addItem("Meu Departamento", "visualizar_turmas", "Turmas");
  menuDropdown("Salas");
  addItem("Salas", "salas", "Salas")
  addItem("Categorias", "categorias", "Salas")
  menuDropdown("Alocações");
  addItem("Graduação", "home", "Alocações")
  addItem("Extensão", "home", "Alocações")
  menuDropdown("Relatórios");
  addItem("por Sala", "relatorio_por_sala", "Relatórios")
});

function addItem(name, page, father) {
  father = "#" + father
  $(father).append("<li><a href='" + page + ".html'>" + name + "</a></li>")
}

function menuDropdown(name) {
  $("#myNavBar").append("<li class='dropdown'><a data-toggle='collapse' href='#" + name + "'>" + name + "</a><ul class='collapse' id='" + name + "'></ul></li>")
}
