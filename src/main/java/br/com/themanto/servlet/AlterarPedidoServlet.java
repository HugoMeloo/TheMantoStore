package br.com.themanto.servlet;

import dao.PedidosDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/alterarPedido")
public class AlterarPedidoServlet extends HttpServlet {

    private final PedidosDao pedidosDao = new PedidosDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idPedido = Integer.parseInt(req.getParameter("idPedido"));
        String novoStatus = req.getParameter("status");
        System.out.println(novoStatus);
        boolean atualizado = pedidosDao.atualizarStatusPedido(idPedido, novoStatus);

        if (atualizado) {
            resp.sendRedirect("exibirPedidos?sucesso=true");
        } else {
            resp.sendRedirect("exibirPedidos?erro=true");
        }
    }
}



