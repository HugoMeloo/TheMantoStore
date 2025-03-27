<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <title>The Manto Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/body.css">
</head>
<style>
    /* Estilo para o card do filme */
    .movie-card {
        border: none;
        position: relative;
        overflow: hidden;
        border-radius: 20px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        background-color: #121212;
    }

    .movie-card:hover {
        transform: scale(1.03);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
    }

    /* Imagem com efeito dinâmico */
    .image-container img {
        border-radius: 20px;
        transition: transform 0.4s ease-in-out, filter 0.4s ease-in-out;
    }

    .movie-card:hover img {
        transform: scale(1.1);
        filter: brightness(80%);
    }

    /* Camada de sobreposição escura */
    .overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        padding: 20px;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.85), transparent);
        text-align: center;
    }

    /* Título do filme */
    .overlay h4 {
        font-size: 1.8rem;
        color: #fff;
        font-weight: bold;
        text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.7);
        margin-bottom: 15px;
    }

    /* Botão elegante */
    .btn-action {
        display: inline-block;
        background-color: #e50914;
        color: white;
        font-weight: bold;
        padding: 12px 20px;
        border: none;
        border-radius: 10px;
        font-size: 1rem;
        text-transform: uppercase;
        transition: background-color 0.3s ease, transform 0.3s ease;
        box-shadow: 0 4px 12px rgba(229, 9, 20, 0.4);
    }

    .btn-action:hover {
        background-color: #ff0a16;
        transform: translateY(-5px);
        box-shadow: 0 6px 20px rgba(255, 10, 22, 0.6);
    }

    /* Texto com sombra */
    .text-shadow {
        text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.7);
    }
</style>

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



<!-- Carousel do antigo projeto para futura referencia
<div class="container mt-5">
    <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <c:forEach var="movie" items="${movies}" varStatus="status">
                <c:if test="${movie.emcart == 'emDestaq'}">

                    <div class="carousel-item ${status.first ? 'active' : ''}">

                        <a href="/find-session?id=${movie.idMovie}&nomeFilme=${movie.nomeFilme}&genero=${movie.genero}
                            &sinopse=${movie.sinopse}&classInd=${movie.classInd}&duracao=${movie.duracao}&image=${movie.image}">
                            <img src="${movie.image}" class="d-block w-100 rounded-image custom-carousel-image"
                                 alt="Imagem de ${movie.nomeFilme}">
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </div>



        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleSlidesOnly" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleSlidesOnly" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

-->

<div class="container mt-4">
    <h2 class="text-center">Produtos</h2>
    <div class="row">
        <c:forEach var="produto" items="${produtos}">
            <div class="col-md-4 mb-4">
                <a href="/detalha-produto?id=${produto.id}" class="text-decoration-none text-dark">
                    <div class="movie-card h-100">
                        <div class="image-container">
                            <img src="${produto.imagens[0].caminhoArquivo}" alt="Poster" class="w-100 h-100" style="height: 350px; object-fit: cover;">
                            <div class="overlay">
                                <h4 class="text-white text-shadow">${produto.nomeProduto}</h4>
                            </div>
                        </div>
                        <div class="card-body text-center">
                            <p class="fw-bold">${produto.preco}</p>
                            <p class="card-text">${produto.descricao}</p>
                            <a href="/detalha-produto" class="btn btn-action w-100">Ver mais</a>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>





<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>