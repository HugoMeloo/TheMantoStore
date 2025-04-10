// Captura os elementos da interface
const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

// Alterna entre login e cadastro
registerBtn.addEventListener('click', () => {
    container.classList.add("active");
});

loginBtn.addEventListener('click', () => {
    container.classList.remove("active");
});

// Aguarda o carregamento do DOM para ativar a criptografia
document.addEventListener("DOMContentLoaded", function () {
    // Seleciona o formulário de login
    document.querySelector("form[action='/login']").addEventListener("submit", function (e) {
        e.preventDefault(); // Evita o envio padrão do formulário

        let senhaInput = document.getElementById("loginSenha");
        this.submit(); // Envia o formulário com a senha criptografada

    });

    // Seleciona o formulário de cadastro
    document.querySelector("form[action='/create-user']").addEventListener("submit", function (e) {
        e.preventDefault();

        let senhaCadastro = document.getElementById("senhaCadastro");
        this.submit(); // Envia o formulário com a senha criptografada
    });
});

// Função para encriptar a senha usando SHA-256
function sha256(senha) {
    return CryptoJS.SHA256(senha).toString();
}
