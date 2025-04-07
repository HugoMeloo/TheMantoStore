package br.com.themanto.servlet;

import dao.UsersDao;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/AlterarStatusUsuario")
public class AlterarStatusUsuarioServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String userId = req.getParameter("id");
        Users usuario = usersDao.findUserById(userId);
        if (usuario != null) {
            boolean novoStatus = !usuario.isStatus();
            boolean sucesso = usersDao.updateUserStatus(usuario.getEmail(), novoStatus);
            if (sucesso) {
                System.out.println("✅ Status do usuário atualizado com sucesso.");
            } else {
                System.out.println("❌ Erro ao atualizar status do usuário.");
            }
        } else {
            System.out.println("⚠ Usuário não encontrado.");
        }

        resp.sendRedirect("/admin/ExibirUsuarios");
    }
}
