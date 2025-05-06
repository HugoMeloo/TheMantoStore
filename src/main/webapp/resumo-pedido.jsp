<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Resumo do Pedido - The Manto Store</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="css/carrinho.css">
  <style>
    .resumo-card {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      border: 1px solid #ddd;
    }
    .produto-img {
      max-width: 70px;
      max-height: 70px;
      object-fit: cover;
      border-radius: 4px;
    }
    .btn-orange {
      background-color: #ff6600;
      border: none;
      color: #fff;
      font-weight: bold;
    }
  </style>
</head>
<body class="bg-light min-vh-100">

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
  <div class="row">
    <!-- Coluna esquerda -->
    <div class="col-lg-8 mb-4">
      <!-- Produtos -->
      <div class="resumo-card mb-4">
        <h5><i class="fas fa-box-open me-2"></i>Lista de Produtos</h5>
        <c:forEach var="item" items="${sessionScope.carrinho}">
          <div class="d-flex align-items-center border-bottom py-2">
            <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem" class="produto-img me-3">
            <div class="flex-grow-1">
              <strong>${item.produto.nomeProduto}</strong><br>
              Quantidade: ${item.quantidade}<br>
              Valor unitário: <fmt:formatNumber value="${item.produto.preco}" type="currency" currencyCode="BRL"/>
            </div>
            <div class="text-end">
              <strong><fmt:formatNumber value="${item.produto.preco * item.quantidade}" type="currency" currencyCode="BRL"/></strong>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Endereço -->
      <div class="resumo-card mb-4">
        <h5><i class="fas fa-map-marker-alt me-2"></i>Endereço de Entrega</h5>
        <p>
          <c:out value="${sessionScope.enderecoSelecionadoDetalhado}" default="Endereço não disponível." />
        </p>
      </div>

      <!-- Pagamento -->
      <div class="resumo-card">
        <h5><i class="fas fa-credit-card me-2"></i>Forma de Pagamento</h5>
        <p>
          <c:choose>
            <c:when test="${sessionScope.formaPagamento eq 'pix'}">PIX</c:when>
            <c:when test="${sessionScope.formaPagamento eq 'boleto'}">Boleto Bancário</c:when>
            <c:when test="${sessionScope.formaPagamento eq 'cartao'}">
              Cartão de Crédito - Final ${fn:substring(sessionScope.numeroCartao, fn:length(sessionScope.numeroCartao) - 4, fn:length(sessionScope.numeroCartao))}
            </c:when>
            <c:otherwise>Não informado</c:otherwise>
          </c:choose>
        </p>
      </div>
    </div>

    <!-- Coluna direita -->
    <div class="col-lg-4">
      <div class="resumo-card">
        <h5><i class="fas fa-receipt me-2"></i>Resumo Financeiro</h5>
        <p>Produtos: <strong><fmt:formatNumber value="${sessionScope.valorProdutos}" type="currency" currencyCode="BRL"/></strong></p>
        <p>Frete: <strong><fmt:formatNumber value="${sessionScope.valorFrete}" type="currency" currencyCode="BRL"/></strong></p>
        <p>Desconto no PIX: <span class="text-success">- <fmt:formatNumber value="${sessionScope.descontoPix}" type="currency" currencyCode="BRL"/></span></p>
        <hr>
        <h5>Total: <fmt:formatNumber value="${sessionScope.totalPix}" type="currency" currencyCode="BRL"/></h5>

        <form action="concluir-compra" method="post" class="mt-4">
          <button type="submit" class="btn btn-orange w-100">CONCLUIR COMPRA</button>
        </form>
        <a href="pagamento.jsp" class="btn btn-outline-secondary w-100 mt-2">VOLTAR</a>
      </div>
    </div>
  </div>
</div>

</body>
</html>
