<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Configurações do Usuário</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .section-title {
      font-weight: bold;
      font-size: 1.25rem;
      margin-bottom: 1rem;
    }
    .card-title {
      font-weight: bold;
    }
    .card-destaque {
      background-color: #fff3e0;
      border: 1px solid #ff9800;
    }
    .endereco-acao a {
      font-weight: bold;
      margin-right: 10px;
    }
    .icone {
      color: #ff9800;
      margin-right: 6px;
    }
  </style>
</head>
<body>
<div class="container py-5">
  <div class="row g-4">
    <!-- Dados Básicos -->
    <div class="col-lg-6">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="section-title">
            <i class="fas fa-clipboard-list icone"></i> DADOS BÁSICOS
          </h5>

          <div class="d-flex gap-2 mb-3">
            <button class="btn btn-outline-warning w-50">ALTERAR E-MAIL</button>
            <button class="btn btn-outline-warning w-50">ALTERAR SENHA</button>
          </div>

          <form>
            <div class="mb-3">
              <label>Nome completo*</label>
              <input type="text" class="form-control" value="${usuarioLogado.nome}" required>
            </div>
            <div class="mb-3">
              <label>Telefone celular*</label>
              <input type="text" class="form-control" value="${usuarioLogado.telefone}" required>
            </div>
            <div class="mb-3">
              <label>Gênero**</label>
              <select class="form-select">
                <option ${usuarioLogado.genero eq 'Homem' ? 'selected' : ''}>Homem</option>
                <option ${usuarioLogado.genero eq 'Mulher' ? 'selected' : ''}>Mulher</option>
                <option ${usuarioLogado.genero eq 'Outros' ? 'selected' : ''}>Outros</option>
                <option ${usuarioLogado.genero eq 'Nao especificar' ? 'selected' : ''}>Não especificar</option>
              </select>
            </div>
            <div class="mb-3">
              <label>E-mail</label>
              <input type="email" class="form-control" value="${usuarioLogado.email}" disabled>
            </div>
            <div class="mb-3">
              <label>CPF</label>
              <input type="text" class="form-control" value="${usuarioLogado.cpf}" disabled>
            </div>
            <div class="mb-3">
              <label>Data de nascimento</label>
              <input type="text" class="form-control" value="${usuarioLogado.dataNascimento}" disabled>
            </div>

            <div class="form-check mt-4">
              <input class="form-check-input" type="checkbox" id="ofertas" checked>
              <label class="form-check-label" for="ofertas">
                Quero receber ofertas e novidades por e-mail, SMS, WhatsApp ou mensagens nos apps
              </label>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Endereços -->
    <div class="col-lg-6">
      <div class="card shadow-sm">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="section-title">
              <i class="fas fa-map-marker-alt icone"></i> ENDEREÇOS
            </h5>
            <a href="/cadastrar-endereco.jsp" class="text-decoration-none fw-bold text-warning">+ CADASTRAR NOVO ENDEREÇO</a>
          </div>

          <c:forEach var="end" items="${usuarioLogado.enderecos}">
            <div class="card mb-3 ${end.padrao ? 'card-destaque' : ''}">
              <div class="card-body">
                <h6 class="fw-bold">${end.apelido} <c:if test="${end.padrao}"><span class="text-warning">(PADRÃO)</span></c:if></h6>
                <p class="mb-1">${end.logradouro}</p>
                <p class="mb-1">Número: ${end.numero}, ${end.complemento}</p>
                <p class="mb-2">CEP ${end.cep} - ${end.cidade}, ${end.uf}</p>
                <div class="endereco-acao d-flex justify-content-end">
                  <c:if test="${not end.padrao}">
                    <a href="/excluir-endereco?id=${end.id}" class="text-muted">EXCLUIR</a>
                  </c:if>
                  <a href="/editar-endereco?id=${end.id}" class="text-muted">EDITAR</a>
                  <c:if test="${not end.padrao}">
                    <a href="/definir-endereco-padrao?id=${end.id}" class="text-warning">DEIXAR PADRÃO</a>
                  </c:if>
                </div>
              </div>
            </div>
          </c:forEach>

        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://kit.fontawesome.com/a2d0d6d72b.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
