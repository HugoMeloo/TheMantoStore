function editarUsuario(id, nome, cpf) {
    document.getElementById('editUserId').value = id;
    document.getElementById('editNome').value = nome;
    document.getElementById('editCpf').value = cpf;

    var modal = new bootstrap.Modal(document.getElementById('editUserModal'));
    modal.show();
}

function filtrarUsuarios() {
    var input = document.getElementById("filtroNome").value.toLowerCase();
    var linhas = document.querySelectorAll("#tabelaUsuarios tbody tr");

    linhas.forEach(function (linha) {
        var nome = linha.cells[0].innerText.toLowerCase();
        linha.style.display = nome.includes(input) ? "" : "none";
    });
}