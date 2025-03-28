<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
             body {
                 font-family: 'Poppins', sans-serif;
                 background-color: #f5f7fa;
             }

             h2 {
                 font-weight: 600;
                 margin-bottom: 30px;
                 color: #222;
             }

             .product-card {
                 border-radius: 10px;
                 box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                 margin-bottom: 15px;
                 padding: 15px;
                 transition: transform 0.3s ease;
                 border-radius: 15px;
                 background: #fff;
                 box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
                 padding: 20px;
                 margin-bottom: 20px;
                 transition: 0.3s;
             }

             .product-card:hover {
                 transform: translateY(-5px);
             }

             .product-card img {
                 border-radius: 8px;
                 width: 80px;
                 height: 80px;
                 border-radius: 10px;
                 width: 90px;
                 height: 90px;
                 object-fit: cover;
             }

             .product-info {
                 margin-left: 15px;
             }

             .product-info h5 {
                 font-size: 1.1rem;
                 font-size: 1.2rem;
                 font-weight: 600;
                 color: #333;
                 margin: 0;
             }

             .product-info p {
                 font-size: 0.9rem;
                 color: #555;
                 color: #777;
                 margin: 5px 0 0;
             }

             .remove-btn {
                 background-color: #f8d7da;
                 background-color: #ffe6e6;
                 color: #d9534f;
                 border: none;
                 color: #721c24;
                 padding: 5px 10px;
                 border-radius: 5px;
                 font-size: 0.9rem;
                 cursor: pointer;
                 padding: 8px 15px;
                 border-radius: 8px;
                 transition: 0.3s;
             }

             .remove-btn:hover {
                 background-color: #f5c6cb;
                 background-color: #ffcccc;
             }

             .summary-card {
                 border-radius: 10px;
                 box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                 padding: 25px;
                 margin-top: 30px;
                 background: #fff;
                 border-radius: 15px;
                 padding: 30px;
                 box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
             }

             .summary-card h5 {
                 font-size: 1.25rem;
                 color: #333;
                 font-weight: 600;
                 margin-bottom: 20px;
                 color: #222;
             }

             .summary-card p {
                 font-size: 1rem;
                 margin: 10px 0;
                 color: #555;
             }

             .btn-finalize {
                 background-color: #28a745;
                 background: linear-gradient(to right, #00c853, #64dd17);
                 color: white;
                 padding: 12px 20px;
                 border-radius: 50px;
                 padding: 14px;
                 border: none;
                 border-radius: 30px;
                 width: 100%;
                 font-weight: 600;
                 font-size: 1.1rem;
                 transition: background-color 0.3s ease;
                 transition: 0.3s;
             }

             .btn-finalize:hover {
                 background-color: #218838;
                 background: linear-gradient(to right, #00b347, #52c41a);
             }

             .frete-box input[type="radio"] {
                 margin-right: 8px;
             }
         </style>
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
    <h2 class="mb-4">🛒 Seu Carrinho</h2>

    <c:if test="${empty sessionScope.carrinho}">
        <div class="alert alert-info">O carrinho está vazio.</div>
    </c:if>

    <c:forEach var="item" items="${sessionScope.carrinho}">
        <div class="product-card d-flex align-items-start mb-4">
            <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem do Produto" style="width: 100px; height: auto;">
            <div class="product-info ms-4">
                <h5>${item.produto.nomeProduto}</h5>
                <p>Preço: R$ ${item.produto.preco}</p>
                <p>Quantidade: ${item.quantidade}</p>
                <p>Status:
                    <c:choose>
                        <c:when test="${item.produto.status}">
                            <span class="text-success fw-bold">Disponível</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger fw-bold">Indisponível</span>
                        </c:otherwise>
                    </c:choose>
                </p>
                <div class="d-flex gap-2 mt-2">
                    <a href="/carrinho?id=${item.produto.id}&acao=adicionar" class="btn btn-success">Adicionar 1</a>
                    <a href="/carrinho?id=${item.produto.id}&acao=remover" class="btn btn-danger">Remover 1</a>
                </div>
            </div>
        </div>
        <div class="summary-card mt-4">
            <h5>📦 Calcular Frete</h5>
            <div class="d-flex flex-column flex-md-row align-items-start gap-3 mb-3">
                <input type="text" id="cep" class="form-control" placeholder="Digite seu CEP" style="max-width: 300px;">
                <button class="btn btn-outline-success mt-2 mt-md-0" onclick="calcularFrete()">Calcular Frete</button>
            </div>
            <div id="frete-opcoes" class="frete-box" style="display:none;">
                <p class="mb-2">Escolha o tipo de entrega:</p>
                <div>
                    <label><input type="radio" name="frete" value="25" onclick="selecionarFrete(25)"> Entrega Rápida - R$ 25,00</label><br>
                    <label><input type="radio" name="frete" value="20" onclick="selecionarFrete(20)"> SEDEX - R$ 20,00</label><br>
                    <label><input type="radio" name="frete" value="15" onclick="selecionarFrete(15)"> Entrega Agendada - R$ 15,00</label>
                </div>
            </div>
        </div>
    </c:forEach>



    <div class="summary-card mt-5">
        <h5>Resumo do Carrinho</h5>
        <p class="fs-5">Total: <strong>R$ ${totalCarrinho}</strong></p>

        <form action="carrinho" method="POST">
            <button type="submit" class="btn btn-primary mt-3">Finalizar Compra</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>