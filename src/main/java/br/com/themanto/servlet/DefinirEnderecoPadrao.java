package br.com.themanto.servlet;

import dao.EnderecoDao;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/definir-endereco-padrao")

public class DefinirEnderecoPadrao extends HttpServlet {
    private final EnderecoDao enderecoDao = new EnderecoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users usuario = (Users) session.getAttribute("usuario");

        if (usuario != null) {
            int idEndereco = Integer.parseInt(request.getParameter("id"));
            int idUsuario = usuario.getIdUser();

            enderecoDao.definirEnderecoPadrao(idEndereco, idUsuario);

            response.sendRedirect("/minhaConta");
        } else {
            response.sendRedirect("/login");
        }
    }
}
    
