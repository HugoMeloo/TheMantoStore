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
    /* Global Styling */
    body {
        background-color: #f4f6f9;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    }

    /* Product Card Refinements */
    .movie-card {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        overflow: hidden;
    }

    .movie-card:hover {
        transform: translateY(-15px);
        box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    }

    .image-container {
        position: relative;
        overflow: hidden;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }

    .image-container img {
        transition: transform 0.5s ease;
        width: 100%;
        height: 350px;
        object-fit: cover;
    }

    .movie-card:hover .image-container img {
        transform: scale(1.1);
        filter: brightness(0.8);
    }

    /* Overlay Styling */
    .overlay {
        background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        overflow: hidden;
        width: 100%;
        height: 0;
        transition: 0.5s ease;
    }

    .movie-card:hover .overlay {
        height: 100%;
    }

    .overlay h4 {
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        position: absolute;
        bottom: 20px;
        left: 20px;
        margin: 0;
        opacity: 0;
        transition: opacity 0.5s;
    }

    .movie-card:hover .overlay h4 {
        opacity: 1;
    }

    /* Button Styling */
    .btn-action {
        background: linear-gradient(45deg, #e94560, #ff6b6b);
        border: none;
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
    }

    .btn-action:hover {
        background: linear-gradient(45deg, #ff6b6b, #e94560);
        transform: translateY(-3px);
        box-shadow: 0 7px 14px rgba(233,69,96,0.4);
    }

    /* Section Title */
    h2 {
        color: #16213e;
        font-weight: 700;
        text-align: center;
        margin-bottom: 30px;
        position: relative;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    h2::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background: linear-gradient(to right, #e94560, #16213e);
    }

    /* Card Body Enhancements */
    .card-body {
        background-color: #f8f9fa;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .movie-card {
            margin-bottom: 20px;
        }
    }
    .card-title {
        color: #212529;
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
    <h2>Nossa Coleção</h2>
    <div class="row g-4">
        <c:forEach var="produto" items="${produtos}">
            <div class="col-12 col-md-4 col-lg-3">
                <a href="/detalha-produto?id=${produto.id}" class="text-decoration-none">
                    <div class="movie-card h-100">
                        <div class="image-container">
                            <img src="${produto.imagens[0].caminhoArquivo}" alt="${produto.nomeProduto}">
                            <div class="overlay">
                                <h4>${produto.nomeProduto}</h4>
                            </div>
                        </div>
                        <div class="card-body text-center p-3">
                            <h5 class="card-title fw-bold mb-2">${produto.nomeProduto}</h5>
                            <p class="text-muted mb-3">${produto.descricao}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="h5 text-danger mb-0">R$${produto.preco}</span>
                            </div>
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