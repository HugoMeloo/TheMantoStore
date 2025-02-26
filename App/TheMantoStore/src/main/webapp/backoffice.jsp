<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null || sessao.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String tipoUsuario = (String) sessao.getAttribute("tipoUsuario");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Backoffice - The Manto Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Backoffice - The Manto Store</a>
        <a href="login.jsp" class="btn btn-danger">Sair</a>
    </div>
</nav>

<div class="container mt-4">
    <h1 class="text-center">Painel Administrativo</h1>

    <h2 class="mt-4">Lista de Camisas</h2>
    <div class="row">
        <%-- Produtos dinâmicos para evitar código repetitivo --%>
        <% String[] produtos = {"Flamengo 2024", "Palmeiras 2024", "São Paulo 2024"};
           double[] precos = {299.90, 279.90, 259.90};
           for (int i = 0; i < produtos.length; i++) { %>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Camisa <%= produtos[i] %></h5>
                        <p class="card-text">Preço: R$ <%= precos[i] %></p>
                        <% if ("admin".equals(tipoUsuario)) { %>
                            <a href="#" class="btn btn-primary">Editar</a>
                            <a href="#" class="btn btn-danger">Remover</a>
                        <% } %>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <h2 class="mt-4">Gerenciamento de Usuários</h2>
    <table class="table table-striped mt-4">
        <thead class="table-dark">
            <tr>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Status</th>
                <% if ("admin".equals(tipoUsuario)) { %>
                    <th>Ações</th>
                <% } %>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td> <!-- Nome -->
                <td></td> <!-- Email -->
                <td></td> <!-- CPF -->
                <td></td> <!-- Status -->
                <% if ("admin".equals(tipoUsuario)) { %>
                    <td>
                        <a href="#" class="btn btn-primary btn-sm">Editar</a>
                        <a href="#" class="btn btn-danger btn-sm">Remover</a>
                    </td>
                <% } %>
            </tr>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
