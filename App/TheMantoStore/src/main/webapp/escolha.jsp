<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Escolha</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

<div class="card p-4">
    <h2 class="text-center">O que deseja fazer?</h2>
    <form action="redirecionar" method="post">
        <button type="submit" name="opcao" value="1" class="btn btn-primary w-100 mb-2">Listar Produtos</button>

        <% if ("admin".equals(tipoUsuario)) { %>
        <button type="submit" name="opcao" value="2" class="btn btn-secondary w-100">Listar Usuários</button>
        <% } %>
    </form>
</div>

</body>
</html>
