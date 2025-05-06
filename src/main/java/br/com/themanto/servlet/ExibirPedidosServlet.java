package br.com.themanto.servlet;

import dao.PedidosDao;
import model.Pedidos;
import model.Users;
import model.CarrinhoItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/exibirPedidos")
public class ExibirPedidosServlet extends HttpServlet {

    private final PedidosDao pedidosDao = new PedidosDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users usuario = (Users) session.getAttribute("usuario");

        // Redireciona se não estiver logado
        if (usuario == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Busca os pedidos do cliente
        List<Pedidos> pedidos = pedidosDao.listarPedidosPorCliente(usuario.getIdUser());

        // Para cada pedido, busca e adiciona os itens correspondentes
        for (Pedidos pedido : pedidos) {
            List<CarrinhoItem> itens = pedidosDao.buscarItensPedido(pedido.getIdPedido());
            pedido.setItens(itens);
            System.out.println(itens);
        }

        // Envia para o JSP
        req.setAttribute("pedidos", pedidos);
        req.getRequestDispatcher("exibirPedidos.jsp").forward(req, resp);
    }
}
