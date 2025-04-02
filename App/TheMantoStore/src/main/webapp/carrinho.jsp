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
            --primary-color: #28a745;
            --secondary-color: #218838;
            --dark-color: #2d3436;
            --light-color: #f5f6fa;
            --success-color: #00b894;
            --danger-color: #d63031;
            --warning-color: #fdcb6e;
            --info-color: #0984e3;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .navbar {
            background: #212529 !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 0.5px;
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
            background-color: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .page-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .empty-cart {
            background-color: white;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .empty-cart-icon {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 15px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-left: 4px solid var(--primary-color);
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #eee;
        }

        .product-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 5px;
        }

        .product-price {
            font-weight: 500;
            color: var(--primary-color);
        }

        .product-quantity {
            background-color: var(--light-color);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-available {
            color: var(--success-color);
            font-weight: 500;
        }

        .status-unavailable {
            color: var(--danger-color);
            font-weight: 500;
        }

        .quantity-control {
            display: flex;
            align-items: center;
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
            background-color: #00a383;
        }

        .remove-btn {
            background-color: var(--danger-color);
            color: white;
        }

        .remove-btn:hover {
            background-color: #c0392b;
        }

        .summary-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-top: 30px;
        }

        .summary-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }

        .summary-total {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-top: 15px;
        }

        .btn-checkout {
            background: linear-gradient(to right, #00c853, #64dd17);
            border: none;
            border-radius: 30px;
            padding: 12px 0;
            font-weight: 600;
            letter-spacing: 0.5px;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }

        .shipping-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        .shipping-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .shipping-options {
            margin-top: 15px;
        }

        .shipping-option {
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .shipping-option:hover {
            background-color: #f8f9fa;
        }

        .shipping-option input {
            margin-right: 10px;
        }

        .shipping-option label {
            cursor: pointer;
            width: 100%;
            display: flex;
            justify-content: space-between;
        }

        .cep-input {
            max-width: 300px;
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ddd;
        }

        .btn-calculate {
            background-color: var(--info-color);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            transition: all 0.2s ease;
        }

        .btn-calculate:hover {
            background-color: #0877d1;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">The Manto Store</a>
        <div class="d-flex align-items-center">
            <a href="/carrinho" class="cart-icon position-relative me-3">
                <i class="fas fa-shopping-cart fa-lg text-white"></i>
                <c:if test="${not empty sessionScope.carrinho}">
                    <span class="cart-count">${sessionScope.carrinho.size()}</span>
                </c:if>
            </a>
        </div>
    </div>
</nav>

<div class="container mb-5">
    <h2 class="page-title">
        <i class="fas fa-shopping-cart"></i> Seu Carrinho
    </h2>

    <c:if test="${empty sessionScope.carrinho}">
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-basket"></i>
            </div>
            <h4 class="mb-3">Seu carrinho está vazio</h4>
            <p class="text-muted mb-4">Adicione produtos para continuar</p>
            <a href="/" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i> Voltar às compras
            </a>
        </div>
    </c:if>
    <div class="row">
        <div class="col-lg-8">
            <c:forEach var="item" items="${sessionScope.carrinho}">
                <div class="product-card d-flex">
                    <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem do Produto" class="product-image me-4">
                    <div class="flex-grow-1">
                        <h5 class="product-title">${item.produto.nomeProduto}</h5>
                        <p class="product-price mb-2">R$ ${item.produto.preco}</p>

                        <div class="d-flex align-items-center gap-4 mb-2">
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
            <br>
            <div class="shipping-card">
                <h5 class="shipping-title">
                    <i class="fas fa-truck"></i> Calcular Frete
                </h5>
                <div class="d-flex flex-column flex-md-row align-items-start gap-3 mb-3">
                    <input type="text" id="cep" class="form-control cep-input" placeholder="Digite seu CEP">
                    <button class="btn btn-calculate" onclick="calcularFrete()">
                        <i class="fas fa-calculator me-2"></i>Calcular
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
                <h5 class="summary-title">
                    <i class="fas fa-receipt"></i> Resumo do Pedido
                </h5>

                <div class="summary-item">
                    <span>Subtotal</span>
                    <span>R$ ${totalCarrinho}</span>
                </div>

                <div class="summary-item">
                    <span>Frete</span>
                    <span id="frete-valor">-</span>
                </div>

                <div class="summary-item">
                    <span>Descontos</span>
                    <span>R$ 0,00</span>
                </div>

                <div class="summary-total d-flex justify-content-between">
                    <span>Total</span>
                    <span id="total-com-frete">R$ ${totalCarrinho}</span>
                </div>

                <form action="carrinho" method="POST">
                    <button type="submit" class="btn btn-checkout">
                        <i class="fas fa-credit-card me-2"></i> Finalizar Compra
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function calcularFrete() {
        const cep = document.getElementById('cep').value;
        if (cep.length === 8) {
            document.getElementById('frete-opcoes').style.display = 'block';
        } else {
            alert('Por favor, digite um CEP válido com 8 dígitos.');
        }
    }

    function selecionarFrete(valor) {
        const freteValor = document.getElementById('frete-valor');
        const totalComFrete = document.getElementById('total-com-frete');

        freteValor.textContent = `R$ ${valor.toFixed(2)}`;

        // Calcula o total com frete (substitua pelo seu valor real do carrinho)
        const subtotal = ${totalCarrinho};
        const total = subtotal + valor;
        totalComFrete.textContent = `R$ ${total.toFixed(2)}`;
    }
</script>
</body>
</html>