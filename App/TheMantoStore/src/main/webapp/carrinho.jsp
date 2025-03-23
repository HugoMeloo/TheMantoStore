<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .product-card {
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            padding: 15px;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            border-radius: 8px;
            width: 80px;
            height: 80px;
            object-fit: cover;
        }

        .product-info {
            margin-left: 15px;
        }

        .product-info h5 {
            font-size: 1.1rem;
            color: #333;
        }

        .product-info p {
            font-size: 0.9rem;
            color: #555;
        }

        .remove-btn {
            background-color: #f8d7da;
            border: none;
            color: #721c24;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .remove-btn:hover {
            background-color: #f5c6cb;
        }

        .summary-card {
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            margin-top: 30px;
        }

        .summary-card h5 {
            font-size: 1.25rem;
            color: #333;
            margin-bottom: 20px;
        }

        .summary-card p {
            font-size: 1rem;
            color: #555;
        }

        .btn-finalize {
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            border-radius: 50px;
            width: 100%;
            font-size: 1.1rem;
            transition: background-color 0.3s ease;
        }

        .btn-finalize:hover {
            background-color: #218838;
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
                <a href="/usuarios" class="me-3">
                    <img src="img/user.png" alt="Usuário" style="width: 30px; height: 30px;">
                </a>
                <a href="/carrinho" class="me-3">
                    <img src="img/carrinho.png" alt="Carrinho" style="width: 30px; height: 30px;">
                </a>
                <a href="/logout" class="btn btn-danger">Sair</a>
            </div>
        </div>
    </nav>

    <!-- Carrinho -->
    <div class="container mt-5">
        <h2>Seu Carrinho</h2>

        <!-- Lista de Produtos no Carrinho -->
        <div class="row">
            <div class="col-12">
                <div class="product-card d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/produto1.jpg" alt="Produto 1">
                        <div class="product-info">
                            <h5>Produto 1</h5>
                            <p>R$ 100,00</p>
                        </div>
                    </div>
                    <button class="remove-btn">Remover</button>
                </div>

                <div class="product-card d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/produto2.jpg" alt="Produto 2">
                        <div class="product-info">
                            <h5>Produto 2</h5>
                            <p>R$ 50,00</p>
                        </div>
                    </div>
                    <button class="remove-btn">Remover</button>
                </div>
            </div>
        </div>

        <!-- Resumo da Compra -->
        <div class="row">
            <div class="col-12">
                <div class="summary-card">
                    <h5>Resumo da Compra</h5>
                    <p>Total de Produtos: <strong>2</strong></p>
                    <p><strong>Total: R$ 150,00</strong></p>
                    <a href="/finalizar-compra" class="btn-finalize">Finalizar Compra</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
