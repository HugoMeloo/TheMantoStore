package br.com.themanto.servlet;

import dao.UsersDao;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/AlterarGrupoUsuario")
public class AlterarGrupoUsuarioServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailLogado = (String) session.getAttribute("email");

        String userId = request.getParameter("idUser");
        String novoGrupo = request.getParameter("grupo");

        // Busca usuário pelo ID
        Users usuario = usersDao.findUserById(userId);
        if (usuario == null || usuario.getEmail().equals(emailLogado)) {
            request.setAttribute("errorMessage", "❌ Não é permitido alterar o próprio grupo.");
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            return;
        }

        // Atualiza o grupo
        boolean sucesso = usersDao.updateUserGroup(userId, novoGrupo);
        if (sucesso) {
            response.sendRedirect("ExibirUsuarios?success=grupoAlterado");
        } else {
            request.setAttribute("errorMessage", "Erro ao alterar grupo.");
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
        }
    }
}
