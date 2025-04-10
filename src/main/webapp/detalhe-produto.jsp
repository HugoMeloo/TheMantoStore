<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Produto</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/detalhe.css">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/">
            <i class="fas fa-tshirt me-2"></i>The Manto Store
        </a>

        <form class="d-flex flex-grow-1 mx-3 mx-lg-5">
            <div class="input-group">
                <input type="search" id="filtroNome" class="form-control search-input" placeholder="Buscar camisas..." onkeyup="filtrarUsuarios()">
                <button class="btn btn-outline-light" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>

        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <a href="/minhaConta" class="btn btn-outline-light me-2">
                        <i class="fas fa-user-cog"></i>
                        <span class="d-none d-lg-inline ms-1">Minha Conta</span>
                    </a>
                    <a href="/logout" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="d-none d-lg-inline ms-1">Logout</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="/login" class="btn btn-outline-light me-2">
                        <i class="fas fa-user"></i>
                        <span class="d-none d-lg-inline ms-1">Conta</span>
                    </a>
                </c:otherwise>
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

<br>
<div class="container">
    <div class="product-detail-container">
        <div class="row">
            <!-- Coluna das Imagens -->
            <div class="col-md-6 d-flex flex-column flex-md-row">
                <!-- Miniaturas -->
                <div class="thumbnail-column">
                    <c:if test="${not empty produtos.imagens}">
                        <c:forEach var="imagem" items="${produtos.imagens}">
                            <img src="${imagem.caminhoArquivo}" class="${imagem.imagemPadrao ? 'active' : ''}" onclick="changeImage(this)">
                        </c:forEach>
                    </c:if>
                </div>

                <!-- Imagem principal -->
                <div class="ms-md-3 mt-3 mt-md-0">
                    <c:set var="imagemPrincipal" value="img/padrao.jpg"/>
                    <c:if test="${not empty produtos.imagens}">
                        <c:forEach var="imagem" items="${produtos.imagens}">
                            <c:if test="${imagem.imagemPadrao}">
                                <c:set var="imagemPrincipal" value="${imagem.caminhoArquivo}"/>
                            </c:if>
                        </c:forEach>

                        <c:if test="${imagemPrincipal == 'img/padrao.jpg' && not empty produtos.imagens}">
                            <c:set var="imagemPrincipal" value="${produtos.imagens[0].caminhoArquivo}"/>
                        </c:if>
                    </c:if>

                    <img id="mainImage" src="${imagemPrincipal}" alt="Imagem do Produto">
                </div>
            </div>

            <!-- Coluna das Informações do Produto -->
            <div class="col-md-6 mt-4 mt-md-0">
                <h1 class="product-title">${produtos.nomeProduto}</h1>
                <p class="product-description">${produtos.descricao}</p>

                <div class="price-container">
                    <span class="current-price">R$ ${produtos.preco}</span><br>
                </div>

                <!-- Seletor de Tamanhos -->
                <div class="size-selector">
                    <label>Tamanho</label>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary size-btn">P</button>
                        <button type="button" class="btn btn-outline-secondary size-btn">M</button>
                        <button type="button" class="btn btn-outline-secondary size-btn active">G</button>
                        <button type="button" class="btn btn-outline-secondary size-btn">GG</button>
                        <button type="button" class="btn btn-outline-secondary size-btn">EG</button>
                    </div>
                </div>

                <!-- Botões -->
                <div class="action-buttons d-flex flex-column gap-3">
                    <!-- Botão COMPRAR -->
                    <form action="/carrinho" method="get">
                        <input type="hidden" name="id" value="${produtos.id}">
                        <button type="submit" class="btn btn-buy">
                            <i class="fas fa-credit-card me-2"></i> COMPRAR AGORA
                        </button>
                    </form>

                    <!-- Botão Adicionar ao Carrinho -->
                    <a href="/carrinho" class="btn btn-add-to-cart">
                        <i class="fas fa-cart-plus me-2"></i> ADICIONAR AO CARRINHO
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function changeImage(element) {
        document.getElementById("mainImage").src = element.src;
        let thumbnails = document.querySelectorAll(".thumbnail-column img");
        thumbnails.forEach(img => img.classList.remove("active"));
        element.classList.add("active");
    }

    // Se precisar manter a função de filtro
    function filtrarUsuarios() {
        // Sua lógica de filtro original aqui
    }
</script>
</body>
</html>
