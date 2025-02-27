<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <a href="login.jsp" class="btn btn-danger">Sair</a>
    </div>
</nav>

<div class="container mt-4">
    <h1 class="text-center">Gestão de Usuários</h1>

    <!-- Campo de filtro -->
    <div class="mb-3">
        <input type="text" id="filtroNome" class="form-control" placeholder="Filtrar por nome..." onkeyup="filtrarUsuarios()">
    </div>

    <!-- Botão para abrir o modal de cadastro -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">+ Adicionar Usuário</button>

    <table class="table table-striped" id="tabelaUsuarios">
        <thead class="table-dark">
            <tr>
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
                    <td>${usuario.nome}</td>
                    <td>${usuario.email}</td>
                    <td>
                        <span class="badge ${usuario.status ? 'bg-success' : 'bg-danger'}">
                            ${usuario.status ? "Ativo" : "Inativo"}
                        </span>
                    </td>
                    <td>
                        <c:if test="${usuario.email ne emailLogado}">
                            <form action="AlterarGrupoUsuario" method="POST">
                                <input type="hidden" name="idUser" value="${usuario.idUser}">
                                <select name="grupo" class="form-select" onchange="this.form.submit()">
                                    <option value="user" ${usuario.grupo eq 'user' ? 'selected' : ''}>Usuário</option>
                                    <option value="admin" ${usuario.grupo eq 'admin' ? 'selected' : ''}>Administrador</option>
                                </select>
                            </form>
                        </c:if>
                        <c:if test="${usuario.email eq emailLogado}">
                            ${usuario.grupo}
                        </c:if>
                    </td>
                    <% if ("admin".equals(tipoUsuario)) { %>
                        <td>
                            <button class="btn btn-warning btn-sm" onclick="editarUsuario('${usuario.idUser}', '${usuario.nome}', '${usuario.cpf}')">Editar</button>
                            <a href="AlterarStatusUsuario?id=${usuario.idUser}&status=${!usuario.status}"
                               class="btn ${usuario.status ? 'btn-danger' : 'btn-success'} btn-sm">
                               ${usuario.status ? "Inativar" : "Ativar"}
                            </a>
                        </td>
                    <% } %>
                </tr>
            </c:forEach>
        </tbody>
    </table>
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
                <form action="/create-user" method="POST">
                    <div class="mb-3">
                        <label for="cadastroNome" class="form-label">Nome:</label>
                        <input type="text" class="form-control" id="cadastroNome" name="nome" required>
                    </div>

                    <div class="mb-3">
                        <label for="cadastroEmail" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="cadastroEmail" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label for="cadastroCpf" class="form-label">CPF:</label>
                        <input type="text" class="form-control" id="cadastroCpf" name="cpf" required>
                    </div>

                    <div class="mb-3">
                        <label for="cadastroSenha" class="form-label">Senha:</label>
                        <input type="password" class="form-control" id="cadastroSenha" name="senha" required>
                    </div>

                    <div class="mb-3">
                        <label for="cadastroConfirmSenha" class="form-label">Confirmar Senha:</label>
                        <input type="password" class="form-control" id="cadastroConfirmSenha" name="confirmSenha" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Cadastrar</button>
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
                <form action="AlterarUsuario" method="POST">
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

<script src= "../js/alterar.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
