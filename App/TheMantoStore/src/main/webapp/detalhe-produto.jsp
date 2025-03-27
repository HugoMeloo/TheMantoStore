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
        <!-- Seleção da Imagem Principal -->
        <div class="col-md-6 text-center">
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

            <img id="mainImage" src="${imagemPrincipal}" class="img-fluid" alt="Imagem do Produto">
        </div>

        <!-- Informações do Produto -->
        <div class="col-md-6">
            <h2>${produtos.nomeProduto}</h2>
            <p>${produtos.descricao}</p>
            <h4 class="text-success">${produtos.preco} no Pix</h4>
            <p class="text-muted">${produtos.preco} em até 8x de ${produtos.preco}</p>
            <button class="btn btn-secondary" disabled>Comprar</button>

            <form action="carrinho.jsp" method="post">
                <input type="hidden" name="nome" value="${produtos.nomeProduto}">
                <input type="hidden" name="preco" value="${produtos.preco}">
                <input type="hidden" name="descricao" value="${produtos.descricao}">
                <input type="hidden" name="imagem" value="${imagemPrincipal}">
                <button type="submit" class="btn btn-primary">Adicionar ao Carrinho</button>
            </form>
        </div>

        <!-- Miniaturas -->
        <div class="col-md-12 text-center mt-3">
            <div class="d-flex justify-content-center thumbnail">
                <c:if test="${not empty produtos.imagens}">
                    <c:forEach var="imagem" items="${produtos.imagens}">
                        <img src="${imagem.caminhoArquivo}" class="me-2 ${imagem.imagemPadrao ? 'active' : ''}" onclick="changeImage(this)">
                    </c:forEach>
                </c:if>
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

</body>
</html>
