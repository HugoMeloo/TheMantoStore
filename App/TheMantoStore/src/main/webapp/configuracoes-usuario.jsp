<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Configurações do Usuário</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #121212;
      color: #ffffff;
    }
    .card {
      background-color: #1e1e1e;
      border: none;
      margin-bottom: 2rem;
    }
    .form-control,
    .form-select {
      background-color: #2c2c2c;
      color: #ffffff;
      border-color: #444;
    }
    .form-control:disabled,
    .form-select:disabled {
      background-color: #2c2c2c;
      color: #aaa;
    }
    .form-check-label,
    label {
      color: #ccc;
    }
    .btn-outline-warning {
      border-color: #ff9800;
      color: #ff9800;
    }
    .btn-outline-warning:hover {
      background-color: #ff9800;
      color: #121212;
    }
    .section-title {
      font-size: 1.4rem;
      font-weight: 600;
      color: #ff9800;
      margin-bottom: 1.5rem;
    }
    .card-destaque {
      background-color: #2b1c00;
      border: 1px solid #ff9800;
    }
    .endereco-acao a {
      font-weight: bold;
      margin-right: 10px;
      color: #ccc;
    }
    .endereco-acao a.text-warning {
      color: #ff9800;
    }
    .endereco-acao a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="container py-5">

  <!-- Dados Básicos -->
  <div class="card shadow-sm">
    <div class="card-body">
      <h5 class="section-title"><i class="fas fa-user"></i> Dados do Perfil</h5>

      <div class="row g-2 mb-4">
        <div class="col-md-6">
          <button class="btn btn-outline-warning w-100">Alterar E-mail</button>
        </div>
        <div class="col-md-6">
          <button class="btn btn-outline-warning w-100">Alterar Senha</button>
        </div>
      </div>

      <form>
        <div class="row g-3">
          <div class="col-md-6">
            <label>Nome completo*</label>
            <input type="text" class="form-control" value="${usuarioLogado.nome}" required>
          </div>
          <div class="col-md-6">
            <label>Telefone celular*</label>
            <input type="text" class="form-control" value="${usuarioLogado.telefone}" required>
          </div>
          <div class="col-md-6">
            <label>Gênero**</label>
            <select class="form-select">
              <option ${usuarioLogado.genero eq 'Homem' ? 'selected' : ''}>Homem</option>
              <option ${usuarioLogado.genero eq 'Mulher' ? 'selected' : ''}>Mulher</option>
              <option ${usuarioLogado.genero eq 'Outros' ? 'selected' : ''}>Outros</option>
              <option ${usuarioLogado.genero eq 'Nao especificar' ? 'selected' : ''}>Não especificar</option>
            </select>
          </div>
          <div class="col-md-6">
            <label>E-mail</label>
            <input type="email" class="form-control" value="${usuarioLogado.email}" disabled>
          </div>
          <div class="col-md-6">
            <label>CPF</label>
            <input type="text" class="form-control" value="${usuarioLogado.cpf}" disabled>
          </div>
          <div class="col-md-6">
            <label>Data de nascimento</label>
            <input type="text" class="form-control" value="${usuarioLogado.dataNascimento}" disabled>
          </div>
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

  <!-- Endereços -->
  <div class="card shadow-sm">
    <div class="card-body">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="section-title"><i class="fas fa-map-marker-alt"></i> Endereços Cadastrados</h5>
        <a href="/cadastrar-endereco.jsp" class="text-decoration-none fw-bold text-warning">+ Novo Endereço</a>
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

<script src="https://kit.fontawesome.com/a2d0d6d72b.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
