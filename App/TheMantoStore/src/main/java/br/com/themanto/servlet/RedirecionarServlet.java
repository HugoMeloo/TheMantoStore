package br.com.themanto.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/redirecionar")
public class RedirecionarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sessao = request.getSession(false);

        // Verifica se a sessão existe e se o usuário está autenticado
        if (sessao == null || sessao.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return; // PARA A EXECUÇÃO AQUI
        }

        // Obtém o grupo do usuário da sessão
        String tipoUsuario = (String) sessao.getAttribute("tipoUsuario");

        // Obtém a opção escolhida
        String opcao = request.getParameter("opcao");

        // Estoquista só pode listar produtos
        if ("est".equals(tipoUsuario)) {
            if ("1".equals(opcao)) {
                response.sendRedirect("/ExibirProdutosEstoquista");
            } else {
                response.sendRedirect("escolhaEst.jsp");
            }
            return; // PARA A EXECUÇÃO AQUI
        }

        // Administrador pode escolher entre as opções
        if ("admin".equals(tipoUsuario)) {
            if ("1".equals(opcao)) {
                response.sendRedirect("/admin/ExibirProdutos");
            } else if ("2".equals(opcao)) {
                response.sendRedirect("/admin/ExibirUsuarios");
            } else {
                response.sendRedirect("escolha.jsp");
            }
            return; // PARA A EXECUÇÃO AQUI
        }

        // Se por algum motivo o tipo de usuário não for reconhecido, redireciona para login
        response.sendRedirect("login.jsp");
    }
}
