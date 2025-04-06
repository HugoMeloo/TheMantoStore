<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #D10024; /* Vermelho vibrante */
            --secondary-color: #15161D; /* Preto azulado */
            --bg-light: #F6F6F6; /* Fundo claro */
            --text-dark: #2B2D42; /* Texto escuro */
            --text-light: #E5E5E5; /* Texto claro */
            --success-color: #00A651; /* Verde */
            --danger-color: #E53935; /* Vermelho para ações importantes */
            --warning-color: #FFB300; /* Amarelo */
            --info-color: #1E88E5; /* Azul */
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            font-weight: 400;
            background-color: var(--bg-light);
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

        .cart-icon {
            position: relative;
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

        /* Títulos */
        .page-title {
            font-weight: 800;
            color: var(--secondary-color);
            margin-bottom: 2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            padding-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 3px;
            background: var(--primary-color);
        }

        /* Carrinho vazio */
        .empty-cart {
            background-color: white;
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin: 30px 0;
        }

        .empty-cart-icon {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        /* Cards de produto */
        .product-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary-color);
            display: flex;
            align-items: center;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 10px;
            margin-right: 20px;
            background: #f9f9f9;
            padding: 10px;
        }

        .product-info {
            flex-grow: 1;
        }

        .product-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 5px;
            color: var(--secondary-color);
        }

        .product-price {
            font-weight: 800;
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .product-meta {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }

        .product-quantity {
            background: #f5f5f5;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-available {
            color: var(--success-color);
            font-weight: 600;
        }

        .status-unavailable {
            color: var(--danger-color);
            font-weight: 600;
        }

        .quantity-control {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .quantity-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            font-weight: bold;
            transition: all 0.2s ease;
        }

        .add-btn {
            background-color: var(--success-color);
            color: white;
        }

        .add-btn:hover {
            background-color: #008a45;
        }

        .remove-btn {
            background-color: var(--danger-color);
            color: white;
        }

        .remove-btn:hover {
            background-color: #c62828;
        }

        /* Seção de frete */
        .shipping-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 20px;
        }

        .shipping-title {
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cep-input-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .cep-input {
            flex-grow: 1;
            min-width: 200px;
            border-radius: 8px;
            padding: 10px 15px;
            border: 2px solid #eee;
            transition: all 0.3s;
        }

        .cep-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(209,0,36,0.1);
        }

        .btn-calculate {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-calculate:hover {
            background-color: #b3001b;
            transform: translateY(-2px);
        }

        .shipping-options {
            margin-top: 20px;
        }

        .shipping-option {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.3s;
        }

        .shipping-option:hover {
            background: #f0f0f0;
        }

        .shipping-option input {
            margin-right: 10px;
        }

        .shipping-option label {
            display: flex;
            justify-content: space-between;
            width: 100%;
            cursor: pointer;
        }

        /* Resumo do pedido */
        .summary-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 25px;
            position: sticky;
            top: 20px;
        }

        .summary-title {
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }

        .summary-total {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--secondary-color);
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
        }

        .btn-checkout {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 15px;
            font-weight: 700;
            font-size: 1.1rem;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(209,0,36,0.2);
        }

        .btn-checkout:hover {
            background-color: #b3001b;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(209,0,36,0.3);
        }

        /* Responsividade */
        @media (max-width: 768px) {
            .product-card {
                flex-direction: column;
                text-align: center;
            }

            .product-image {
                margin-right: 0;
                margin-bottom: 15px;
            }

            .product-meta {
                justify-content: center;
            }

            .quantity-control {
                justify-content: center;
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

<div class="container mb-5">
    <h1 class="page-title">
        <i class="fas fa-shopping-cart"></i> Seu Carrinho
    </h1>

    <c:if test="${empty sessionScope.carrinho}">
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-basket"></i>
            </div>
            <h3 class="mb-3">Seu carrinho está vazio</h3>
            <p class="text-muted mb-4">Adicione produtos para continuar</p>
            <a href="/" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i> Voltar às compras
            </a>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.carrinho}">
        <div class="row">
            <div class="col-lg-8">
                <c:forEach var="item" items="${sessionScope.carrinho}">
                    <div class="product-card">
                        <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem do Produto" class="product-image">
                        <div class="product-info">
                            <h3 class="product-title">${item.produto.nomeProduto}</h3>
                            <p class="product-price">R$ ${item.produto.preco}</p>

                            <div class="product-meta">
                                <span class="product-quantity">
                                    <i class="fas fa-box-open"></i> ${item.quantidade} un.
                                </span>
                                <span class="status-${item.produto.status ? 'available' : 'unavailable'}">
                                    <i class="fas fa-${item.produto.status ? 'check-circle' : 'times-circle'}"></i>
                                    ${item.produto.status ? 'Disponível' : 'Indisponível'}
                                </span>
                            </div>

                            <div class="quantity-control">
                                <a href="/carrinho?id=${item.produto.id}&acao=remover" class="quantity-btn remove-btn">
                                    <i class="fas fa-minus"></i>
                                </a>
                                <a href="/carrinho?id=${item.produto.id}&acao=adicionar" class="quantity-btn add-btn">
                                    <i class="fas fa-plus"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="shipping-card">
                    <h3 class="shipping-title">
                        <i class="fas fa-truck"></i> Calcular Frete
                    </h3>
                    <div class="cep-input-group">
                        <input type="text" id="cep" class="form-control cep-input" placeholder="Digite seu CEP">
                        <button class="btn btn-calculate" onclick="calcularFrete()">
                            <i class="fas fa-calculator me-2"></i> Calcular
                        </button>
                    </div>
                    <div id="frete-opcoes" class="shipping-options" style="display:none;">
                        <p class="mb-3">Escolha o tipo de entrega:</p>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-rapido" value="25" onclick="selecionarFrete(25)">
                            <label for="frete-rapido">
                                <span>Entrega Rápida <small>(2-3 dias úteis)</small></span>
                                <span>R$ 25,00</span>
                            </label>
                        </div>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-sedex" value="20" onclick="selecionarFrete(20)">
                            <label for="frete-sedex">
                                <span>SEDEX <small>(3-5 dias úteis)</small></span>
                                <span>R$ 20,00</span>
                            </label>
                        </div>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-agendada" value="15" onclick="selecionarFrete(15)">
                            <label for="frete-agendada">
                                <span>Entrega Agendada <small>(5-7 dias úteis)</small></span>
                                <span>R$ 15,00</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="summary-card">
                    <h3 class="summary-title">
                        <i class="fas fa-receipt"></i> Resumo do Pedido
                    </h3>

                    <div class="summary-item">
                        <span>Subtotal</span>
                        <span>${totalCarrinho}</span>
                    </div>

                    <div class="summary-item">
                        <span>Frete</span>
                        <span id="frete-valor">-</span>
                    </div>

                    <div class="summary-total">
                        <span>Total</span>
                        <span id="total-com-frete">${totalCarrinho}</span>
                    </div>

                    <form action="carrinho" method="POST">
                        <button type="submit" class="btn btn-checkout">
                            <i class="fas fa-credit-card me-2"></i> Finalizar Compra
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function calcularFrete() {
        let cep = document.getElementById("cep").value.trim();
        let opcoesFrete = document.getElementById("frete-opcoes");

        if (cep.length === 8 && !isNaN(cep)) {
            opcoesFrete.style.display = "block";
        } else {
            alert("Por favor, digite um CEP válido com 8 números.");
        }
    }
    function selecionarFrete(valorFrete) {
        // Atualiza o valor do frete no resumo
        document.getElementById("frete-valor").innerText = "R$ " + valorFrete.toFixed(2);

        // Obtém o subtotal do carrinho
        let subtotalText = document.getElementById("total-com-frete").innerText;
        let subtotal = parseFloat(subtotalText.replace("R$", "").replace(",", ".").trim());

        // Calcula o total com frete
        let totalComFrete = subtotal + valorFrete;

        // Atualiza o total no resumo do pedido
        document.getElementById("total-com-frete").innerText = "R$ " + totalComFrete.toFixed(2);
    }

</script>
</body>
</html>