package br.com.themanto.servlet;

import dao.DadosPessoaisDao;
import dao.EnderecoDao;
import dao.UsersDao;
import model.DadosPessoais;
import model.Endereco;
import model.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet("/minhaConta")
public class RedirecionarConfig extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        Users usuarioLogado = (Users) session.getAttribute("usuario");
        System.out.println(usuarioLogado);
        if (usuarioLogado != null) {
            String idUsuario = String.valueOf(usuarioLogado.getIdUser());
            UsersDao usersDao = new UsersDao();
            Users usuarioAtualizado = usersDao.findUserById(idUsuario);
            DadosPessoaisDao dadosPessoaisDao = new DadosPessoaisDao();
            DadosPessoais dadosPessoais = dadosPessoaisDao.findUserById(idUsuario);
            EnderecoDao enderecoDao = new EnderecoDao();
            List<Endereco> listaEnderecos = enderecoDao.buscarEnderecosPorUsuario(idUsuario);
            System.out.println(listaEnderecos);
            req.setAttribute("dadosPadrao", usuarioAtualizado);
            req.setAttribute("dadosPessoais", dadosPessoais);
            req.setAttribute("listaEnderecos", listaEnderecos);

            RequestDispatcher dispatcher = req.getRequestDispatcher("/configuracoes-usuario.jsp");
            dispatcher.forward(req, resp);
        } else {
            resp.sendRedirect("/login"); // redireciona se não estiver logado
        }
    }
}
