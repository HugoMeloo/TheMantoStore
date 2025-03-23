<!DOCTYPE html>
<html lang="pt-br">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
    <meta charset="UTF-8"/>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link href="/webjars/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <title>The Manto Store | Produtos</title>
    <style>
        .table-responsive {
            overflow-x: hidden;
        }
        .btn-ativar {
            background-color: #198754;
            color: white;
        }
        .btn-desativar {
            background-color: #dc3545;
            color: white;
        }
        .search-input {
            max-width: 400px;
        }
        .pagination-container {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            background: white;
            padding: 10px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<header class="navbar navbar-dark sticky-top bg-info text-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6 bg-info text-dark fw-bold" href="/index.jsp">The Manto
        Store</a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <input class="form-control form-control-dark rounded-pill border-0 my-2 search-input" type="text"
           placeholder="Search" aria-label="Search">
    <div class="navbar-nav">
        <div class="nav-item text-nowrap">
            <a class="nav-link px-3" href="/logout">Sign out</a>
        </div>
    </div>
</header>
<div class="container-fluid">
    <div class="row">
        <main class="col-12 px-md-4">
            <h2>Produtos</h2>
            <c:set var="pageSize" value="10"/>
            <c:set var="totalItems" value="${fn:length(produtos)}"/>
            <c:set var="totalPages" value="${(totalItems + pageSize - 1) / pageSize}"/>
            <c:set var="currentPage" value="${(totalItems <= pageSize) ? 1 : (param.page ne null ? param.page : 1)}"/>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-sm w-100">
                    <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nome</th>
                        <th>Preço</th>
                        <th>Quantidade</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
                    <c:set var="end" value="${start + pageSize}"/>
                    <c:forEach var="produto" items="${produtos}" varStatus="status">
                        <c:if test="${status.index >= start && status.index < end}">
                            <tr>
                                <td>${produto.id}</td>
                                <td>${produto.nomeProduto}</td>
                                <td>${produto.preco}</td>
                                <td>${produto.qtdEstoque}</td>
                                <td>${produto.status ? 'Ativo' : 'Inativo'}</td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <!-- Botão para abrir o modal de atualização -->
                                        <a class="btn btn-warning" href="#" onclick="modalManager.abrirModalAtualizarProduto({
                                                id: '${produto.id}',
                                                nomeProduto: '${produto.nomeProduto}',
                                                avaliacao: '${produto.avaliacao}',
                                                qtdEstoque: '${produto.qtdEstoque}',
                                                preco: '${produto.preco}'
                                                })">Alterar</a>
                                        <!-- ---------------------------------------------------- -->
                                        <!-- Botão para chamar o Modal para mostrar detalhes -->
                                        <button class="btn btn-success"
                                                onclick="mostrarDetalhes('${produto.id}', '${produto.nomeProduto}', '${produto.preco}', '${produto.avaliacao}', '${produto.descricao}', '${produto.imagens[0].caminhoArquivo}')">
                                            Visualizar
                                        </button>
                                        <!-- ---------------------------------------------------- -->
                                        <!-- Switch de status -->
                                        <form id="statusForm-${produto.id}" action="/AlterarStatusProduto"
                                              method="post" class="d-flex align-items-center">
                                            <input type="hidden" name="id" value="${produto.id}">
                                            <input type="hidden" name="page" value="${currentPage}">
                                            <input type="hidden" id="statusHidden-${produto.id}" name="status"
                                                   value="${produto.status ? 'true' : 'false'}">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox"
                                                       id="statusSwitch-${produto.id}"
                                                       data-nome-produto="${produto.nomeProduto}"
                                                    ${produto.status ? 'checked' : ''}>
                                                <label class="form-check-label fw-bold ms-2"
                                                       for="statusSwitch-${produto.id}">
                                                        ${produto.status ? 'Ativo' : 'Inativo'}
                                                </label>
                                            </div>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${totalPages > 1}">
                <div class="pagination-container">
                    <nav>
                        <ul class="pagination">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Anterior">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active">
                                <span class="page-link">${currentPage}</span>
                            </li>
                            <li class="page-item ${currentPage > totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Próximo">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
            <div class="position-fixed bottom-0 end-0 m-3">
                <div style="position: fixed; bottom: 40px; right: 40px; z-index: 9999;">
                    <button class="btn btn-info text-dark" onclick="modalManager.abrirCadastroProdutoModal()">
                        + Novo Produto
                    </button>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="modais.jsp"/>
<script src="../js/ModalManager.js"></script>
<script src="../js/feather.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/drop.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>