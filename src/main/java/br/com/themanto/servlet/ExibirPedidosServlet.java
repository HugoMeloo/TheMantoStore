package br.com.themanto.servlet;

import dao.EnderecoDao;
import dao.PedidosDao;
import model.CarrinhoItem;
import model.Endereco;
import model.Pedidos;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

@WebServlet("/exibirPedidos")
public class ExibirPedidosServlet extends HttpServlet {

    private final PedidosDao pedidosDao = new PedidosDao();
    private final EnderecoDao enderecoDao = new EnderecoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users usuario = (Users) session.getAttribute("usuario");

        // Redireciona se não estiver logado
        if (usuario == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        Set<String> gruposPermitidos = Set.of("est", "admin");

        System.out.println("Usuário autenticado: " + usuario);

        // Verifica se o usuário pertence ao grupo "client"
        if ("client".equals(usuario.getGrupo())) {

            // Busca os pedidos do cliente
            List<Pedidos> pedidos = pedidosDao.listarPedidosPorCliente(usuario.getIdUser());
            List<Endereco> enderecos = new ArrayList<>();

            for (Pedidos pedido : pedidos) {
                // Buscar itens do pedido
                List<CarrinhoItem> itens = pedidosDao.buscarItensPedido(pedido.getIdPedido());
                pedido.setItens(itens);

                // Buscar endereço correspondente
                String idEnderecoStr = String.valueOf(pedido.getIdEndereco());
                Endereco endereco = enderecoDao.buscarEnderecoPorId(idEnderecoStr);
                enderecos.add(endereco);
            }

            // Envia os objetos para o JSP
            req.setAttribute("pedidos", pedidos);
            req.setAttribute("enderecos", enderecos);
            req.getRequestDispatcher("exibirPedidos.jsp").forward(req, resp);

        } else if (gruposPermitidos.contains(usuario.getGrupo())) {
            // Busca os pedidos do cliente
            List<Pedidos> pedidos = pedidosDao.listarTodosPedidos();
            List<Endereco> enderecos = new ArrayList<>();

            for (Pedidos pedido : pedidos) {
                // Buscar itens do pedido
                List<CarrinhoItem> itens = pedidosDao.buscarItensPedido(pedido.getIdPedido());
                pedido.setItens(itens);

                // Buscar endereço correspondente
                String idEnderecoStr = String.valueOf(pedido.getIdEndereco());
                Endereco endereco = enderecoDao.buscarEnderecoPorId(idEnderecoStr);
                enderecos.add(endereco);
            }

            // Envia os objetos para o JSP
            req.setAttribute("pedidos", pedidos);
            req.setAttribute("enderecos", enderecos);
            req.getRequestDispatcher("exibirPedidosEstoque.jsp").forward(req, resp);

        } else {
            // Redireciona ou bloqueia acesso se não for cliente
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Acesso não autorizado.");
        }
    }
}

