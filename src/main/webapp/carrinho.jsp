<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Carrinho - The Manto Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/carrinho.css">
</head>
<body>

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
                <c:otherwise>
                    <a href="/login" class="btn btn-outline-light me-2">
                        <i class="fas fa-user"></i>
                        <span class="d-none d-lg-inline ms-1">Conta</span>
                    </a>
                </c:otherwise>
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

<div class="container mb-5">
    <h1 class="page-title">
        <i class="fas fa-shopping-cart"></i> Seu Carrinho
    </h1>

    <c:if test="${empty sessionScope.carrinho}">
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-basket"></i>
            </div>
            <h3 class="mb-3">Seu carrinho está vazio</h3>
            <p class="text-muted mb-4">Adicione produtos para continuar</p>
            <a href="/" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i> Voltar às compras
            </a>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.carrinho}">
        <div class="row">
            <div class="col-lg-8">
                <c:forEach var="item" items="${sessionScope.carrinho}">
                    <div class="product-card">
                        <img src="${item.produto.imagens[0].caminhoArquivo}" alt="Imagem do Produto"
                             class="product-image">
                        <div class="product-info">
                            <h3 class="product-title">${item.produto.nomeProduto}</h3>
                            <p class="product-price">R$ ${item.produto.preco}</p>

                            <div class="product-meta">
                                <span class="product-quantity">
                                    <i class="fas fa-box-open"></i> ${item.quantidade} un.
                                </span>
                                <span class="status-${item.produto.status ? 'available' : 'unavailable'}">
                                    <i class="fas fa-${item.produto.status ? 'check-circle' : 'times-circle'}"></i>
                                    ${item.produto.status ? 'Disponível' : 'Indisponível'}
                                </span>
                            </div>

                            <div class="quantity-control">
                                <a href="/carrinho?id=${item.produto.id}&acao=remover" class="quantity-btn remove-btn">
                                    <i class="fas fa-minus"></i>
                                </a>
                                <a href="/carrinho?id=${item.produto.id}&acao=adicionar" class="quantity-btn add-btn">
                                    <i class="fas fa-plus"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="shipping-card">
                    <h3 class="shipping-title">
                        <i class="fas fa-truck"></i> Calcular Frete
                    </h3>
                    <div class="cep-input-group">
                        <input type="text" id="cep" class="form-control cep-input" placeholder="Digite seu CEP">
                        <button class="btn btn-calculate" onclick="calcularFrete()">
                            <i class="fas fa-calculator me-2"></i> Calcular
                        </button>
                    </div>
                    <div id="frete-opcoes" class="shipping-options" style="display:none;">
                        <p class="mb-3">Escolha o tipo de entrega:</p>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-rapido" value="25" onclick="selecionarFrete(25)">
                            <label for="frete-rapido">
                                <span>Entrega Rápida <small>(2-3 dias úteis)</small></span>
                                <span>R$ 25,00</span>
                            </label>
                        </div>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-sedex" value="20" onclick="selecionarFrete(20)">
                            <label for="frete-sedex">
                                <span>SEDEX <small>(3-5 dias úteis)</small></span>
                                <span>R$ 20,00</span>
                            </label>
                        </div>
                        <div class="shipping-option">
                            <input type="radio" name="frete" id="frete-agendada" value="15"
                                   onclick="selecionarFrete(15)">
                            <label for="frete-agendada">
                                <span>Entrega Agendada <small>(5-7 dias úteis)</small></span>
                                <span>R$ 15,00</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <c:if test="${not empty sessionScope.usuario}">
                    <c:if test="${not empty sessionScope.erroEndereco}">
                        <div class="alert alert-warning">${sessionScope.erroEndereco}</div>
                    </c:if>
                    <c:if test="${not empty sessionScope.erroFrete}">
                        <div class="alert alert-warning">${sessionScope.erroFrete}</div>
                    </c:if>
                </c:if>
                <div class="summary-card">

                    <h3 class="summary-title">
                        <i class="fas fa-receipt"></i> Resumo do Pedido
                    </h3>

                    <div class="summary-item">
                        <span>Subtotal</span>
                        <span>${requestScope.totalCarrinho}</span>
                    </div>

                    <div class="summary-item">
                        <span>Frete</span>
                        <span id="frete-valor">-</span>
                    </div>

                    <div class="summary-total">
                        <span>Total</span>
                        <span id="total-com-frete">${totalCarrinho}</span>
                    </div>

                    <c:if test="${not empty requestScope.enderecosUsuario}">


                        <!-- Bloco de endereços -->
                        <div class="summary-card mt-4">
                            <h3 class="summary-title">
                                <i class="fas fa-map-marker-alt"></i> Endereço de Entrega
                            </h3>
                            <form id="form-endereco">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <a href="/novoEndereco" class="text-decoration-none fw-bold text-warning">+ Novo
                                        Endereço</a>
                                </div>
                                <c:forEach var="endereco" items="${requestScope.enderecosUsuario}">

                                    <c:if test="${endereco.tipoEndereco ne 'FATURAMENTO'}">


                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="radio"
                                                   name="enderecoEntrega"
                                                   id="endereco-${endereco.idEndereco}"
                                                   value="${endereco.idEndereco}" required>
                                            <label class="form-check-label" for="endereco-${endereco.idEndereco}">
                                                    ${endereco.tipoEndereco}
                                                - ${endereco.logradouro}, ${endereco.numero},
                                                    ${endereco.bairro}, ${endereco.cidade} - ${endereco.uf},
                                                CEP: ${endereco.cep}
                                            </label>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </form>
                        </div>
                    </c:if>

                    <!-- Botão de finalização com lógica condicional -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuario}">
                            <form action="carrinho" method="POST" class="mt-2">
                                <input type="hidden" name="enderecoSelecionado" id="enderecoSelecionado"/>
                                <button type="submit" class="btn btn-checkout w-100">
                                    <i class="fas fa-credit-card me-2"></i> Finalizar Compra
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <c:set var="currentUrl" value="/carrinho"/>
                            <c:if test="${not empty param.id}">
                                <c:set var="currentUrl" value="/carrinho?id=${param.id}"/>
                            </c:if>

                            <a href="/login?redirect=${currentUrl}" class="btn btn-outline-primary w-100 mt-2">
                                <i class="fas fa-lock me-2"></i> Faça login para finalizar a compra
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function calcularFrete() {
        let cep = document.getElementById("cep").value.trim();
        let opcoesFrete = document.getElementById("frete-opcoes");

        if (cep.length === 8 && !isNaN(cep)) {
            opcoesFrete.style.display = "block";
        } else {
            alert("Por favor, digite um CEP válido com 8 números.");
        }
    }

    function selecionarFrete(valorFrete) {
        // Atualiza o valor do frete no resumo
        document.getElementById("frete-valor").innerText = "R$ " + valorFrete.toFixed(2);

        // Obtém o subtotal do carrinho
        let subtotalText = document.getElementById("total-com-frete").innerText;
        let subtotal = parseFloat(subtotalText.replace("R$", "").replace(",", ".").trim());

        // Calcula o total com frete
        let totalComFrete = subtotal + valorFrete;

        // Atualiza o total no resumo do pedido
        document.getElementById("total-com-frete").innerText = "R$ " + totalComFrete.toFixed(2);
    }

    document.querySelector("form[action='carrinho']").addEventListener("submit", function (e) {
        const enderecoSelecionado = document.querySelector("input[name='enderecoEntrega']:checked");
        const freteSelecionado = document.querySelector("input[name='frete']:checked");

        if (!enderecoSelecionado) {
            e.preventDefault();
            alert("Por favor, selecione um endereço de entrega.");
            return;
        }

        if (!freteSelecionado) {
            e.preventDefault();
            alert("Por favor, selecione uma opção de frete.");
            return;
        }

        document.getElementById("enderecoSelecionado").value = enderecoSelecionado.value;

        // Cria campo hidden dinamicamente para o frete
        let freteInput = document.getElementById("freteSelecionado");
        if (!freteInput) {
            freteInput = document.createElement("input");
            freteInput.type = "hidden";
            freteInput.name = "valorFrete";
            freteInput.id = "freteSelecionado";
            this.appendChild(freteInput);
        }

        freteInput.value = freteSelecionado.value;
    });

    // Ao selecionar um endereço, preenche automaticamente o campo de CEP (sem caracteres especiais)
    document.querySelectorAll("input[name='enderecoEntrega']").forEach(function (radio) {
        radio.addEventListener("change", function () {
            const label = this.nextElementSibling.innerText;
            const cepMatch = label.match(/\d{5}-?\d{3}/); // captura CEP no formato 00000-000 ou 00000000
            if (cepMatch) {
                const cepLimpo = cepMatch[0].replace(/\D/g, ""); // remove tudo que não for dígito
                document.getElementById("cep").value = cepLimpo;
                calcularFrete(); // exibe as opções de frete
            }
        });
    });


</script>
</body>
</html>