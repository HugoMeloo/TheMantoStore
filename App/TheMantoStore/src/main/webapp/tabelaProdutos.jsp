<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<tbody>
<c:forEach var="produto" items="${produtos}">
  <tr>
    <td>${produto.id}</td>
    <td>${produto.nomeProduto}</td>
    <td>${produto.preco}</td>
    <td>${produto.qtdEstoque}</td>
    <td>${produto.status ? 'Ativo' : 'Inativo'}</td>
    <td>
      <div class="d-flex gap-2">
        <!-- Botão Alterar -->
        <a class="btn btn-warning" href="#"
           onclick="modalManager.abrirModalAtualizarProduto({
                   id: '${produto.id}',
                   nomeProduto: '${produto.nomeProduto}',
                   avaliacao: '${produto.avaliacao}',
                   qtdEstoque: '${produto.qtdEstoque}',
                   preco: '${produto.preco}'
                   })">Alterar</a>

        <!-- Botão Visualizar -->
        <button class="btn btn-success"
          ${tipoUsuario ne 'admin' ? 'disabled' : ''}
                onclick="mostrarDetalhes('${produto.id}', '${produto.nomeProduto}', '${produto.preco}', '${produto.avaliacao}', '${produto.descricao}', '${produto.imagens[0].caminhoArquivo}')">
          Visualizar
        </button>

        <!-- Switch de Status -->
        <form id="statusForm-${produto.id}" action="/AlterarStatusProduto"
              method="post" class="d-flex align-items-center">

          <input type="hidden" name="id" value="${produto.id}">
          <input type="hidden" name="page" value="${currentPage}">
          <input type="hidden" id="statusHidden-${produto.id}" name="status"
                 value="${produto.status ? 'true' : 'false'}">

          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox"
                   id="statusSwitch-${produto.id}"
                   data-nome-produto="${produto.nomeProduto}"
              ${produto.status ? 'checked' : ''}
              ${tipoUsuario ne 'admin' ? 'disabled' : ''}>
            <label class="form-check-label fw-bold ms-2"
                   for="statusSwitch-${produto.id}">
                ${produto.status ? 'Ativo' : 'Inativo'}
            </label>
          </div>
        </form>
      </div>
    </td>
  </tr>
</c:forEach>
</tbody>

