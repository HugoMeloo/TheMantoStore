package br.com.themanto.servlet;


import dao.DadosPessoaisDao;
import dao.UsersDao;
import model.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/alterar-dados-cliente")
public class AlterarUsuarioClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Users usuarioLogado = (Users) session.getAttribute("usuario");
        String idUsuario = String.valueOf(usuarioLogado.getIdUser());
        String nome = req.getParameter("nome");
        String genero = req.getParameter("genero");
        String novoGenero = null;
        if (genero.equals("Mulher")) {
            novoGenero = "M";
        } else if (genero.equals("Homem")) {
            novoGenero = "H";
        } else if (genero.equals("Outros")) {
            novoGenero = "O";
        } else if (genero.equals("Nao especificar")) {
            novoGenero = "N";
        }
        String dataNascimento = req.getParameter("dataNascimento");

        UsersDao udao = new UsersDao();
        udao.updateUserClient(nome, idUsuario);
        DadosPessoaisDao dpdao = new DadosPessoaisDao();
        dpdao.updateDadosPessoais(idUsuario, dataNascimento, novoGenero);

        resp.sendRedirect("minhaConta");


    }
}
