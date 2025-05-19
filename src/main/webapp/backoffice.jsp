<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null || sessao.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String tipoUsuario = (String) sessao.getAttribute("tipoUsuario");
    String emailLogado = (String) sessao.getAttribute("email");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestão de Usuários</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Administração de Usuários</a>
        <a href="/logout" class="btn btn-danger">Sair</a>
    </div>
</nav>

<div class="container mt-4">
    <h1 class="text-center">Gestão de Usuários</h1>
    <!-- Alerta de erro -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Campo de filtro -->
    <div class="mb-3">
        <input type="text" id="filtroNome" class="form-control" placeholder="Filtrar por nome..."
               onkeyup="filtrarUsuarios()">
    </div>

    <!-- Botão para abrir o modal de cadastro -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">+ Adicionar Usuário
    </button>


    <table class="table table-striped" id="tabelaUsuarios">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Status</th>
            <th>Grupo</th>
            <% if ("admin".equals(tipoUsuario)) { %>
            <th>Ações</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="usuario" items="${users}">
            <tr>
                <td>${usuario.idUser}</td>
                <td>${usuario.nome}</td>
                <td>${usuario.email}</td>
                <td>
                    <span class="badge ${usuario.status ? 'bg-success' : 'bg-danger'}">
                            ${usuario.status ? "Ativo" : "Inativo"}
                    </span>
                </td>
                <td>
                    <c:if test="${usuario.email ne emailLogado}">
                    <form action="/admin/AlterarGrupoUsuario" method="POST">
                        <input type="hidden" name="idUser" value="${usuario.idUser}">
                        <select name="grupo" class="form-select" onchange="this.form.submit()">
                            <option value="user" ${usuario.grupo eq 'user' ? 'selected' : ''}>Estoquista</option>
                            <option value="admin" ${usuario.grupo eq 'admin' ? 'selected' : ''}>Administrador</option>
                        </select>
                    </form>

                <td>
                    <!-- Botão para abrir o modal -->
                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#editUserModal"
                            onclick="preencherCamposUsuario('${usuario.idUser}', '${usuario.nome}', '${usuario.cpf}')">
                        Alterar
                    </button>
                    <a href="AlterarStatusUsuario?id=${usuario.idUser}&status=${!usuario.status}"
                       class="btn ${usuario.status ? 'btn-danger' : 'btn-success'} btn-sm">
                            ${usuario.status ? "Inativar" : "Ativar"}
                    </a>
                </td>

                </c:if>
                <c:if test="${usuario.email eq emailLogado}">
                    ${usuario.grupo}
                </c:if>
                </td>
                <% if ("admin".equals(tipoUsuario)) { %>

                <% } %>
            </tr>
        </c:forEach>
        </tbody>
    </table>


    <button type="button" class="btn btn-primary" onclick="window.location.href='/admin/ExibirProdutos'">
        Ir para Lista de Produtos
    </button>


</div>

<!-- Modal de Cadastro -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Cadastrar Usuário</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="/create-user" method="post">
                    <h1>Criar conta</h1>

                    <!-- Campo Nome -->
                    <input type="text" name="name" id="name" placeholder="Nome" class="form-control mb-3" required>

                    <!-- Campo Email -->
                    <input type="email" name="email" id="email" placeholder="Email" class="form-control mb-3" required>

                    <!-- Campo CPF -->
                    <input type="text" name="cpf" id="cpf" placeholder="CPF" class="form-control mb-3" required>

                    <!-- Campo Senha -->
                    <input type="password" name="senhaCadastro" id="senhaCadastro" placeholder="Senha"
                           class="form-control mb-3" required>

                    <!-- Campo Confirmar Senha -->
                    <input type="password" name="confirmarSenha" id="confirmarSenha" placeholder="Confirmar Senha"
                           class="form-control mb-3" required>

                    <!-- Campo Grupo (ADICIONE AQUI) -->
                    <div class="form-group mb-3">
                        <label for="grupo">Grupo:</label>
                        <select class="form-select" id="grupo" name="grupo" required>
                            <option value="est">Estoquista</option>
                            <option value="admin">Administrador</option>
                            <!-- Adicione mais grupos se necessário -->
                        </select>
                    </div>

                    <!-- Botão de Cadastro -->
                    <button class="btn btn-primary w-100" type="submit">Cadastrar</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Modal de Edição -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Usuário</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="/admin/alterarUsuario" method="POST">
                    <input type="hidden" id="editUserId" name="userId">

                    <div class="mb-3">
                        <label for="editNome" class="form-label">Nome:</label>
                        <input type="text" class="form-control" id="editNome" name="nome" required>
                    </div>

                    <div class="mb-3">
                        <label for="editCpf" class="form-label">CPF:</label>
                        <input type="text" class="form-control" id="editCpf" name="cpf" required>
                    </div>

                    <div class="mb-3">
                        <label for="editSenha" class="form-label">Nova Senha:</label>
                        <input type="password" class="form-control" id="editSenha" name="senha">
                    </div>

                    <div class="mb-3">
                        <label for="confirmSenha" class="form-label">Confirmar Nova Senha:</label>
                        <input type="password" class="form-control" id="confirmSenha" name="confirmSenha">
                    </div>

                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    function preencherCamposUsuario(id, nome, cpf) {
        // Preencher os campos do modal com os dados do usuário
        document.getElementById('editUserId').value = id;
        document.getElementById('editNome').value = nome;
        document.getElementById('editCpf').value = cpf;
        // Não preencher a senha
        document.getElementById('editSenha').value = '';
        document.getElementById('confirmSenha').value = '';
    }
</script>

<script src="../js/alterar.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
