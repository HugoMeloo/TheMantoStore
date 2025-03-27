/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2025-03-27 06:43:07 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class detalhe_002dproduto_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<head>\r\n");
      out.write("    \r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Detalhes do Produto</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\">\r\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("    <style>\r\n");
      out.write("        .thumbnail img {\r\n");
      out.write("            width: 80px;\r\n");
      out.write("            cursor: pointer;\r\n");
      out.write("            border: 2px solid transparent;\r\n");
      out.write("        }\r\n");
      out.write("        .thumbnail img.active {\r\n");
      out.write("            border: 2px solid red;\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<!-- Navbar -->\r\n");
      out.write("<nav class=\"navbar navbar-dark bg-dark\">\r\n");
      out.write("    <div class=\"container d-flex justify-content-between align-items-center\">\r\n");
      out.write("        <a class=\"navbar-brand\" href=\"lista-produto.jsp\">The Manto Store</a>\r\n");
      out.write("        <form class=\"d-flex w-50\">\r\n");
      out.write("            <div class=\"input-group\">\r\n");
      out.write("                <input type=\"text\" id=\"filtroNome\" class=\"form-control rounded-pill ps-2\" placeholder=\"O que você procura?\" onkeyup=\"filtrarUsuarios()\" style=\"height: 45px;\">\r\n");
      out.write("            </div>\r\n");
      out.write("        </form>\r\n");
      out.write("        <div class=\"d-flex align-items-center\">\r\n");
      out.write("            <a href=\"/usuarios\" class=\"me-3\">\r\n");
      out.write("                <img src=\"img/user.png\" alt=\"Usuário\" style=\"width: 30px; height: 30px;\">\r\n");
      out.write("            </a>\r\n");
      out.write("            <a href=\"/carrinho\" class=\"me-3\">\r\n");
      out.write("                <img src=\"img/carrinho.png\" alt=\"Carrinho\" style=\"width: 30px; height: 30px;\">\r\n");
      out.write("            </a>\r\n");
      out.write("            <a href=\"/logout\" class=\"btn btn-danger\">Sair</a>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</nav>\r\n");
      out.write("\r\n");
      out.write("<div class=\"container mt-4\">\r\n");
      out.write("    <div class=\"row\">\r\n");
      out.write("        <!--\r\n");
      out.write("        <div class=\"col-md-6\">\r\n");
      out.write("             Carrossel estilo Americanas\r\n");
      out.write("            <div class=\"text-center\">\r\n");
      out.write("                <img id=\"mainImage\" src=\"\" class=\"img-fluid\" alt=\"\">\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"d-flex justify-content-center mt-2 thumbnail\">\r\n");
      out.write("                <img src=\"\" class=\"me-2 active\" onclick=\"changeImage(this)\">\r\n");
      out.write("\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        -->\r\n");
      out.write("\r\n");
      out.write("        <div class=\"col-md-6\">\r\n");
      out.write("            <h2>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produtos.nomeProduto}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</h2>\r\n");
      out.write("            <p>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produtos.descricao}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</p>\r\n");
      out.write("            <h4 class=\"text-success\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produtos.preco}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(" no Pix</h4>\r\n");
      out.write("            <p class=\"text-muted\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produtos.preco}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(" em até 8x de ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produtos.preco}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</p>\r\n");
      out.write("            <button class=\"btn btn-secondary\" disabled>Comprar</button>\r\n");
      out.write("            <a href=\"carrinho.jsp\">Adicionar ao Carrinho</a>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    function changeImage(element) {\r\n");
      out.write("        document.getElementById(\"mainImage\").src = element.src;\r\n");
      out.write("        let thumbnails = document.querySelectorAll(\".thumbnail img\");\r\n");
      out.write("        thumbnails.forEach(img => img.classList.remove(\"active\"));\r\n");
      out.write("        element.classList.add(\"active\");\r\n");
      out.write("    }\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
