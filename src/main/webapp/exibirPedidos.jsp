<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.CarrinhoItem, model.Produtos" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meus Pedidos - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/carrinho.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">


<!-- Cabeçalho -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/">
            <i class="fas fa-tshirt me-2"></i>The Manto Store
        </a>
        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <a href="/minhaConta" class="btn btn-outline-light me-2">
                        <i class="fas fa-user-cog"></i>
                        <span class="d-none d-lg-inline ms-1">Minha Conta</span>
                    </a>
                    <a href="/logout" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="d-none d-lg-inline ms-1">Sair</span>
                    </a>
                </c:when>
            </c:choose>

            <a href="/carrinho" class="btn btn-outline-light position-relative">
                <i class="fas fa-shopping-cart"></i>
                <span class="d-none d-lg-inline ms-1">Carrinho</span>
                <c:if test="${not empty sessionScope.carrinho}">
                    <span class="cart-count">${sessionScope.carrinho.size()}</span>
                </c:if>
            </a>
        </div>
    </div>
</nav>
<div class="container py-5">

    <h2 class="mb-4">Meus Pedidos</h2>

    <c:if test="${empty pedidos}">
        <div class="alert alert-info">Você ainda não fez nenhum pedido.</div>
    </c:if>

    <c:forEach var="pedido" items="${pedidos}" varStatus="status">

        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between align-items-center">
                <div>
                    <strong>Pedido #${pedido.numPedido}</strong> -
                    <fmt:formatDate value="${pedido.dataCriacaoDate}" pattern="dd/MM/yyyy HH:mm"/>
                    <span class="text-muted">${pedido.status}</span>
                </div>
                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse"
                        data-bs-target="#detalhes-${pedido.idPedido}">
                    Detalhes
                </button>
            </div>
            <c:set var="endereco" value="${enderecos[status.index]}"/>
            <div id="detalhes-${pedido.idPedido}" class="collapse">
                <div class="card-body">
                    <p><strong>Forma de Pagamento:</strong> ${pedido.formaPagamento}</p>
                    <p><strong>Total:</strong> <fmt:formatNumber value="${pedido.valorTotal}" type="currency"
                                                                 currencyCode="BRL"/></p>
                    <p><strong>Frete:</strong> <fmt:formatNumber value="${pedido.valorFrete}" type="currency"
                                                                 currencyCode="BRL"/></p>
                    <p><strong>Endereço de Entrega:</strong>
                            ${endereco.logradouro}, ${endereco.numero}
                            ${endereco.bairro}, ${endereco.cidade} - ${endereco.uf}
                        CEP: ${endereco.cep}
                    </p>
                    <h6 class="mt-3">Produtos:</h6>
                    <table class="table table-sm">
                        <thead>
                        <tr>
                            <th>Produto</th>
                            <th>Quantidade</th>
                            <th>Unitário</th>
                            <th>Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${pedido.itens}">
                            <tr>
                                <td>${item.produto.nomeProduto}</td>
                                <td>${item.quantidade}</td>
                                <td><fmt:formatNumber value="${item.produto.preco}" type="currency"
                                                      currencyCode="BRL"/></td>
                                <td>
                                    <fmt:formatNumber value="${item.produto.preco * item.quantidade}" type="currency"
                                                      currencyCode="BRL"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
