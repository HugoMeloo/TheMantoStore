<!DOCTYPE html>
<html lang="pt-br">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
    <meta charset="UTF-8"/>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link href="/webjars/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- Modal de Detalhes do Produto -->
<div class="modal fade" id="detalheProdutoModal" tabindex="-1" aria-labelledby="detalheProdutoModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content bg-dark text-white shadow-lg rounded-4">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold" id="detalheProdutoModalLabel">Detalhes do Produto</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row align-items-center">
                    <div class="col-md-5 text-center">
                        <img id="produtoImagem" src="https://via.placeholder.com/350"
                             class="img-fluid rounded-3 shadow-sm" alt="Imagem do Produto">
                    </div>
                    <div class="col-md-7">
                        <h3 id="produtoNome" class="fw-bold text-uppercase"></h3>
                        <p class="text-muted">ID: <span id="produtoId"></span></p>
                        <p class="fs-5"><strong>Preço:</strong> <span class="text-success fw-bold">R$ <span
                                id="produtoPreco"></span></span></p>
                        <p class="fs-5"><strong>Avaliação:</strong> <span id="produtoAvaliacao"></span> ⭐</p>
                        <p><strong>Descrição:</strong></p>
                        <p id="produtoDescricao" class="text-white"></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-outline-light px-4 rounded-pill" data-bs-dismiss="modal">Fechar
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Genérico de Confirmação com informações detalhadas do produto -->
<div class="modal fade" id="confirmModal" tabindex="-1"
     aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Confirmação de Alteração</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>
                    O produto <strong id="modalNomeProduto"></strong> (ID: <strong id="modalProdutoIdTexto"></strong>)
                    está atualmente
                    <strong id="modalStatusAtual"></strong>.
                </p>
                <p>
                    Deseja realmente <strong id="modalNovoStatus"></strong> este produto?
                </p>

                <!-- Campos ocultos usados pelo JavaScript -->
                <input type="hidden" id="modalProdutoId">
                <input type="hidden" id="modalStatus">
                <input type="hidden" id="modalCurrentPage">
            </div>
            <div class="modal-footer">
                <button type="button" id="cancelAction" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancelar
                </button>
                <button type="button" id="confirmAction" class="btn btn-primary">
                    Confirmar
                </button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para Cadastro de Produto -->
<div class="modal fade" id="cadastrarProdutoModal" tabindex="-1" aria-labelledby="cadastrarProdutoModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content p-4">
            <div class="modal-header">
                <h5 class="modal-title" id="cadastrarProdutoModalLabel">Cadastrar Produto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body">
                <form action="/CadastrarProduto" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" id="id"
                           value="${param.id != null && param.id != '' ? param.id : 0}">
                    <input type="hidden" name="imagemPrincipalIndex" id="imagemPrincipalIndex">

                    <div class="mb-3">
                        <label for="produto-name" class="form-label">Nome do Produto:</label>
                        <input type="text" class="form-control" id="produto-name" name="produto-name"
                               maxlength="255" required>
                    </div>

                    <div class="mb-3">
                        <label for="avaliacao" class="form-label">Avaliação:</label>
                        <input type="number" step="0.5" min="0.5" max="5" class="form-control"
                               id="avaliacao" name="avaliacao" required>
                    </div>

                    <div class="mb-3">
                        <label for="descricao" class="form-label">Descrição (até 2000 caracteres):</label>
                        <textarea class="form-control" id="descricao" name="descricao" maxlength="2000"
                                  required></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="preco" class="form-label">Preço:</label>
                        <input type="number" step="0.01" class="form-control" id="preco" name="preco"
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="qtdEstoque" class="form-label">Quantidade Estoque:</label>
                        <input type="number" class="form-control" id="qtdEstoque" name="qtdEstoque"
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="imageProduto" class="form-label">Imagens:</label>
                        <input type="file" class="form-control" name="imageProduto" id="imageProduto"
                               multiple required accept="image/*">
                        <small class="form-text text-muted">Selecione múltiplas imagens. Escolha a principal abaixo.</small>
                    </div>

                    <!-- Área de preview das imagens -->
                    <div id="previewImagens" class="d-flex flex-wrap gap-3 mt-3"></div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">Cadastrar</button>
                        <button type="button" class="btn btn-secondary"
                                onclick="window.location.href='/ExibirProdutos'">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Genérico de Atualização de Produto -->
<div class="modal fade" id="updateProdutoModal" tabindex="-1" aria-labelledby="updateProdutoModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content p-4">
            <div class="modal-header">
                <h5 class="modal-title">Atualizar Produto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${tipoUsuario eq 'admin' ? '/CadastrarProduto' : '/AtualizarQuantidadeProduto'}"
                      method="post"
                ${tipoUsuario eq 'admin' ? 'enctype="multipart/form-data"' : ''}>
                    <input type="hidden" name="page" id="updateProdutoPage">
                    <input type="hidden" id="updateProdutoId" name="id">

                    <div class="form-group">
                        <label>Nome do Produto:</label>
                        <input type="text" class="form-control" id="updateProdutoNome" name="produto-name"
                               required ${tipoUsuario ne 'admin' ? 'disabled' : ''}>
                    </div>

                    <div class="form-group">
                        <label>Avaliação:</label>
                        <input type="number" step="0.5" min="0.5" max="5" class="form-control"
                               id="updateProdutoAvaliacao" name="avaliacao"
                               required ${tipoUsuario ne 'admin' ? 'disabled' : ''}>
                    </div>

                    <div class="form-group">
                        <label>Quantidade Estoque:</label>
                        <input type="number" class="form-control"
                               id="updateProdutoQtdEstoque" name="qtdEstoque" required>
                    </div>

                    <div class="form-group">
                        <label>Preço Unitário (R$):</label>
                        <input type="text" class="form-control" id="updateProdutoPreco" name="preco"
                               required ${tipoUsuario ne 'admin' ? 'disabled' : ''}>
                    </div>

                    <div class="form-group">
                        <label>Selecionar novas imagens (opcional):</label>
                        <input type="file" class="form-control" name="imagemProduto"
                               multiple ${tipoUsuario ne 'admin' ? 'disabled' : ''}>
                        <small class="text-muted">As novas imagens substituirão as antigas.</small>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Atualizar</button>
                </form>
            </div>
        </div>
    </div>
</div>


<script src="../js/feather.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/drop.js"></script>
<script src="/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>