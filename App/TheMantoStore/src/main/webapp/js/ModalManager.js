class ModalManager {
    constructor() {
        this.modal = null;
        this.originalCheckboxState = {};
    }



    abrirModal(modalId) {
        this.modal = new bootstrap.Modal(document.getElementById(modalId));
        this.modal.show();
    }

    atualizarConteudo(modalId, conteudo) {
        let modalElement = document.getElementById(modalId);
        if (modalElement) {
            for (let key in conteudo) {
                let element = modalElement.querySelector(`#${key}`);
                if (element) {
                    if (element.tagName === "IMG") {
                        const caminhoImagem = conteudo[key];
                        element.src = caminhoImagem
                            ? `http://localhost:8080/${caminhoImagem}`
                            : "https://via.placeholder.com/350";
                    } else {
                        element.textContent = conteudo[key];
                    }
                }
            }
        }
    }

    abrirConfirmacaoCheckbox(produtoId, nomeProduto, statusAtual, checkbox) {
        let statusTexto = statusAtual ? "Ativo" : "Inativo";
        let novoStatusTexto = statusAtual ? "desativar" : "ativar";
        let currentPage = new URLSearchParams(window.location.search).get("page") || 1;

        document.getElementById("modalProdutoIdTexto").textContent = produtoId;
        document.getElementById("modalNomeProduto").textContent = nomeProduto;
        document.getElementById("modalStatusAtual").textContent = statusTexto;
        document.getElementById("modalNovoStatus").textContent = novoStatusTexto;

        document.getElementById("modalProdutoId").value = produtoId;
        document.getElementById("modalStatus").value = statusAtual ? "false" : "true";
        document.getElementById("modalCurrentPage").value = currentPage;

        this.abrirModal("confirmModal");

        document.getElementById("cancelAction").onclick = () => {
            checkbox.checked = this.originalCheckboxState[produtoId];
        };
    }

    inicializarCheckboxes() {
        document.querySelectorAll(".form-check-input").forEach(checkbox => {
            let produtoId = checkbox.id.replace("statusSwitch-", "");
            let nomeProduto = checkbox.getAttribute("data-nome-produto");
            let statusAtual = checkbox.checked;

            this.originalCheckboxState[produtoId] = checkbox.checked;

            checkbox.addEventListener("click", (event) => {
                event.preventDefault();
                this.abrirConfirmacaoCheckbox(produtoId, nomeProduto, statusAtual, checkbox);
            });
        });

        document.getElementById("confirmAction").addEventListener("click", () => {
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
    }

    abrirCadastroProdutoModal() {
        const modal = new bootstrap.Modal(document.getElementById('cadastrarProdutoModal'));
        const form = document.querySelector('#cadastrarProdutoModal form');
        form.reset();
        form.querySelector('#id').value = '0';
        modal.show();
    }

    abrirModalAtualizarProduto(produto) {
        const modalElement = document.getElementById('updateProdutoModal');

        if (!modalElement) {
            console.error('Modal de atualização não encontrado!');
            return;
        }

        const form = modalElement.querySelector('form');

        // Preenche os campos com os dados do produto
        form.querySelector('#updateProdutoId').value = produto.id;
        form.querySelector('#updateProdutoNome').value = produto.nomeProduto;
        form.querySelector('#updateProdutoAvaliacao').value = produto.avaliacao;
        form.querySelector('#updateProdutoQtdEstoque').value =
            produto.qtdEstoque !== undefined && produto.qtdEstoque !== null ? produto.qtdEstoque : '';
        form.querySelector('#updateProdutoPreco').value = produto.preco;
        form.querySelector('input[name="imagemProduto"]').value = '';

        // Captura o número da página atual da URL
        const params = new URLSearchParams(window.location.search);
        const currentPage = params.get("page") || 1;

        // Preenche o campo hidden com a página atual
        form.querySelector('#updateProdutoPage').value = currentPage;

        this.abrirModal('updateProdutoModal');
    }
}

const modalManager = new ModalManager();

function mostrarDetalhes(id, nome, preco, avaliacao, descricao, imagens) {
    console.log("🛠️ Dados recebidos em mostrarDetalhes:", {
        id,
        nome,
        preco,
        avaliacao,
        descricao,
        imagens
    });
    // Garante que imagens seja sempre um array
    if (!Array.isArray(imagens)) {
        imagens = imagens ? [imagens] : [];
    }

    // Atualiza os textos do modal
    modalManager.atualizarConteudo("detalheProdutoModal", {
        produtoId: id,
        produtoNome: nome,
        produtoPreco: Number(preco).toFixed(2),
        produtoAvaliacao: avaliacao,
        produtoDescricao: descricao
    });

    // Preenche dinamicamente o carrossel
    const container = document.getElementById("carouselImagensContainer");
    container.innerHTML = '';

    if (imagens.length > 0) {
        imagens.forEach((url, index) => {
            const item = document.createElement('div');
            item.className = `carousel-item ${index === 0 ? 'active' : ''}`;
            item.innerHTML = `<img src="${url}" class="d-block w-100 rounded-3 shadow-sm" alt="Imagem do Produto ${index + 1}">`;
            container.appendChild(item);
        });
    } else {
        const fallback = document.createElement('div');
        fallback.className = 'carousel-item active';
        fallback.innerHTML = `<img src="https://via.placeholder.com/350" class="d-block w-100 rounded-3 shadow-sm" alt="Imagem padrão">`;
        container.appendChild(fallback);
    }

    // Reinstancia o carrossel para garantir funcionamento dinâmico
    const carouselElement = document.querySelector('#carouselImagensProduto');
    if (carouselElement) {
        const carousel = bootstrap.Carousel.getInstance(carouselElement);
        if (carousel) {
            carousel.dispose();
        }
        new bootstrap.Carousel(carouselElement);
    }

    // Abre o modal
    modalManager.abrirModal("detalheProdutoModal");
}




document.addEventListener("DOMContentLoaded", function () {
    modalManager.inicializarCheckboxes();
});