<!DOCTYPE html>
<html lang="en">
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
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let originalCheckboxState = {}; // Armazena os estados originais dos checkboxes

            document.querySelectorAll(".form-check-input").forEach(checkbox => {
                let produtoId = checkbox.id.replace("statusSwitch-", ""); // Pega o ID do produto
                originalCheckboxState[produtoId] = checkbox.checked; // Salva o estado original

                // Intercepta a mudança do checkbox
                checkbox.addEventListener("click", function (event) {
                    event.preventDefault(); // Impede a alteração imediata do estado do checkbox
                    abrirConfirmacao(event, produtoId, checkbox);
                });
            });

            function abrirConfirmacao(event, produtoId, checkbox) {
                let statusAtual = checkbox.checked;
                let statusTexto = statusAtual ? "Ativo" : "Inativo";
                let novoStatus = statusAtual ? "desativar" : "ativar";
                let currentPage = new URLSearchParams(window.location.search).get("page") || 1;

                // Atualiza o modal com informações do produto
                document.getElementById("confirmMessage").innerText =
                    `O produto ID ${produtoId} está atualmente ${statusTexto}. Deseja ${novoStatus} este produto?`;

                document.getElementById("modalProdutoId").value = produtoId;
                document.getElementById("modalStatus").value = statusAtual ? "false" : "true";
                document.getElementById("modalCurrentPage").value = currentPage;

                // Exibe o modal
                let modal = new bootstrap.Modal(document.getElementById("confirmModal"));
                modal.show();

                // Se o usuário cancelar, volta ao estado original
                document.getElementById("cancelAction").onclick = function () {
                    checkbox.checked = originalCheckboxState[produtoId]; // Volta ao estado salvo
                };
            }

            // Confirma a ação e submete o formulário
            document.getElementById("confirmAction").addEventListener("click", function () {
                let produtoId = document.getElementById("modalProdutoId").value;
                let novoStatus = document.getElementById("modalStatus").value;
                let currentPage = document.getElementById("modalCurrentPage").value;

                let form = document.createElement("form");
                form.method = "POST";
                form.action = "/AlterarStatusProduto";

                form.innerHTML = `
                     <input type="hidden" name="id" value="${produtoId}">
                     <input type="hidden" name="status" value="${novoStatus}">
                     <input type="hidden" name="page" value="${currentPage}">
                 `;

                document.body.appendChild(form);
                form.submit();
            });
        });
    </script>
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
                                        <a class="btn btn-warning" href="#" data-bs-toggle="modal"
                                           data-bs-target="#updateProdutoModal-${produto.id}">Alterar</a>

                                        <!-- Modal de atualização -->
                                        <div class="modal fade" id="updateProdutoModal-${produto.id}" tabindex="-1"
                                             aria-labelledby="updateProdutoModalLabel-${produto.id}"
                                             aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content p-4">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title"
                                                            id="updateProdutoModalLabel-${produto.id}">Atualizar
                                                            Produto</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!-- Formulário de atualização -->
                                                        <form action="/CadastrarProduto" method="post" enctype="multipart/form-data">
                                                            <!-- ID do Produto (campo oculto) -->
                                                            <input type="hidden" name="id" value="${produto.id}">

                                                            <!-- Nome do Produto -->
                                                            <div class="form-group">
                                                                <label for="nome-${produto.id}">Nome do Produto:</label>
                                                                <input type="text" class="form-control"
                                                                       id="produto-name-${produto.id}" name="produto-name"
                                                                       value="${produto.nomeProduto}" required>
                                                            </div>

                                                            <!-- Avaliação -->
                                                            <div class="form-group">
                                                                <label for="avaliacao-${produto.id}">Avaliação:</label>
                                                                <input type="number" class="form-control"
                                                                       id="avaliacao-${produto.id}" name="avaliacao"
                                                                       value="${produto.avaliacao}" required>
                                                            </div>

                                                            <!-- Quantidade Estoque -->
                                                            <div class="form-group">
                                                                <label for="qtdEstoque-${produto.id}">Quantidade:</label>
                                                                <input type="number" class="form-control"
                                                                       id="qtdEstoque-${produto.id}" name="qtdEstoque"
                                                                       value="${produto.qtdEstoque}" required>
                                                            </div>

                                                            <!-- Preço -->
                                                            <div class="form-group">
                                                                <label for="preco-${produto.id}">Preço Unitário (R$):</label>
                                                                <input type="text" class="form-control"
                                                                       id="preco-${produto.id}" name="preco"
                                                                       value="${produto.preco}" required>
                                                            </div>

                                                            <!-- Upload de Novas Imagens -->
                                                            <div class="form-group">
                                                                <label for="imageProduto-${produto.id}">Selecionar novas imagens (opcional):</label>
                                                                <input type="file" class="form-control"
                                                                       name="imagemProduto"
                                                                       id="imageProduto-${produto.id}" multiple>
                                                                <small class="text-muted">As novas imagens substituirão as antigas.</small>
                                                            </div>

                                                            <!-- Botão de Atualização -->
                                                            <button type="submit" class="btn btn-primary mt-3">
                                                                Atualizar
                                                            </button>
                                                        </form>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <button class="btn btn-success"
                                                onclick="mostrarDetalhes('${produto.id}', '${produto.nomeProduto}', '${produto.preco}', '${produto.avaliacao}', '${produto.descricao}', '${produto.imagens[0].caminhoArquivo}')">
                                            Visualizar
                                        </button>
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
                                                    ${produto.status ? 'checked' : ''}
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#confirmModal-${produto.id}">
                                                <label class="form-check-label fw-bold ms-2"
                                                       for="statusSwitch-${produto.id}">
                                                        ${produto.status ? 'Ativo' : 'Inativo'}
                                                </label>
                                            </div>
                                        </form>
                                    </div>

                                </td>

                            </tr>
                            <!-- Modal de Confirmação puxando os dados do JSP diretamente -->
                            <div class="modal fade" id="confirmModal-${produto.id}" tabindex="-1"
                                 aria-labelledby="confirmModalLabel-${produto.id}" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="confirmModalLabel-${produto.id}">Confirmação de
                                                Alteração</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>O produto <strong>${produto.nomeProduto}</strong> (ID:
                                                <strong>${produto.id}</strong>) está atualmente
                                                <strong>${produto.status ? 'Ativo' : 'Inativo'}</strong>.</p>
                                            <p>Deseja realmente
                                                <strong>${produto.status ? 'desativar' : 'ativar'}</strong> este
                                                produto?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                Cancelar
                                            </button>
                                            <form action="/AlterarStatusProduto" method="post">
                                                <input type="hidden" name="id" value="${produto.id}">
                                                <input type="hidden" name="status" value="${!produto.status}">
                                                <input type="hidden" name="page" value="${currentPage}">
                                                <button type="submit" class="btn btn-primary">Confirmar</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                <div class="dropdown">
                    <button class="btn bg-info text-dark dropdown-toggle" type="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                        Ações
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal"
                               data-bs-target="#cadastrarProdutoModal">+ Novo Produto</a></li>
                    </ul>
                </div>
            </div>
            <!-- Modal de cadastro de produto -->
            <div class="modal fade" id="cadastrarProdutoModal" tabindex="-1"
                 aria-labelledby="cadastrarProdutoModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content p-4">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cadastrarProdutoModalLabel">Cadastrar Produto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/CadastrarProduto" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" id="id"
                                       value="${param.id != null && param.id != '' ? param.id : 0}">
                                <div class="form-group">
                                    <label for="produto-name">Nome do Produto:</label>
                                    <input type="text" class="form-control" id="produto-name" name="produto-name"
                                           maxlength="255" required>
                                </div>
                                <div class="form-group">
                                    <label for="avaliacao">Avaliação:</label>
                                    <input type="number" step="0.5" min="0.5" max="5" class="form-control"
                                           id="avaliacao" name="avaliacao" required>
                                </div>
                                <div class="form-group">
                                    <label for="descricao">Descrição (até 2000 caracteres):</label>
                                    <textarea class="form-control" id="descricao" name="descricao" maxlength="2000"
                                              required></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="preco">Preço:</label>
                                    <input type="number" step="0.01" class="form-control" id="preco" name="preco"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label for="quantidade">Quantidade Estoque:</label>
                                    <input type="number" class="form-control" id="quantidade" name="quantidade"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label for="imageProduto">Imagens:</label>
                                    <input type="file" class="form-control" name="imageProduto" id="imageProduto"
                                           multiple required>
                                    <small>Selecione múltiplas imagens</small>
                                </div>
                                <button type="submit" class="btn btn-primary mt-3">Cadastrar</button>
                                <button type="button" class="btn btn-secondary mt-3"
                                        onclick="window.location.href='/ExibirProdutos'">Cancelar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <!-- Modal de Detalhes do Produto -->
    <div class="modal fade" id="detalheProdutoModal" tabindex="-1" aria-labelledby="detalheProdutoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content bg-dark text-white shadow-lg rounded-4">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold" id="detalheProdutoModalLabel">Detalhes do Produto</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row align-items-center">
                        <div class="col-md-5 text-center">
                            <img id="produtoImagem" src="https://via.placeholder.com/350" class="img-fluid rounded-3 shadow-sm" alt="Imagem do Produto">
                        </div>
                        <div class="col-md-7">
                            <h3 id="produtoNome" class="fw-bold text-uppercase"></h3>
                            <p class="text-muted">ID: <span id="produtoId"></span></p>
                            <p class="fs-5"><strong>Preço:</strong> <span class="text-success fw-bold">R$ <span id="produtoPreco"></span></span></p>
                            <p class="fs-5"><strong>Avaliação:</strong> <span id="produtoAvaliacao"></span> ⭐</p>
                            <p><strong>Descrição:</strong></p>
                            <p id="produtoDescricao" class="text-white"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-outline-light px-4 rounded-pill" data-bs-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="http://localhost:8080/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="../js/feather.min.js"></script>
<script src="../js/dashboard.js"></script>
<script src="../js/drop.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script>
    function mostrarDetalhes(id, nome, preco, avaliacao, descricao, imagem) {
        document.getElementById("produtoId").textContent = id;
        document.getElementById("produtoNome").textContent = nome;
        document.getElementById("produtoPreco").textContent = preco;
        document.getElementById("produtoAvaliacao").textContent = avaliacao;
        document.getElementById("produtoDescricao").textContent = descricao;

        // Alterando a imagem no modal
        document.getElementById("produtoImagem").src = imagem ? imagem : "https://via.placeholder.com/350";

        let modal = new bootstrap.Modal(document.getElementById("detalheProdutoModal"));
        modal.show();
    }
</script>
</body>
</html>