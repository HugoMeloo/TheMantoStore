/**
 * Inicializa o preview de imagens e permite escolher a imagem principal.
 *
 * @param {string} inputId - ID do input type="file"
 * @param {string} previewContainerId - ID da div onde as imagens serão exibidas
 * @param {string} hiddenInputId - ID do input hidden onde será salvo o índice da imagem principal
 */
function inicializarPreviewImagens(inputId, previewContainerId, hiddenInputId) {
    const inputImagens = document.getElementById(inputId);
    const previewContainer = document.getElementById(previewContainerId);
    const inputImagemPrincipal = document.getElementById(hiddenInputId);

    if (!inputImagens || !previewContainer || !inputImagemPrincipal) return;

    inputImagens.addEventListener('change', function () {
        const files = inputImagens.files;
        previewContainer.innerHTML = '';

        if (!files || files.length === 0) {
            inputImagemPrincipal.value = "";
            return;
        }

        Array.from(files).forEach((file, index) => {
            const reader = new FileReader();

            reader.onload = function (event) {
                // Container para imagem e radio
                const col = document.createElement('div');
                col.className = 'text-center';

                // Imagem
                const img = document.createElement('img');
                img.src = event.target.result;
                img.className = 'img-thumbnail';
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.objectFit = 'cover';

                // Radio para marcar como principal
                const radio = document.createElement('input');
                radio.type = 'radio';
                radio.name = `${previewContainerId}-imagemPrincipal`;
                radio.value = index;
                radio.className = 'form-check-input mt-2';
                radio.onclick = () => {
                    inputImagemPrincipal.value = index;
                };

                // Marca a primeira como principal por padrão
                if (index === 0) {
                    radio.checked = true;
                    inputImagemPrincipal.value = 0;
                }

                // Texto "Principal"
                const label = document.createElement('div');
                label.innerText = 'Principal';
                label.style.fontSize = '0.8em';

                col.appendChild(img);
                col.appendChild(radio);
                col.appendChild(label);

                previewContainer.appendChild(col);
            };

            reader.readAsDataURL(file);
        });
    });
}

// ✅ Inicializa previews ao carregar a página
document.addEventListener("DOMContentLoaded", function () {
    // Para o modal de cadastro
    inicializarPreviewImagens("imageProduto", "previewImagens", "imagemPrincipalIndex");

    // Para o modal de atualização
    inicializarPreviewImagens("imageProdutoUpdate", "previewImagensUpdate", "imagemPrincipalIndexUpdate");
});
