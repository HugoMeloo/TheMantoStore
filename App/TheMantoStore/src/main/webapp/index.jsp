<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Manto Store - Coleção Exclusiva</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Optimized CSS Loading -->
    <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"></noscript>

    <link rel="stylesheet" href="css/body.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/TheMantoStore">
            <i class="fas fa-tshirt me-2"></i>The Manto Store
        </a>

        <form class="d-flex flex-grow-1 mx-3 mx-lg-5">
            <div class="input-group">
                <input type="search" id="productSearch" class="form-control search-input" placeholder="Buscar camisas...">
                <button class="btn btn-outline-light" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>

        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <a href="/configuracoes-usuario.jsp" class="btn btn-outline-light me-2">
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

<main class="container mt-5">
    <h2 class="section-title">Nossa Coleção</h2>

    <div id="productGrid" class="product-grid">
        <c:forEach var="produto" items="${produtos}">
            <div class="product-card h-100 product-item" data-name="${produto.nomeProduto.toLowerCase()}">
                <a href="/detalha-produto?id=${produto.id}" class="text-decoration-none">
                    <div class="product-image-container">
                        <img src="${produto.imagens[0].caminhoArquivo}" alt="${produto.nomeProduto}" class="product-image" loading="lazy">
                    </div>
                    <div class="product-info">
                        <h5 class="product-title">${produto.nomeProduto}</h5>
                        <p class="product-description">${produto.descricao}</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="product-price">
                                <fmt:formatNumber value="${produto.preco}" type="currency" currencyCode="BRL"/>
                            </span>
                            <span class="text-success small">
                                <i class="fas fa-check-circle"></i> Disponível
                            </span>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('productSearch');
        const productGrid = document.getElementById('productGrid');
        const productItems = document.querySelectorAll('.product-item');

        // Função de busca
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();

            productItems.forEach(item => {
                const productName = item.getAttribute('data-name');
                if (productName.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });

        // Animação ao rolar (opcional, mantém o efeito visual)
        const animateProducts = () => {
            const products = document.querySelectorAll('.product-card');
            const windowHeight = window.innerHeight;

            products.forEach((product) => {
                const productPosition = product.getBoundingClientRect().top;
                const animationPoint = windowHeight - 100;

                if(productPosition < animationPoint) {
                    product.style.opacity = '1';
                    product.style.transform = 'translateY(0)';
                }
            });
        };

        // Inicializa animação
        const products = document.querySelectorAll('.product-card');
        products.forEach(product => {
            product.style.opacity = '0';
            product.style.transform = 'translateY(20px)';
            product.style.transition = 'all 0.5s ease';
        });

        window.addEventListener('scroll', animateProducts);
        animateProducts();
    });
</script>

<!-- Optional: Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<!-- Optional: Defer Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>
</body>
</html>