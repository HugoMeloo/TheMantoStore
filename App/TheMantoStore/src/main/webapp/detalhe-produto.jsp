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
    <style>
        .thumbnail-column {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-right: 15px;
        }

        .thumbnail-column img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .thumbnail-column img.active {
            border: 2px solid red;
        }

        #mainImage {
            width: 400px;
            height: 400px;
            object-fit: contain;
            border: 1px solid #ddd;
        }
        h2 {
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .btn-outline-secondary {
            min-width: 50px;
            font-weight: bold;
        }

        .btn-outline-dark {
            border-width: 2px;
        }

        .fs-3 {
            font-size: 2rem;
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
<br>
<div class="container mt-4">
    <div class="row">
        <!-- Coluna das Imagens -->
        <div class="col-md-6 d-flex">
            <!-- Miniaturas à esquerda -->
            <div class="thumbnail-column">
                <c:if test="${not empty produtos.imagens}">
                    <c:forEach var="imagem" items="${produtos.imagens}">
                        <img src="${imagem.caminhoArquivo}" class="${imagem.imagemPadrao ? 'active' : ''}" onclick="changeImage(this)">
                    </c:forEach>
                </c:if>
            </div>

            <!-- Imagem principal -->
            <div class="ms-3">
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

                <img id="mainImage" src="${imagemPrincipal}" alt="Imagem do Produto" style="width: 400px; height: 400px; object-fit: contain; border: 1px solid #ddd;">
            </div>
        </div>

        <!-- Coluna das Informações do Produto -->
        <div class="col-md-6">
            <h2 class="fw-bold">${produtos.nomeProduto}</h2>
            <p class="text-muted">${produtos.descricao}</p>

            <div class="mb-3">
                <span class="text-decoration-line-through text-muted">De R$ 349,90</span><br>
                <span class="fs-3 text-success fw-bold">R$ ${produtos.preco}</span>
            </div>

            <p class="text-muted">ou em até 8x de R$ ${produtos.preco}</p>

            <!-- Seletor de Tamanhos -->
            <div class="mb-3">
                <label class="fw-semibold mb-2">Tamanho</label><br>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-secondary">P</button>
                    <button type="button" class="btn btn-outline-secondary">M</button>
                    <button type="button" class="btn btn-outline-secondary">G</button>
                    <button type="button" class="btn btn-outline-secondary">GG</button>
                    <button type="button" class="btn btn-outline-secondary">EG</button>
                </div>
            </div>

            <!-- Botões -->
            <div class="d-flex flex-column gap-3 mt-4">
                <!-- Botão COMPRAR mais estilizado -->
                <form action="/carrinho" method="get">
                    <input type="hidden" name="id" value="${produtos.id}">

                    <button type="submit" class="btn btn-success btn-lg rounded-pill shadow-sm fw-bold px-5 py-2">
                        COMPRAR
                    </button>
                </form>

                <!-- Botão Adicionar ao Carrinho mais discreto -->
                <a href="/carrinho" class="btn btn-outline-secondary btn-sm rounded-pill px-4">
                    + Adicionar ao Carrinho
                </a>
            </div>

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

<script>
    function changeImage(element) {
        document.getElementById("mainImage").src = element.src;
        let thumbnails = document.querySelectorAll(".thumbnail-column img");
        thumbnails.forEach(img => img.classList.remove("active"));
        element.classList.add("active");
    }
</script>

</body>
</html>
