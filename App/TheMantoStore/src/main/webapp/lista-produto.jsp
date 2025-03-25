<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand" href="lista-produto.jsp">The Manto Store</a>
            <form class="d-flex w-50">
                <div class="input-group">
                <input id="liveSearchInput" class="form-control form-control-dark rounded-pill border-0 my-2 search-input" type="text" placeholder="Pesquisar..." aria-label="Search">
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
    <div class="container mt-4">
        <h2 class="text-center">Camisas de Times</h2>
        <div class="row">
            <div class="col-md-4">
                <a href="detalhe-produto.jsp" class="text-decoration-none text-dark">
                    <div class="card h-100">
                        <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                            <span>[Imagem Aqui]</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">[Nome da Camisa]</h5>
                            <p class="card-text">[Descrição da camisa]</p>
                            <p class="fw-bold">[Preço]</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="detalhe-produto.jsp" class="text-decoration-none text-dark">
                    <div class="card h-100">
                        <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                            <span>[Imagem Aqui]</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">[Nome da Camisa]</h5>
                            <p class="card-text">[Descrição da camisa]</p>
                            <p class="fw-bold">[Preço]</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="detalhe-produto.jsp" class="text-decoration-none text-dark">
                    <div class="card h-100">
                        <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                            <span>[Imagem Aqui]</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">[Nome da Camisa]</h5>
                            <p class="card-text">[Descrição da camisa]</p>
                            <p class="fw-bold">[Preço]</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
