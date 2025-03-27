<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
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
            border-radius: 10px;
            width: 90px;
            height: 90px;
            object-fit: cover;
        }

        .product-info h5 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .product-info p {
            color: #777;
            margin: 5px 0 0;
        }

        .remove-btn {
            background-color: #ffe6e6;
            color: #d9534f;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .remove-btn:hover {
            background-color: #ffcccc;
        }

        .summary-card {
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }

        .summary-card h5 {
            font-weight: 600;
            margin-bottom: 20px;
            color: #222;
        }

        .summary-card p {
            margin: 10px 0;
            color: #555;
        }

        .btn-finalize {
            background: linear-gradient(to right, #00c853, #64dd17);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 30px;
            width: 100%;
            font-weight: 600;
            font-size: 1.1rem;
            transition: 0.3s;
        }

        .btn-finalize:hover {
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
        <a class="navbar-brand" href="lista-produto.jsp">The Manto Store</a>
        <form class="d-flex w-50">
            <div class="input-group">
                <input type="text" id="filtroNome" class="form-control rounded-pill ps-2" placeholder="O que você procura?" onkeyup="filtrarUsuarios()" style="height: 45px;">
            </div>
        </form>
        <div class="d-flex align-items-center">
            <a href="/login" class="me-3">
                <img src="img/user.png" alt="Usuário" style="width: 30px; height: 30px;">
            </a>
            <a href="/carrinho" class="me-3">
                <img src="img/carrinho.png" alt="Carrinho" style="width: 30px; height: 30px;">
            </a>
        </div>
    </div>
</nav>

<!-- Exibindo os dados passados na URL -->


<p>Nome: ${param.nome}</p>
<p>Imagem: <img src="${param.imagem}" alt="Imagem do Produto" style="width: 50px; height: 50px;"></p>
<p>Nome: ${param.nome}</p>
<p>Descrição: ${param.descricao}</p>
<p>Preço: R$ ${param.preco}</p>
<p>Quantidade em Estoque: ${param.qtdEstoque}</p>
<p>Status: ${param.status}</p>

<div class="summary-card mt-4">
    <h5>Resumo do Carrinho</h5>
    <p>Total: R$ ${totalCarrinho}</p>
    <p>Escolha o método de frete:</p>
    <div class="frete-box">
        <label><input type="radio" name="frete" value="normal"> Frete Normal</label>
        <label><input type="radio" name="frete" value="expresso"> Frete Expresso</label>
    </div>
    <button class="btn-finalize mt-3">Finalizar Compra</button>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
