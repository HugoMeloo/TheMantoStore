package br.com.themanto.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/redirecionar")
public class RedirecionarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession sessao = request.getSession(false);

        if (sessao == null || sessao.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String opcao = request.getParameter("opcao");

        switch (opcao) {
            case "1":
                response.sendRedirect("/ExibirProdutos");
                break;
            case "2":
                response.sendRedirect("/admin/ExibirUsuarios");
                break;
            default:
                response.sendRedirect("escolha.jsp");
                break;
        }
    }
}
