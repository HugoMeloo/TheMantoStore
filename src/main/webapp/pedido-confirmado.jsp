<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Pedido Confirmado - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-confirmacao {
            max-width: 600px;
            margin: 80px auto;
            padding: 30px;
            border-radius: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            text-align: center;
        }
        .btn-orange {
            background-color: #ff6600;
            border: none;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="card-confirmacao shadow">
    <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
    <h2 class="mb-3">Pedido Realizado com Sucesso!</h2>

    <p class="fs-5 mb-1">Número do Pedido:</p>
    <p class="fs-4 fw-bold text-primary">#${sessionScope.numeroPedido}</p>

    <p class="fs-5 mb-1">Valor Total:</p>
    <p class="fs-4 fw-bold text-success">
        <fmt:formatNumber value="${sessionScope.valorTotal}" type="currency" currencyCode="BRL"/>
    </p>

    <p class="text-muted mt-4">Acompanhe seu pedido na área de pedidos ou continue comprando.</p>

    <div class="d-flex justify-content-center gap-3 mt-4">
        <a href="/" class="btn btn-outline-secondary">Voltar à Loja</a>
        <a href="/exibirPedidos" class="btn btn-orange">Ver Meus Pedidos</a>
    </div>
</div>

</body>
</html>
