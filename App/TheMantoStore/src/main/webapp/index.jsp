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

    <style>
        :root {
            --primary-color: #e94560;
            --secondary-color: #16213e;
            --bg-light: #f4f6f9;
            --text-dark: #212529;
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            color: var(--text-dark);
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .product-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .product-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .product-image {
            position: relative;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 350px;
            object-fit: cover;
            transition: transform 0.5s ease, filter 0.5s ease;
        }

        .product-card:hover .product-image img {
            transform: scale(1.1);
            filter: brightness(0.8);
        }

        .product-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            overflow: hidden;
            width: 100%;
            height: 0;
            transition: 0.5s ease;
        }

        .product-card:hover .product-overlay {
            height: 100%;
        }

        .product-overlay-title {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: absolute;
            bottom: 20px;
            left: 20px;
            opacity: 0;
            transition: opacity 0.5s;
        }

        .product-card:hover .product-overlay-title {
            opacity: 1;
        }

        .section-title {
            color: var(--secondary-color);
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        }

        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark mb-4" style="background: #212529 !important; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);">
    <div class="container">
        <a class="navbar-brand" href="lista-produto.jsp" style="font-weight: 700; font-size: 1.5rem; letter-spacing: 0.5px;">The Manto Store</a>

        <form class="d-flex flex-grow-1 mx-3">
            <div class="input-group">
                <input type="search" id="productSearch" class="form-control rounded-pill ps-2" placeholder="O que você procura?" style="height: 45px;">
            </div>
        </form>

        <div class="d-flex align-items-center">
            <a href="/usuarios" class="me-3">
                <img src="img/user.png" alt="Usuário" style="width: 30px; height: 30px;">
            </a>
            <a href="/carrinho" class="cart-icon position-relative me-3">
                <i class="fas fa-shopping-cart fa-lg text-white"></i>
                <c:if test="${not empty sessionScope.carrinho}">
                    <span class="cart-count" style="position: absolute; top: -8px; right: -8px; background-color: #d63031; color: white; border-radius: 50%; width: 20px; height: 20px; font-size: 12px; display: flex; align-items: center; justify-content: center;">
                        ${sessionScope.carrinho.size()}
                    </span>
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
                    <div class="product-image">
                        <img src="${produto.imagens[0].caminhoArquivo}" alt="${produto.nomeProduto}" loading="lazy">
                        <div class="product-overlay">
                            <h4 class="product-overlay-title">${produto.nomeProduto}</h4>
                        </div>
                    </div>
                    <div class="p-3 text-center">
                        <h5 class="fw-bold mb-2 text-dark">${produto.nomeProduto}</h5>
                        <p class="text-muted mb-3">${produto.descricao}</p>
                        <div class="d-flex justify-content-center align-items-center">
                                <span class="h5 text-danger mb-0">
                                    <fmt:formatNumber value="${produto.preco}" type="currency" currencyCode="BRL"/>
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
        const productItems = productGrid.querySelectorAll('.product-item');

        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();

            productItems.forEach(item => {
                const productName = item.dataset.name;
                const isVisible = productName.includes(searchTerm);

                item.style.display = isVisible ? 'block' : 'none';
            });
        });
    });
</script>

<!-- Optional: Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<!-- Optional: Defer Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>
</body>
</html>