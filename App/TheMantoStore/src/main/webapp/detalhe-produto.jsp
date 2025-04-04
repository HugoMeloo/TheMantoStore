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
    <style>
        :root {
            --primary-color: #D10024; /* Vermelho vibrante */
            --secondary-color: #15161D; /* Preto azulado */
            --bg-light: #F6F6F6; /* Fundo claro */
            --text-dark: #2B2D42; /* Texto escuro */
            --text-light: #E5E5E5; /* Texto claro */
            --success-color: #00A651; /* Verde */
            --discount-color: #FF3E3E; /* Vermelho para promoções */
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            color: var(--text-dark);
        }

        /* Navbar consistente */
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

        /* Container principal */
        .product-detail-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 30px;
            margin-top: 30px;
        }

        /* Galeria de imagens */
        .thumbnail-column {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-right: 20px;
        }

        .thumbnail-column img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .thumbnail-column img:hover {
            transform: scale(1.05);
        }

        .thumbnail-column img.active {
            border: 2px solid var(--primary-color);
            transform: scale(1.05);
        }

        #mainImage {
            width: 100%;
            max-height: 500px;
            object-fit: contain;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        /* Informações do produto */
        .product-title {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: var(--secondary-color);
        }

        .product-description {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            color: #555;
        }

        .price-container {
            margin-bottom: 1.5rem;
        }

        .current-price {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary-color);
        }

        /* Seletor de tamanhos */
        .size-selector {
            margin-bottom: 2rem;
        }

        .size-selector label {
            display: block;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .size-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .size-btn:hover, .size-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        /* Botões de ação */
        .action-buttons {
            margin-top: 2rem;
        }

        .btn-buy {
            background-color: var(--primary-color);
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            padding: 12px 30px;
            border-radius: 50px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 5px 15px rgba(209,0,36,0.3);
        }

        .btn-buy:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(209,0,36,0.4);
            background-color: #b3001b;
        }

        .btn-add-to-cart {
            background-color: transparent;
            color: var(--secondary-color);
            font-weight: 600;
            border: 2px solid var(--secondary-color);
            padding: 10px 25px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-add-to-cart:hover {
            background-color: var(--secondary-color);
            color: white;
        }

        /* Responsividade */
        @media (max-width: 768px) {
            .thumbnail-column {
                flex-direction: row;
                margin-right: 0;
                margin-bottom: 15px;
            }

            .product-title {
                font-size: 1.8rem;
            }

            #mainImage {
                max-height: 350px;
            }
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="lista-produto.jsp">
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
