<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
    <title>Login</title>
</head>
<body>

<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
<script>
    alert("<%= errorMessage %>");
</script>
<%
    }
%>

<div class="container" id="container">
    <!-- Formulário de Login -->
    <div class="form-container login">
        <form action="/login" method="post">
            <h1>Logar</h1>
            <input type="email" name="loginEmail" id="loginEmail" placeholder="Email" class="form-control" required>
            <input type="password" name="loginSenha" id="loginSenha" placeholder="Senha" class="form-control" required>
            <button class="btn btn-primary" type="submit">Entrar</button>
        </form>
    </div>

    <!-- Alternador entre login e cadastro -->
    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-left">
                <h1>Olá!</h1>
                <p>Faça login e tenha acesso completo ao serviço.</p>
                <button class="hidden" id="login">Logar</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Olá, Amigo!</h1>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="js/login.js"></script>

</body>
</html>
