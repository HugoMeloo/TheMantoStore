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
            --primary-color: #D10024; /* Vermelho mais vibrante */
            --secondary-color: #15161D; /* Preto azulado */
            --bg-light: #F6F6F6; /* Fundo mais suave */
            --text-dark: #2B2D42; /* Texto mais escuro */
            --text-light: #E5E5E5; /* Para textos claros */
            --success-color: #00A651; /* Verde para disponibilidade */
            --discount-color: #FF3E3E; /* Vermelho para promoções */
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* Navbar melhorada */
        .navbar {
            background: var(--secondary-color) !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.8rem;
            letter-spacing: 0.5px;
            color: white !important;
        }

        .search-input {
            border-radius: 50px;
            padding: 10px 20px;
            border: 2px solid #eee;
            transition: all 0.3s;
        }

        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(209,0,36,0.2);
        }

        /* Grade de produtos aprimorada */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            padding: 0 15px;
        }

        .product-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid #eee;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            border-color: var(--primary-color);
        }

        .product-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--primary-color);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            z-index: 2;
        }

        .product-image {
            height: 300px;
            width: 100%;
            object-fit: contain;
            background: #f9f9f9;
            padding: 20px;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-info {
            padding: 20px;
            border-top: 1px solid #eee;
        }

        .product-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .product-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            font-weight: 800;
            color: var(--primary-color);
            font-size: 1.3rem;
        }

        /* Título da seção */
        .section-title {
            color: var(--secondary-color);
            font-weight: 800;
            text-align: center;
            margin-bottom: 3rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: var(--primary-color);
        }

        /* Ícone do carrinho */
        .cart-icon {
            transition: transform 0.3s ease;
        }

        .cart-icon:hover {
            transform: scale(1.1);
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: var(--primary-color) !important;
            color: white;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Responsividade */
        @media (max-width: 992px) {
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }

            .navbar-brand {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1.5rem;
            }

            .product-image {
                height: 250px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="lista-produto.jsp">
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
            <a href="/usuarios" class="btn btn-outline-light me-2" title="Minha conta">
                <i class="fas fa-user"></i>
                <span class="d-none d-lg-inline ms-1">Conta</span>
            </a>
            <a href="/carrinho" class="btn btn-outline-light position-relative" title="Carrinho">
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