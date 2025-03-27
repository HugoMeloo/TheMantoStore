<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="">The Manto Store</a>
        <a href="/carrinho" class="me-3">
            <img src="img/carrinho.png" alt="Carrinho" style="width: 30px; height: 30px;">
        </a>
    </div>
</nav>

<div class="container mt-5">
    <h2>Seu Carrinho</h2>

    <c:if test="${empty sessionScope.carrinho}">
        <p>O carrinho está vazio.</p>
    </c:if>

    <c:forEach var="item" items="${sessionScope.carrinho}">
        <div class="product-card d-flex align-items-center mb-4">
            <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem do Produto" style="width: 90px;">
            <div class="product-info ms-3">
                <h5>${item.produto.nomeProduto}</h5>
                <p>Preço: R$ ${item.produto.preco}</p>
                <p>Quantidade: ${item.quantidade}</p>
                <p>Status:
                    <c:choose>
                        <c:when test="${item.produto.status}">
                            Disponível
                        </c:when>
                        <c:otherwise>
                            Indisponível
                        </c:otherwise>
                    </c:choose>
                </p>
                <!-- Botões de adicionar/remover quantidade -->
                <a href="/carrinho?id=${item.produto.id}&acao=adicionar" class="btn btn-success">Adicionar 1</a>
                <a href="/carrinho?id=${item.produto.id}&acao=remover" class="btn btn-danger">Remover 1</a>
            </div>
        </div>
    </c:forEach>

    <div class="summary-card mt-4">
        <h5>Resumo do Carrinho</h5>
        <p>Total: R$ ${totalCarrinho}</p>


        <!-- Formulário para finalizar a compra -->
        <form action="carrinho" method="POST">
            <button type="submit" class="btn btn-primary mt-3">Finalizar Compra</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
