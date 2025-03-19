<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Produto</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .thumbnail img {
            width: 80px;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .thumbnail img.active {
            border: 2px solid red;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
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
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <!-- Carrossel estilo Americanas -->
                <div class="text-center">
                    <img id="mainImage" src="img1.jpg" class="img-fluid" alt="Produto 1">
                </div>
                <div class="d-flex justify-content-center mt-2 thumbnail">
                    <img src="img1.jpg" class="me-2 active" onclick="changeImage(this)">
                    <img src="img2.jpg" class="me-2" onclick="changeImage(this)">
                    <img src="img3.jpg" class="me-2" onclick="changeImage(this)">
                </div>
            </div>
            <div class="col-md-6">
                <h2>Nome do Produto</h2>
                <p>Descrição do produto...</p>
                <h4 class="text-success">R$ 1.538,81 no Pix</h4>
                <p class="text-muted">R$ 1.729,00 em até 8x de R$ 216,12</p>
                <button class="btn btn-secondary" disabled>Comprar</button>
                <a href="carrinho.jsp">Adicionar ao Carrinho</a>
            </div>
        </div>
    </div>

    <script>
        function changeImage(element) {
            document.getElementById("mainImage").src = element.src;
            let thumbnails = document.querySelectorAll(".thumbnail img");
            thumbnails.forEach(img => img.classList.remove("active"));
            element.classList.add("active");
        }
    </script>
</body>
</html>