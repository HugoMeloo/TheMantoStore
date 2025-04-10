<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Configurações do Usuário</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/minhaConta.css">
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

      <form action="/alterar-dados-cliente" method="post">
        <div class="row g-3">
          <div class="col-md-6">
            <label>Nome completo*</label>
            <input type="text" name="nome" class="form-control" value="${dadosPadrao.nome}" required>
          </div>

          <div class="col-md-6">
            <label>Gênero*</label>
            <select name="genero" class="form-select">
              <option ${dadosPessoais.genero eq 'H' ? 'selected' : ''}>Homem</option>
              <option ${dadosPessoais.genero eq 'M' ? 'selected' : ''}>Mulher</option>
              <option ${dadosPessoais.genero eq 'O' ? 'selected' : ''}>Outros</option>
              <option ${dadosPessoais.genero eq 'N' ? 'selected' : ''}>Não especificar</option>
            </select>
          </div>

          <div class="col-md-6">
            <label>E-mail</label>
            <input type="email" class="form-control" value="${dadosPadrao.email}" disabled>
          </div>

          <div class="col-md-6">
            <label>CPF</label>
            <input type="text" class="form-control" value="${dadosPadrao.cpf}" disabled>
          </div>

          <div class="col-md-6">
            <label>Data de nascimento</label>
            <input type="date" name="dataNascimento" class="form-control" value="${dadosPessoais.dataNascimento}">
          </div>
        </div>

        <div class="form-check mt-4">
          <input class="form-check-input" type="checkbox" id="ofertas" checked>
          <label class="form-check-label" for="ofertas">
            Quero receber ofertas e novidades por e-mail, SMS, WhatsApp ou mensagens nos apps
          </label>
        </div>

        <button type="submit" class="btn btn-primary mt-3">Salvar Alterações</button>
      </form>

    </div>
  </div>

  <!-- Endereços -->
  <div class="card shadow-sm">
    <div class="card-body">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="section-title"><i class="fas fa-map-marker-alt"></i> Endereços Cadastrados</h5>
        <a href="/novoEndereco" class="text-decoration-none fw-bold text-warning">+ Novo Endereço</a>
      </div>

      <c:forEach var="end" items="${listaEnderecos}">
        <div class="card mb-3 ${end.padrao ? 'card-destaque' : ''}">
          <div class="card-body">
            <h6 class="fw-bold">${end.tipoEndereco}
              <c:if test="${end.padrao}">
                <span class="text-warning">(PADRÃO)</span>
              </c:if>
            </h6>
            <p class="mb-1">${end.logradouro}</p>
            <p class="mb-1">Número: ${end.numero}, ${end.complemento}</p>
            <p class="mb-2">CEP ${end.cep} - ${end.cidade}, ${end.uf}</p>
            <div class="endereco-acao d-flex justify-content-end">
              <c:if test="${not end.padrao}">
                <a href="/excluir-endereco?id=${end.idEndereco}" class="text-muted">EXCLUIR</a>
              </c:if>
              <a href="/editar-endereco?id=${end.idEndereco}" class="text-muted">EDITAR</a>
              <c:if test="${not end.padrao}">
                <a href="/definir-endereco-padrao?id=${end.idEndereco}" class="text-warning">DEIXAR PADRÃO</a>
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
