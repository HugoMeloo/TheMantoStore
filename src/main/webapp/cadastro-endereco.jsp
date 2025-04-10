<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String idUser = request.getParameter("idUser");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Endereço</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5 mb-5">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="mb-4 text-center">Cadastro de Endereço</h3>
            <form action="/salvar-endereco" method="post">
                <input type="hidden" name="idUser" value="<%= idUser %>">

                <h5>Endereço de Faturamento</h5>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label>CEP</label>
                        <input type="text" class="form-control" id="cep_faturamento" name="cep_faturamento" maxlength="9" required>
                    </div>
                    <div class="col-md-8">
                        <label>Logradouro</label>
                        <input type="text" class="form-control" id="logradouro_faturamento" name="logradouro_faturamento" required>
                    </div>
                    <div class="col-md-4 mt-3">
                        <label>Número</label>
                        <input type="text" class="form-control" id="numero_faturamento" name="numero_faturamento" required>
                    </div>
                    <div class="col-md-8 mt-3">
                        <label>Complemento</label>
                        <input type="text" class="form-control" id="complemento_faturamento" name="complemento_faturamento">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label>Bairro</label>
                        <input type="text" class="form-control" id="bairro_faturamento" name="bairro_faturamento" required>
                    </div>
                    <div class="col-md-4 mt-3">
                        <label>Cidade</label>
                        <input type="text" class="form-control" id="cidade_faturamento" name="cidade_faturamento" required>
                    </div>
                    <div class="col-md-2 mt-3">
                        <label>UF</label>
                        <input type="text" class="form-control" id="uf_faturamento" name="uf_faturamento" maxlength="2" required>
                    </div>
                </div>

                <hr>

                <div class="form-check mb-4">
                    <input type="checkbox" class="form-check-input" id="mesmoEndereco" onclick="copiarEndereco()">
                    <label class="form-check-label" for="mesmoEndereco">Usar mesmo endereço para entrega</label>
                </div>

                <h5>Endereço de Entrega</h5>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label>CEP</label>
                        <input type="text" class="form-control" id="cep_entrega" name="cep_entrega" maxlength="9" required>
                    </div>
                    <div class="col-md-8">
                        <label>Logradouro</label>
                        <input type="text" class="form-control" id="logradouro_entrega" name="logradouro_entrega" required>
                    </div>
                    <div class="col-md-4 mt-3">
                        <label>Número</label>
                        <input type="text" class="form-control" id="numero_entrega" name="numero_entrega" required>
                    </div>
                    <div class="col-md-8 mt-3">
                        <label>Complemento</label>
                        <input type="text" class="form-control" id="complemento_entrega" name="complemento_entrega">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label>Bairro</label>
                        <input type="text" class="form-control" id="bairro_entrega" name="bairro_entrega" required>
                    </div>
                    <div class="col-md-4 mt-3">
                        <label>Cidade</label>
                        <input type="text" class="form-control" id="cidade_entrega" name="cidade_entrega" required>
                    </div>
                    <div class="col-md-2 mt-3">
                        <label>UF</label>
                        <input type="text" class="form-control" id="uf_entrega" name="uf_entrega" maxlength="2" required>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary mt-3 px-5">Salvar Endereços</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var camposCep = ['cep_faturamento', 'cep_entrega'];

        camposCep.forEach(function(id) {
            var campo = document.getElementById(id);
            if (campo) {
                campo.addEventListener('blur', function () {
                    setTimeout(function () {
                        var cepLimpo = campo.value.replace(/\D/g, '');
                        var tipo = campo.id.split('_')[1];

                        console.log("✔️ Tipo identificado: " + tipo);
                        console.log("✔️ CEP informado: " + cepLimpo);

                        if (cepLimpo.length === 8) {
                            buscarCepViaCep(cepLimpo, tipo);
                        } else {
                            console.warn("CEP inválido (" + cepLimpo + ") no campo " + campo.id);
                        }
                    }, 10);
                });
            }
        });
    });

    function buscarCepViaCep(valorCep, tipoEndereco) {
        console.log("🚨 DEBUG CEP: " + valorCep);
        console.log("🚨 DEBUG TIPO: " + tipoEndereco);

        var url = "https://viacep.com.br/ws/" + valorCep + "/json/";
        console.log("🟡 URL gerada: " + url);

        fetch(url)
            .then(function(response) {
                if (!response.ok) throw new Error("Resposta inválida da API");
                return response.json();
            })
            .then(function(data) {
                if (data.erro) {
                    alert("CEP não encontrado.");
                    return;
                }

                var logradouro = document.getElementById("logradouro_" + tipoEndereco);
                var bairro     = document.getElementById("bairro_" + tipoEndereco);
                var cidade     = document.getElementById("cidade_" + tipoEndereco);
                var uf         = document.getElementById("uf_" + tipoEndereco);

                if (!logradouro || !bairro || !cidade || !uf) {
                    console.error("❌ Um ou mais campos não foram encontrados no DOM.");
                    return;
                }

                logradouro.value = data.logradouro || '';
                bairro.value     = data.bairro     || '';
                cidade.value     = data.localidade || '';
                uf.value         = data.uf         || '';

                console.log("✅ Endereço preenchido para " + tipoEndereco);
            })
            .catch(function(error) {
                console.error("❌ Erro ao buscar o CEP:", error);
                alert("Erro ao buscar o CEP.");
            });
    }

    function copiarEndereco() {
        var mesmoEndereco = document.getElementById("mesmoEndereco");
        if (!mesmoEndereco.checked) return;

        var campos = ["cep", "logradouro", "numero", "complemento", "bairro", "cidade", "uf"];

        campos.forEach(function(campo) {
            var origem = document.getElementById(campo + "_faturamento");
            var destino = document.getElementById(campo + "_entrega");

            if (origem && destino) {
                destino.value = origem.value;
            }
        });

        console.log("📋 Endereço de faturamento copiado para entrega");
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
