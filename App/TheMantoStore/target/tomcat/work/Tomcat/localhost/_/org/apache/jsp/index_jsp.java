/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2025-03-28 14:58:53 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
    _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody.release();
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"pt-BR\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>The Manto Store - Coleção Exclusiva</title>\r\n");
      out.write("\r\n");
      out.write("    <!-- Optimized CSS Loading -->\r\n");
      out.write("    <link rel=\"preload\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" as=\"style\" onload=\"this.onload=null;this.rel='stylesheet'\">\r\n");
      out.write("    <noscript><link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\"></noscript>\r\n");
      out.write("\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/body.css\">\r\n");
      out.write("\r\n");
      out.write("    <style>\r\n");
      out.write("        :root {\r\n");
      out.write("            --primary-color: #e94560;\r\n");
      out.write("            --secondary-color: #16213e;\r\n");
      out.write("            --bg-light: #f4f6f9;\r\n");
      out.write("            --text-dark: #212529;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        body {\r\n");
      out.write("            background-color: var(--bg-light);\r\n");
      out.write("            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;\r\n");
      out.write("            color: var(--text-dark);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-grid {\r\n");
      out.write("            display: grid;\r\n");
      out.write("            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));\r\n");
      out.write("            gap: 1.5rem;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-card {\r\n");
      out.write("            background-color: white;\r\n");
      out.write("            border-radius: 12px;\r\n");
      out.write("            box-shadow: 0 10px 25px rgba(0,0,0,0.08);\r\n");
      out.write("            overflow: hidden;\r\n");
      out.write("            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-card:hover {\r\n");
      out.write("            transform: translateY(-15px);\r\n");
      out.write("            box-shadow: 0 15px 35px rgba(0,0,0,0.15);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-image {\r\n");
      out.write("            position: relative;\r\n");
      out.write("            overflow: hidden;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-image img {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            height: 350px;\r\n");
      out.write("            object-fit: cover;\r\n");
      out.write("            transition: transform 0.5s ease, filter 0.5s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-card:hover .product-image img {\r\n");
      out.write("            transform: scale(1.1);\r\n");
      out.write("            filter: brightness(0.8);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-overlay {\r\n");
      out.write("            position: absolute;\r\n");
      out.write("            bottom: 0;\r\n");
      out.write("            left: 0;\r\n");
      out.write("            right: 0;\r\n");
      out.write("            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);\r\n");
      out.write("            overflow: hidden;\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            height: 0;\r\n");
      out.write("            transition: 0.5s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-card:hover .product-overlay {\r\n");
      out.write("            height: 100%;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-overlay-title {\r\n");
      out.write("            color: white;\r\n");
      out.write("            font-weight: 600;\r\n");
      out.write("            text-transform: uppercase;\r\n");
      out.write("            letter-spacing: 1px;\r\n");
      out.write("            position: absolute;\r\n");
      out.write("            bottom: 20px;\r\n");
      out.write("            left: 20px;\r\n");
      out.write("            opacity: 0;\r\n");
      out.write("            transition: opacity 0.5s;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .product-card:hover .product-overlay-title {\r\n");
      out.write("            opacity: 1;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .section-title {\r\n");
      out.write("            color: var(--secondary-color);\r\n");
      out.write("            font-weight: 700;\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            margin-bottom: 2rem;\r\n");
      out.write("            text-transform: uppercase;\r\n");
      out.write("            letter-spacing: 2px;\r\n");
      out.write("            position: relative;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .section-title::after {\r\n");
      out.write("            content: '';\r\n");
      out.write("            position: absolute;\r\n");
      out.write("            bottom: -10px;\r\n");
      out.write("            left: 50%;\r\n");
      out.write("            transform: translateX(-50%);\r\n");
      out.write("            width: 100px;\r\n");
      out.write("            height: 4px;\r\n");
      out.write("            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        @media (max-width: 768px) {\r\n");
      out.write("            .product-grid {\r\n");
      out.write("                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark\">\r\n");
      out.write("    <div class=\"container\">\r\n");
      out.write("        <a class=\"navbar-brand\" href=\"\">The Manto Store</a>\r\n");
      out.write("\r\n");
      out.write("        <div class=\"d-flex justify-content-between align-items-center w-100\">\r\n");
      out.write("            <form class=\"flex-grow-1 mx-3\">\r\n");
      out.write("                <div class=\"input-group\">\r\n");
      out.write("                    <input type=\"search\" id=\"productSearch\" class=\"form-control rounded-pill\"\r\n");
      out.write("                           placeholder=\"Busque por produtos...\" aria-label=\"Buscar produtos\">\r\n");
      out.write("                </div>\r\n");
      out.write("            </form>\r\n");
      out.write("\r\n");
      out.write("            <div class=\"nav-actions d-flex align-items-center\">\r\n");
      out.write("                <a href=\"/login\" class=\"text-white me-3\" aria-label=\"Perfil do Usuário\">\r\n");
      out.write("                    <i class=\"bi bi-person-fill fs-4\"></i>\r\n");
      out.write("                </a>\r\n");
      out.write("                <a href=\"/carrinho\" class=\"me-3\">\r\n");
      out.write("                    <img src=\"img/carrinho.png\" alt=\"Carrinho\" style=\"width: 30px; height: 30px;\">\r\n");
      out.write("                </a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</nav>\r\n");
      out.write("\r\n");
      out.write("<main class=\"container mt-5\">\r\n");
      out.write("    <h2 class=\"section-title\">Nossa Coleção</h2>\r\n");
      out.write("\r\n");
      out.write("    <div id=\"productGrid\" class=\"product-grid\">\r\n");
      out.write("        ");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("</main>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    document.addEventListener('DOMContentLoaded', function() {\r\n");
      out.write("        const searchInput = document.getElementById('productSearch');\r\n");
      out.write("        const productGrid = document.getElementById('productGrid');\r\n");
      out.write("        const productItems = productGrid.querySelectorAll('.product-item');\r\n");
      out.write("\r\n");
      out.write("        searchInput.addEventListener('input', function() {\r\n");
      out.write("            const searchTerm = this.value.toLowerCase().trim();\r\n");
      out.write("\r\n");
      out.write("            productItems.forEach(item => {\r\n");
      out.write("                const productName = item.dataset.name;\r\n");
      out.write("                const isVisible = productName.includes(searchTerm);\r\n");
      out.write("\r\n");
      out.write("                item.style.display = isVisible ? 'block' : 'none';\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("    });\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<!-- Optional: Bootstrap Icons -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css\">\r\n");
      out.write("\r\n");
      out.write("<!-- Optional: Defer Bootstrap JS -->\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\" defer></script>\r\n");
      out.write("</body>\r\n");
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

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f0.setParent(null);
    // /index.jsp(156,8) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setVar("produto");
    // /index.jsp(156,8) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/index.jsp(156,8) '${produtos}'",_el_expressionfactory.createValueExpression(_jspx_page_context.getELContext(),"${produtos}",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
    int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
      if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("            <div class=\"product-card h-100 product-item\" data-name=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.nomeProduto.toLowerCase()}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("\">\r\n");
          out.write("                <a href=\"/detalha-produto?id=");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.id}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("\" class=\"text-decoration-none\">\r\n");
          out.write("                    <div class=\"product-image\">\r\n");
          out.write("                        <img src=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.imagens[0].caminhoArquivo}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("\" alt=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.nomeProduto}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("\" loading=\"lazy\">\r\n");
          out.write("                        <div class=\"product-overlay\">\r\n");
          out.write("                            <h4 class=\"product-overlay-title\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.nomeProduto}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("</h4>\r\n");
          out.write("                        </div>\r\n");
          out.write("                    </div>\r\n");
          out.write("                    <div class=\"p-3 text-center\">\r\n");
          out.write("                        <h5 class=\"fw-bold mb-2 text-dark\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.nomeProduto}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("</h5>\r\n");
          out.write("                        <p class=\"text-muted mb-3\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.descricao}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("</p>\r\n");
          out.write("                        <div class=\"d-flex justify-content-center align-items-center\">\r\n");
          out.write("                                <span class=\"h5 text-danger mb-0\">\r\n");
          out.write("                                    ");
          if (_jspx_meth_fmt_005fformatNumber_005f0(_jspx_th_c_005fforEach_005f0, _jspx_page_context, _jspx_push_body_count_c_005fforEach_005f0))
            return true;
          out.write("\r\n");
          out.write("                                </span>\r\n");
          out.write("                        </div>\r\n");
          out.write("                    </div>\r\n");
          out.write("                </a>\r\n");
          out.write("            </div>\r\n");
          out.write("        ");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_fmt_005fformatNumber_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fforEach_005f0, javax.servlet.jsp.PageContext _jspx_page_context, int[] _jspx_push_body_count_c_005fforEach_005f0)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatNumber
    org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag _jspx_th_fmt_005fformatNumber_005f0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag) _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag.class);
    _jspx_th_fmt_005fformatNumber_005f0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_005fformatNumber_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fforEach_005f0);
    // /index.jsp(170,36) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_fmt_005fformatNumber_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${produto.preco}", java.lang.Object.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
    // /index.jsp(170,36) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_fmt_005fformatNumber_005f0.setType("currency");
    // /index.jsp(170,36) name = currencyCode type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_fmt_005fformatNumber_005f0.setCurrencyCode("BRL");
    int _jspx_eval_fmt_005fformatNumber_005f0 = _jspx_th_fmt_005fformatNumber_005f0.doStartTag();
    if (_jspx_th_fmt_005fformatNumber_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody.reuse(_jspx_th_fmt_005fformatNumber_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ffmt_005fformatNumber_0026_005fvalue_005ftype_005fcurrencyCode_005fnobody.reuse(_jspx_th_fmt_005fformatNumber_005f0);
    return false;
  }
}
