package br.com.themanto.servlet;

import dao.UsersDao;
import model.Users;
import utils.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("loginEmail");
        String senha = req.getParameter("loginSenha");

        // Encripta a senha antes de validar
        String senhaHash = PasswordUtils.hashPassword(senha);
        Users usuario = usersDao.searchUsers(email, senhaHash);

        // Define a origem para o JSP diferenciar os erros
        req.setAttribute("origin", "login");

        if (usuario != null) {
            if (usuario.isStatus()) { // Verifica se está ativo
                HttpSession session = req.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("tipoUsuario", usuario.getGrupo());

                // Novo trecho: verifica se há parâmetro ?redirect
                String redirect = req.getParameter("redirect");
                System.out.println(redirect);

                if (redirect != null && !redirect.isBlank()) {
                    // Se for uma tentativa de acessar a página diretamente, redireciona para o Servlet
                    if (redirect.contains("/carrinho.jsp")) {
                        redirect = "/carrinho"; // força o uso correto do Servlet
                    }
                    resp.sendRedirect(redirect);
                    return;
                }


                if ("admin".equals(usuario.getGrupo())) {
                    resp.sendRedirect("escolha.jsp");
                } else if ("est".equals(usuario.getGrupo())) {
                    resp.sendRedirect("escolha.jsp"); // ambos vão para o mesmo JSP agora
                } else if ("client".equals(usuario.getGrupo())) {
                    resp.sendRedirect("/"); // ambos vão para o mesmo JSP agora
                }
            } else {
                req.setAttribute("errorMessage", "Usuário inativo.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("errorMessage", "Usuário ou senha inválidos.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
