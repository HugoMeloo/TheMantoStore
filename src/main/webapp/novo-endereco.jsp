<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String idUser = request.getParameter("idUser");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Cadastro de Endereço - The Manto Store</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .address-card {
      border-left: 4px solid #0d6efd;
      transition: all 0.3s ease;
    }
    .address-card:hover {
      box-shadow: 0 0.5rem 1.2rem rgba(0,0,0,.1);
    }
    .form-label {
      font-weight: 500;
      color: #495057;
    }
    .btn-primary {
      background-color: #0d6efd;
      border: none;
      padding: 10px 25px;
      font-weight: 500;
      transition: all 0.3s;
    }
    .btn-primary:hover {
      background-color: #0b5ed7;
      transform: translateY(-2px);
    }
    .header-icon {
      font-size: 2rem;
      color: #0d6efd;
      margin-bottom: 1rem;
    }
    .input-group-text {
      background-color: #f8f9fa;
    }
    .form-control:focus {
      border-color: #86b7fe;
      box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }
    .navbar {
      background-color: #343a40 !important;
    }
    .search-input {
      background-color: rgba(255, 255, 255, 0.1);
      border-color: rgba(255, 255, 255, 0.3);
      color: white;
    }
    .search-input::placeholder {
      color: rgba(255, 255, 255, 0.6);
    }
    .search-input:focus {
      background-color: rgba(255, 255, 255, 0.2);
      color: white;
      border-color: rgba(255, 255, 255, 0.5);
      box-shadow: 0 0 0 0.25rem rgba(255, 255, 255, 0.1);
    }
    .cart-count {
      position: absolute;
      top: -5px;
      right: -5px;
      background-color: #dc3545;
      color: white;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      font-size: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
  </style>
</head>
<body class="bg-light">

<!-- NAV Padrão IDÊNTICA ao index.jsp -->
<!-- NAV Padrão IDÊNTICA ao index.jsp -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4" style="background-color: #343a40 !important;">
  <div class="container">
    <a class="navbar-brand" href="/">
      <i class="fas fa-tshirt me-2"></i>The Manto Store
    </a>
    <div class="d-flex align-items-center">
      <% if (session.getAttribute("usuario") != null) { %>
        <a href="/minhaConta" class="btn btn-outline-light me-2">
          <i class="fas fa-user-cog"></i>
          <span class="d-none d-lg-inline ms-1">Minha Conta</span>
        </a>
        <a href="/logout" class="btn btn-outline-light me-2">
          <i class="fas fa-sign-out-alt"></i>
          <span class="d-none d-lg-inline ms-1">Sair</span>
        </a>
      <% } else { %>
        <a href="/login" class="btn btn-outline-light me-2">
          <i class="fas fa-user"></i>
          <span class="d-none d-lg-inline ms-1">Conta</span>
        </a>
      <% } %>

      <a href="/carrinho" class="btn btn-outline-light position-relative">
        <i class="fas fa-shopping-cart"></i>
        <span class="d-none d-lg-inline ms-1">Carrinho</span>
        <% if (session.getAttribute("carrinho") != null && ((java.util.List<?>)session.getAttribute("carrinho")).size() > 0) { %>
          <span class="cart-count"><%= ((java.util.List<?>)session.getAttribute("carrinho")).size() %></span>
        <% } %>
      </a>
    </div>
  </div>
</nav>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="card border-0 address-card">
        <div class="card-body p-4 p-md-5">
          <div class="text-center">
            <i class="fas fa-map-marker-alt header-icon"></i>
            <h2 class="mb-4 fw-bold text-primary">Cadastro de Endereço</h2>
            <p class="text-muted mb-4">Preencha os dados do endereço de entrega</p>
          </div>

          <form action="/novoEndereco" method="post">
            <input type="hidden" name="idUser" value="<%= idUser %>">

            <div class="mb-4">
              <div class="d-flex align-items-center mb-3">
                <div class="bg-primary rounded-circle p-2 me-3">
                  <i class="fas fa-truck text-white"></i>
                </div>
                <h4 class="mb-0 text-dark">Endereço de Entrega</h4>
              </div>

              <div class="row g-3">
                <div class="col-md-4">
                  <label for="cep_entrega" class="form-label">CEP</label>
                  <div class="input-group">
                    <input type="text" class="form-control" id="cep_entrega" name="cep_entrega" maxlength="9" required placeholder="00000-000">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                  </div>
                </div>

                <div class="col-md-8">
                  <label for="logradouro_entrega" class="form-label">Logradouro</label>
                  <input type="text" class="form-control" id="logradouro_entrega" name="logradouro_entrega" required placeholder="Rua, Avenida, etc.">
                </div>

                <div class="col-md-4">
                  <label for="numero_entrega" class="form-label">Número</label>
                  <input type="text" class="form-control" id="numero_entrega" name="numero_entrega" required placeholder="Nº">
                </div>

                <div class="col-md-8">
                  <label for="complemento_entrega" class="form-label">Complemento</label>
                  <input type="text" class="form-control" id="complemento_entrega" name="complemento_entrega" placeholder="Apto, Bloco, etc.">
                </div>

                <div class="col-md-6">
                  <label for="bairro_entrega" class="form-label">Bairro</label>
                  <input type="text" class="form-control" id="bairro_entrega" name="bairro_entrega" required>
                </div>

                <div class="col-md-4">
                  <label for="cidade_entrega" class="form-label">Cidade</label>
                  <input type="text" class="form-control" id="cidade_entrega" name="cidade_entrega" required>
                </div>

                <div class="col-md-2">
                  <label for="uf_entrega" class="form-label">UF</label>
                  <input type="text" class="form-control text-uppercase" id="uf_entrega" name="uf_entrega" maxlength="2" required>
                </div>
              </div>
            </div>

            <div class="text-center mt-4">
              <button type="submit" class="btn btn-primary btn-lg">
                <i class="fas fa-save me-2"></i>Salvar Endereço
              </button>
            </div>
          </form>
        </div>
      </div>
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