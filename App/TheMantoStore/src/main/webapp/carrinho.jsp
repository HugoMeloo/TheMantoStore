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

    <div class="container py-5">
        <h2>🛒 Seu Carrinho</h2>

        <div class="row">
            <div class="col-lg-8">
                <div class="product-card d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/produto1.jpg" alt="Produto 1">
                        <div class="product-info ms-3">
                            <h5>Produto 1</h5>
                            <p>R$ 100,00</p>
                        </div>
                    </div>
                    <button class="remove-btn">Remover</button>
                </div>

                <div class="product-card d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/produto2.jpg" alt="Produto 2">
                        <div class="product-info ms-3">
                            <h5>Produto 2</h5>
                            <p>R$ 50,00</p>
                        </div>
                    </div>
                    <button class="remove-btn">Remover</button>
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
            </div>

            <div class="col-lg-4 mt-4 mt-lg-0">
                <div class="summary-card">
                    <h5>Resumo da Compra</h5>
                    <p>Total de Produtos: <strong>2</strong></p>
                    <p>Frete: <strong id="valor-frete">R$ 0,00</strong></p>
                    <p><strong>Total: <span id="total-compra">R$ 150,00</span></strong></p><br>
                    <a href="/finalizar-compra" class="btn-finalize mt-3">Finalizar Compra</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        let totalProdutos = 150.00;
        let freteSelecionado = 0;

        function calcularFrete() {
            const cep = document.getElementById("cep").value;
            if (cep === "") {
                alert("Por favor, digite seu CEP.");
                return;
            }
            document.getElementById("frete-opcoes").style.display = "block";
        }

        function selecionarFrete(valorFrete) {
            freteSelecionado = parseFloat(valorFrete);
            document.getElementById("valor-frete").textContent = `R$ ${freteSelecionado.toFixed(2)}`;
            let totalFinal = totalProdutos + freteSelecionado;
            document.getElementById("total-compra").textContent = `R$ ${totalFinal.toFixed(2)}`;
        }
    </script>
</body>
</html>