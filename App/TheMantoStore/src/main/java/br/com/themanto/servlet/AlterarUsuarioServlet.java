package br.com.themanto.servlet;

import dao.UsersDao;
import model.Users;
import utils.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/AlterarUsuario")
public class AlterarUsuarioServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        String confirmSenha = request.getParameter("confirmSenha");

        // Buscar usuário existente
        Users usuarioExistente = usersDao.findUserById(String.valueOf(userId));
        if (usuarioExistente == null) {
            request.setAttribute("errorMessage", "Usuário não encontrado.");
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            return;
        }

        String senhaCriptografada = usuarioExistente.getSenha(); // Mantém a senha original

        // Se uma nova senha foi informada, validar e encriptar
        if (senha != null && !senha.isEmpty()) {
            if (!senha.equals(confirmSenha)) {
                request.setAttribute("errorMessage", "As senhas não correspondem.");
                request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
                return;
            }
            senhaCriptografada = PasswordUtils.hashPassword(senha);
        }

        // Criar novo objeto `Users` com os dados atualizados
        Users usuarioAtualizado = new Users(userId, nome, usuarioExistente.getEmail(), senhaCriptografada, cpf, usuarioExistente.isStatus(), usuarioExistente.getGrupo());

        // Atualizar usuário no banco de dados
        boolean sucesso = usersDao.updateUser(usuarioAtualizado);
        if (sucesso) {
            response.sendRedirect("admin/ExibirUsuarios?success=usuarioAtualizado");
        } else {
            request.setAttribute("errorMessage", "Erro ao atualizar usuário.");
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
        }
    }
}
