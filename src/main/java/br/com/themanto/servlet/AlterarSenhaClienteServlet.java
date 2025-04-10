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

@WebServlet("/novaSenhaCliente")
public class AlterarSenhaClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Users usuarioLogado = (Users) session.getAttribute("usuario");
        int idUser = usuarioLogado.getIdUser();

        String novaSenha = req.getParameter("novaSenha");
        String confirmarSenha = req.getParameter("confirmarSenha");

        if (novaSenha == null || !novaSenha.equals(confirmarSenha)) {
            req.setAttribute("errorMessage", "As senhas não correspondem.");
            req.getRequestDispatcher("/configuracoes-usuario.jsp").forward(req, resp);
        }

        String senhaHash = PasswordUtils.hashPassword(confirmarSenha);

        UsersDao udao = new UsersDao();
        udao.updateUserClientePassword(senhaHash, idUser);



        resp.sendRedirect("/minhaConta");

    }
}
