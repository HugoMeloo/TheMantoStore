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
        System.out.println(senhaHash);
        Users usuario = usersDao.searchUsers(email, senhaHash);

        // Define a origem para o JSP diferenciar os erros
        req.setAttribute("origin", "login");

        if (usuario != null) {
            System.out.println("✅ Usuário encontrado: " + usuario.getEmail());
            System.out.println("🔹 Grupo do usuário: " + usuario.getGrupo());
            System.out.println("🔹 Status do usuário: " + usuario.isStatus());

            if (usuario.isStatus()) {
                System.out.println("✅ Usuário está ativo.");

                // Verifica se o grupo é "adm" ou "est"
                if ("adm".equals(usuario.getGrupo()) || "est".equals(usuario.getGrupo())) {
                    System.out.println("✅ Usuário tem permissão de acesso.");

                    HttpSession session = req.getSession();
                    session.setAttribute("usuario", usuario);
                    resp.sendRedirect("backoffice.jsp");
                    return;
                } else {
                    System.out.println("❌ Acesso negado: Usuário não pertence a 'adm' ou 'est'.");
                    req.setAttribute("errorMessage", "Acesso negado para clientes.");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    return;
                }
            } else {
                System.out.println("❌ Usuário está inativo.");
                req.setAttribute("errorMessage", "Usuário inativo.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }
        } else {
            System.out.println("❌ Usuário ou senha inválidos.");
            req.setAttribute("errorMessage", "Usuário ou senha inválidos.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
