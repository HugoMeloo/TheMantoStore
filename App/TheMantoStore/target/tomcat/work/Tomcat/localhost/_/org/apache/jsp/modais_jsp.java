/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2025-03-21 01:28:03 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class modais_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"pt-br\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("  <meta charset=\"UTF-8\"/>\r\n");
      out.write("  \r\n");
      out.write("  <link href=\"/webjars/bootstrap/5.3.3/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<!-- Modal de Detalhes do Produto -->\r\n");
      out.write("<div class=\"modal fade\" id=\"detalheProdutoModal\" tabindex=\"-1\" aria-labelledby=\"detalheProdutoModalLabel\" aria-hidden=\"true\">\r\n");
      out.write("  <div class=\"modal-dialog modal-dialog-centered modal-lg\">\r\n");
      out.write("    <div class=\"modal-content bg-dark text-white shadow-lg rounded-4\">\r\n");
      out.write("      <div class=\"modal-header border-0\">\r\n");
      out.write("        <h5 class=\"modal-title fw-bold\" id=\"detalheProdutoModalLabel\">Detalhes do Produto</h5>\r\n");
      out.write("        <button type=\"button\" class=\"btn-close btn-close-white\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-body\">\r\n");
      out.write("        <div class=\"row align-items-center\">\r\n");
      out.write("          <div class=\"col-md-5 text-center\">\r\n");
      out.write("            <img id=\"produtoImagem\" src=\"https://via.placeholder.com/350\" class=\"img-fluid rounded-3 shadow-sm\" alt=\"Imagem do Produto\">\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"col-md-7\">\r\n");
      out.write("            <h3 id=\"produtoNome\" class=\"fw-bold text-uppercase\"></h3>\r\n");
      out.write("            <p class=\"text-muted\">ID: <span id=\"produtoId\"></span></p>\r\n");
      out.write("            <p class=\"fs-5\"><strong>Preço:</strong> <span class=\"text-success fw-bold\">R$ <span id=\"produtoPreco\"></span></span></p>\r\n");
      out.write("            <p class=\"fs-5\"><strong>Avaliação:</strong> <span id=\"produtoAvaliacao\"></span> ⭐</p>\r\n");
      out.write("            <p><strong>Descrição:</strong></p>\r\n");
      out.write("            <p id=\"produtoDescricao\" class=\"text-white\"></p>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-footer border-0\">\r\n");
      out.write("        <button type=\"button\" class=\"btn btn-outline-light px-4 rounded-pill\" data-bs-dismiss=\"modal\">Fechar</button>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<!-- Modal Genérico de Confirmação com informações detalhadas do produto -->\r\n");
      out.write("<div class=\"modal fade\" id=\"confirmModal\" tabindex=\"-1\"\r\n");
      out.write("     aria-labelledby=\"confirmModalLabel\" aria-hidden=\"true\">\r\n");
      out.write("  <div class=\"modal-dialog\">\r\n");
      out.write("    <div class=\"modal-content\">\r\n");
      out.write("      <div class=\"modal-header\">\r\n");
      out.write("        <h5 class=\"modal-title\" id=\"confirmModalLabel\">Confirmação de Alteração</h5>\r\n");
      out.write("        <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-body\">\r\n");
      out.write("        <p>\r\n");
      out.write("          O produto <strong id=\"modalNomeProduto\"></strong> (ID: <strong id=\"modalProdutoIdTexto\"></strong>) está atualmente\r\n");
      out.write("          <strong id=\"modalStatusAtual\"></strong>.\r\n");
      out.write("        </p>\r\n");
      out.write("        <p>\r\n");
      out.write("          Deseja realmente <strong id=\"modalNovoStatus\"></strong> este produto?\r\n");
      out.write("        </p>\r\n");
      out.write("\r\n");
      out.write("        <!-- Campos ocultos usados pelo JavaScript -->\r\n");
      out.write("        <input type=\"hidden\" id=\"modalProdutoId\">\r\n");
      out.write("        <input type=\"hidden\" id=\"modalStatus\">\r\n");
      out.write("        <input type=\"hidden\" id=\"modalCurrentPage\">\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-footer\">\r\n");
      out.write("        <button type=\"button\" id=\"cancelAction\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">\r\n");
      out.write("          Cancelar\r\n");
      out.write("        </button>\r\n");
      out.write("        <button type=\"button\" id=\"confirmAction\" class=\"btn btn-primary\">\r\n");
      out.write("          Confirmar\r\n");
      out.write("        </button>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- Modal para Cadastro de Produto -->\r\n");
      out.write("<div class=\"modal fade\" id=\"cadastrarProdutoModal\" tabindex=\"-1\" aria-labelledby=\"cadastrarProdutoModalLabel\" aria-hidden=\"true\">\r\n");
      out.write("  <div class=\"modal-dialog\">\r\n");
      out.write("    <div class=\"modal-content p-4\">\r\n");
      out.write("      <div class=\"modal-header\">\r\n");
      out.write("        <h5 class=\"modal-title\" id=\"cadastrarProdutoModalLabel\">Cadastrar Produto</h5>\r\n");
      out.write("        <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-body\">\r\n");
      out.write("        <form action=\"/CadastrarProduto\" method=\"post\" enctype=\"multipart/form-data\">\r\n");
      out.write("          <input type=\"hidden\" name=\"id\" id=\"id\"\r\n");
      out.write("                 value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${param.id != null && param.id != '' ? param.id : 0}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"produto-name\">Nome do Produto:</label>\r\n");
      out.write("            <input type=\"text\" class=\"form-control\" id=\"produto-name\" name=\"produto-name\"\r\n");
      out.write("                   maxlength=\"255\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"avaliacao\">Avaliação:</label>\r\n");
      out.write("            <input type=\"number\" step=\"0.5\" min=\"0.5\" max=\"5\" class=\"form-control\"\r\n");
      out.write("                   id=\"avaliacao\" name=\"avaliacao\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"descricao\">Descrição (até 2000 caracteres):</label>\r\n");
      out.write("            <textarea class=\"form-control\" id=\"descricao\" name=\"descricao\" maxlength=\"2000\"\r\n");
      out.write("                      required></textarea>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"preco\">Preço:</label>\r\n");
      out.write("            <input type=\"number\" step=\"0.01\" class=\"form-control\" id=\"preco\" name=\"preco\"\r\n");
      out.write("                   required>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"qtdEstoque\">Quantidade Estoque:</label>\r\n");
      out.write("            <input type=\"number\" class=\"form-control\" id=\"qtdEstoque\" name=\"qtdEstoque\"\r\n");
      out.write("                   required>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label for=\"imageProduto\">Imagens:</label>\r\n");
      out.write("            <input type=\"file\" class=\"form-control\" name=\"imageProduto\" id=\"imageProduto\"\r\n");
      out.write("                   multiple required>\r\n");
      out.write("            <small>Selecione múltiplas imagens</small>\r\n");
      out.write("          </div>\r\n");
      out.write("          <button type=\"submit\" class=\"btn btn-primary mt-3\">Cadastrar</button>\r\n");
      out.write("          <button type=\"button\" class=\"btn btn-secondary mt-3\"\r\n");
      out.write("                  onclick=\"window.location.href='/ExibirProdutos'\">Cancelar\r\n");
      out.write("          </button>\r\n");
      out.write("        </form>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<!-- Modal Genérico de Atualização de Produto -->\r\n");
      out.write("<div class=\"modal fade\" id=\"updateProdutoModal\" tabindex=\"-1\" aria-labelledby=\"updateProdutoModalLabel\" aria-hidden=\"true\">\r\n");
      out.write("  <div class=\"modal-dialog\">\r\n");
      out.write("    <div class=\"modal-content p-4\">\r\n");
      out.write("      <div class=\"modal-header\">\r\n");
      out.write("        <h5 class=\"modal-title\">Atualizar Produto</h5>\r\n");
      out.write("        <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\"></button>\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"modal-body\">\r\n");
      out.write("        <form action=\"/CadastrarProduto\" method=\"post\" enctype=\"multipart/form-data\">\r\n");
      out.write("          <input type=\"hidden\" name=\"id\" id=\"updateProdutoId\">\r\n");
      out.write("\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label>Nome do Produto:</label>\r\n");
      out.write("            <input type=\"text\" class=\"form-control\" id=\"updateProdutoNome\" name=\"produto-name\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label>Avaliação:</label>\r\n");
      out.write("            <input type=\"number\" step=\"0.5\" min=\"0.5\" max=\"5\" class=\"form-control\"\r\n");
      out.write("                   id=\"updateProdutoAvaliacao\" name=\"avaliacao\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label>Quantidade Estoque:</label>\r\n");
      out.write("            <input type=\"number\" class=\"form-control\"\r\n");
      out.write("                   id=\"updateProdutoQtdEstoque\" name=\"qtdEstoque\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label>Preço Unitário (R$):</label>\r\n");
      out.write("            <input type=\"text\" class=\"form-control\" id=\"updateProdutoPreco\" name=\"preco\" required>\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("          <div class=\"form-group\">\r\n");
      out.write("            <label>Selecionar novas imagens (opcional):</label>\r\n");
      out.write("            <input type=\"file\" class=\"form-control\" name=\"imagemProduto\" multiple>\r\n");
      out.write("            <small class=\"text-muted\">As novas imagens substituirão as antigas.</small>\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("          <button type=\"submit\" class=\"btn btn-primary mt-3\">Atualizar</button>\r\n");
      out.write("        </form>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <script src=\"../js/feather.min.js\"></script>\r\n");
      out.write("  <script src=\"https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js\"></script>\r\n");
      out.write("  <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("  <script src=\"../js/drop.js\"></script>\r\n");
      out.write("  <script src=\"/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("  </body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
