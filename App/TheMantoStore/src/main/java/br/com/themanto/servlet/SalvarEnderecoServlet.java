package br.com.themanto.servlet;

import dao.EnderecoDao;
import dao.UsersDao;
import model.Endereco;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/salvar-endereco")
public class SalvarEnderecoServlet extends HttpServlet {
    private final EnderecoDao enderecoDao = new EnderecoDao();
    private final UsersDao usersDao = new UsersDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int idUser = Integer.parseInt(request.getParameter("idUser"));

        // Faturamento
        Endereco faturamento = new Endereco(
                request.getParameter("cep_faturamento"),
                request.getParameter("logradouro_faturamento"),
                request.getParameter("numero_faturamento"),
                request.getParameter("complemento_faturamento"),
                request.getParameter("bairro_faturamento"),
                request.getParameter("cidade_faturamento"),
                request.getParameter("uf_faturamento"),
                "FATURAMENTO",
                idUser
        );

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
                idUser
        );

        // Salva ambos
        enderecoDao.salvarEndereco(faturamento);
        enderecoDao.salvarEndereco(entrega);
        String idStr = String.valueOf(idUser); // agora é String "14"
        Users usuario = usersDao.findUserById(idStr);

        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuario);

        response.sendRedirect("/");
    }
}
