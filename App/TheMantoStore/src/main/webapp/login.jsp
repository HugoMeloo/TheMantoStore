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
    <!-- Formulário de Cadastro -->
    <div class="form-container cadastrar">
        <form action="sem cadastro de cliente no momento" method="post">
            <h1>Criar Conta</h1>
            <input type="text" name="name" id="name" placeholder="Nome" value="${param.nome}" class="form-control" required>
            <input type="email" name="email" id="email" placeholder="Email" value="${param.email}" class="form-control" required>
            <input type="text" name="cpf" id="cpf" placeholder="CPF" value="${param.cpf}" class="form-control" required>
            <input type="password" name="senha" id="senhaCadastro" placeholder="Senha" class="form-control" required>
            <input type="password" name="confirmarSenha" id="confirmarSenha" placeholder="Confirmar Senha" class="form-control" required>
            <button class="btn btn-primary" type="submit">Cadastrar</button>
        </form>
    </div>

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
                <p>Cadastre-se agora e aproveite a praticidade de comprar suas camisas com conforto e segurança!</p>
                <button class="hidden" id="register">Cadastrar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="js/login.js"></script>

</body>
</html>
