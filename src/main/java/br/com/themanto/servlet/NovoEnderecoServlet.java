package br.com.themanto.servlet;

import dao.EnderecoDao;
import dao.UsersDao;
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

@WebServlet("/novoEndereco")
public class NovoEnderecoServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();
    private final EnderecoDao enderecoDao = new EnderecoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/novo-endereco.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Users usuarioLogado = (Users) session.getAttribute("usuario");
        int idUser = usuarioLogado.getIdUser();


        // Entrega
        Endereco entrega = new Endereco(
                request.getParameter("cep_entrega"),
                request.getParameter("logradouro_entrega"),
                request.getParameter("numero_entrega"),
                request.getParameter("complemento_entrega"),
                request.getParameter("bairro_entrega"),
                request.getParameter("cidade_entrega"),
                request.getParameter("uf_entrega"),
                "ENTREGA",
                idUser,
                true
        );


        enderecoDao.salvarEndereco(entrega);
        String idStr = String.valueOf(idUser);
        Users usuario = usersDao.findUserById(idStr);


        session.setAttribute("usuario", usuario);

        response.sendRedirect("/minhaConta");
    }
}
