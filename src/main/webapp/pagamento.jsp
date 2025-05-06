<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Pagamento - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/carrinho.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        .pagamento-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            background-color: #fff;
        }
        .resumo-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            position: sticky;
            top: 100px;
        }
        .cartao-section {
            display: none;
            margin-top: 15px;
        }
        .btn-orange {
            background-color:  #000000;
            border: none;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">

<!-- Cabeçalho -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/">
            <i class="fas fa-tshirt me-2"></i>The Manto Store
        </a>
        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <a href="/minhaConta" class="btn btn-outline-light me-2">
                        <i class="fas fa-user-cog"></i>
                        <span class="d-none d-lg-inline ms-1">Minha Conta</span>
                    </a>
                    <a href="/exibirPedidos" class="btn btn-outline-light me-2">
                        <i class="fas fa-clipboard-list"></i>
                        <span class="d-none d-lg-inline ms-1">Meus Pedidos</span>
                    </a>
                    <a href="/logout" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="d-none d-lg-inline ms-1">Sair</span>
                    </a>
                </c:when>
            </c:choose>

            <a href="/carrinho" class="btn btn-outline-light position-relative">
                <i class="fas fa-shopping-cart"></i>
                <span class="d-none d-lg-inline ms-1">Carrinho</span>
                <c:if test="${not empty sessionScope.carrinho}">
                    <span class="cart-count">${sessionScope.carrinho.size()}</span>
                </c:if>
            </a>
        </div>
    </div>
</nav>

<!-- Conteúdo principal -->
<div class="container">
    <div class="row">
        <!-- Coluna esquerda: formas de pagamento -->
        <div class="col-lg-8">
            <form action="resumo-pedido" method="POST" onsubmit="return validarPagamento()">
                <div class="pagamento-card mb-4">
                    <h4><i class="fas fa-credit-card me-2"></i>Forma de Pagamento</h4>

                    <div class="form-check border rounded p-3 mb-3">
                        <input class="form-check-input" type="radio" name="pagamento" id="pix" value="pix">
                        <label class="form-check-label" for="pix">
                            <strong>PIX</strong><br>
                            <small class="text-muted">Pagamento instantâneo com até <strong>7% de desconto</strong>.</small>
                        </label>
                    </div>

                    <div class="form-check border rounded p-3 mb-3">
                        <input class="form-check-input" type="radio" name="pagamento" id="boleto" value="boleto">
                        <label class="form-check-label" for="boleto">
                            <strong>Boleto Bancário</strong><br>
                            <small class="text-muted">Pagamento em até 3 dias úteis.</small>
                        </label>
                    </div>

                    <div class="form-check border rounded p-3">
                        <input class="form-check-input" type="radio" name="pagamento" id="cartao" value="cartao">
                        <label class="form-check-label" for="cartao">
                            <strong>Cartão de Crédito</strong>
                        </label>

                        <div class="cartao-section" id="dados-cartao">
                            <div class="mt-3">
                                <input type="text" name="numeroCartao" class="form-control mb-2" placeholder="Número do Cartão">
                                <input type="text" name="nomeTitular" class="form-control mb-2" placeholder="Nome Completo no Cartão">
                                <input type="text" name="validade" class="form-control mb-2" placeholder="Validade (MM/AA)">
                                <input type="text" name="cvv" class="form-control mb-2" placeholder="CVV (Código Verificador)">
                                <select name="parcelas" class="form-select">
                                    <option value="">Parcelamento</option>
                                    <option value="1">1x sem juros</option>
                                    <option value="2">2x sem juros</option>
                                    <option value="3">3x sem juros</option>
                                    <option value="6">6x com juros</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-orange w-100 mt-4">VALIDAR PEDIDO FINAL</button>
                </div>
            </form>
        </div>

        <!-- Coluna direita: resumo -->
        <div class="col-lg-4">
            <div class="resumo-card">
                <h5><i class="fas fa-search me-2"></i>Resumo do Pedido</h5>
                <p>Valor dos Produtos: <strong><fmt:formatNumber value="${valorProdutos}" type="currency" currencyCode="BRL"/></strong></p>
                <p>Descontos: <span class="text-success">- <fmt:formatNumber value="${descontoPix}" type="currency" currencyCode="BRL"/></span></p>
                <p>Frete: <strong><fmt:formatNumber value="${valorFrete}" type="currency" currencyCode="BRL"/></strong></p>
                <hr>
                <p>Total no PIX: <strong><fmt:formatNumber value="${totalPix}" type="currency" currencyCode="BRL"/></strong></p>
                <a href="carrinho" class="btn btn-outline-secondary w-100 mt-3">VOLTAR</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Confirmação -->
<div class="modal fade" id="modalConfirmacao" tabindex="-1" aria-labelledby="modalConfirmacaoLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="modalConfirmacaoLabel"><i class="fas fa-check-circle me-2"></i>Pedido Concluído</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body text-center">
                <p class="fs-5">Seu pedido foi registrado com sucesso!</p>
                <p>Número do Pedido: <strong>#${sessionScope.numeroPedido}</strong></p>
                <p>Valor Total: <strong>
                    <fmt:formatNumber value="${sessionScope.valorTotal}" type="currency" currencyCode="BRL"/>
                </strong></p>
            </div>
            <div class="modal-footer justify-content-center">
                <a href="/" class="btn btn-outline-secondary">Página Inicial</a>
                <a href="exibirPedidos.jsp" class="btn btn-success">Ver Meus Pedidos</a>
            </div>
        </div>
    </div>
</div>


<!-- Scripts -->
<script>
    // Mostrar ou ocultar campos do cartão
    const radios = document.querySelectorAll('input[name="pagamento"]');
    radios.forEach(radio => {
        radio.addEventListener('change', function () {
            document.getElementById("dados-cartao").style.display = (this.value === 'cartao') ? 'block' : 'none';
        });
    });

    // Validação antes de submeter
    window.validarPagamento = function () {
        const forma = document.querySelector('input[name="pagamento"]:checked');
        if (!forma) {
            alert("Selecione uma forma de pagamento.");
            return false;
        }

        if (forma.value === 'cartao') {
            const numero = document.querySelector('[name="numeroCartao"]').value.trim();
            const nome = document.querySelector('[name="nomeTitular"]').value.trim();
            const validade = document.querySelector('[name="validade"]').value.trim();
            const cvv = document.querySelector('[name="cvv"]').value.trim();
            const parcelas = document.querySelector('[name="parcelas"]').value.trim();

            if (!numero.match(/^\d{16}$/)) {
                alert("O número do cartão deve conter 16 dígitos.");
                return false;
            }

            if (nome === "") {
                alert("Preencha o nome do titular.");
                return false;
            }

            if (!validade.match(/^(0[1-9]|1[0-2])\/\d{2}$/)) {
                alert("A validade deve estar no formato MM/AA.");
                return false;
            }

            if (!cvv.match(/^\d{3,4}$/)) {
                alert("O CVV deve ter 3 ou 4 dígitos.");
                return false;
            }

            if (parcelas === "") {
                alert("Selecione a quantidade de parcelas.");
                return false;
            }
        }

        return true;
    };


</script>

</body>
</html>
