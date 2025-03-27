document.addEventListener('DOMContentLoaded', function () {
    const inputImagens = document.getElementById('imageProduto');
    const previewContainer = document.getElementById('previewImagens');
    const inputImagemPrincipal = document.getElementById('imagemPrincipalIndex');

    inputImagens.addEventListener('change', function (e) {
        const files = e.target.files;
        previewContainer.innerHTML = '';

        Array.from(files).forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function (event) {
                const col = document.createElement('div');
                col.className = 'text-center';

                const img = document.createElement('img');
                img.src = event.target.result;
                img.className = 'img-thumbnail';
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.objectFit = 'cover';

                const radio = document.createElement('input');
                radio.type = 'radio';
                radio.name = 'imagemPrincipal';
                radio.value = index;
                radio.className = 'form-check-input mt-2';
                radio.onclick = () => {
                    inputImagemPrincipal.value = index;
                };

                if (index === 0) {
                    radio.checked = true;
                    inputImagemPrincipal.value = 0;
                }

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
});
