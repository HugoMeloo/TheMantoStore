package br.com.themanto.servlet;

import dao.PedidosDao;
import model.CarrinhoItem;
import model.Pedidos;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/concluir-compra")
public class ConcluirCompraServlet extends HttpServlet {
    private final PedidosDao pedidosDao = new PedidosDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // Recupera dados da sessão
        Users usuario = (Users) session.getAttribute("usuario");
        String formaPagamento = (String) session.getAttribute("formaPagamento");
        Double valorProdutos = (Double) session.getAttribute("valorProdutos");
        Double valorFrete = (Double) session.getAttribute("valorFrete");
        Double descontoPix = (Double) session.getAttribute("descontoPix");
        Double totalComDesconto = (Double) session.getAttribute("totalPix");
        String enderecoFormatado = (String) session.getAttribute("enderecoSelecionadoDetalhado");
        String idEnderecoStr = String.valueOf(session.getAttribute("enderecoSelecionado"));
        List<CarrinhoItem> carrinho = (List<CarrinhoItem>) session.getAttribute("carrinho");

        // Valida presença dos dados
        if (usuario == null || formaPagamento == null || valorProdutos == null ||
                valorFrete == null || descontoPix == null || totalComDesconto == null ||
                enderecoFormatado == null || idEnderecoStr == null || carrinho == null || carrinho.isEmpty()) {
            resp.sendRedirect("erro.jsp");
            return;
        }

        int idEndereco = Integer.parseInt(idEnderecoStr);

        // Cria objeto do pedido
        Pedidos pedido = new Pedidos();
        pedido.setIdCliente(usuario.getIdUser());
        pedido.setIdEndereco(idEndereco);
        pedido.setFormaPagamento(formaPagamento);
        pedido.setValorProdutos(valorProdutos);
        pedido.setValorFrete(valorFrete);
        pedido.setValorDesconto(descontoPix);
        pedido.setValorTotal(totalComDesconto);
        pedido.setStatus("aguardando pagamento");
        pedido.setObservacoes("Pedido realizado por " + usuario.getNome());

        // Salva o pedido principal no banco
        int idPedido = pedidosDao.inserirPedido(pedido);

        if (idPedido > 0) {
            // Salva os itens do pedido
            boolean itensSalvos = pedidosDao.inserirItensPedido(idPedido, carrinho);

            if (itensSalvos) {
                // Limpa dados de sessão (mantém apenas o usuário logado)
                session.removeAttribute("carrinho");
                session.removeAttribute("valorProdutos");
                session.removeAttribute("valorFrete");
                session.removeAttribute("descontoPix");
                session.removeAttribute("totalPix");
                session.removeAttribute("totalComFrete");
                session.removeAttribute("enderecoSelecionado");
                session.removeAttribute("enderecoSelecionadoDetalhado");
                session.removeAttribute("formaPagamento");
                session.setAttribute("numeroPedido", idPedido);
                session.setAttribute("valorTotal", pedido.getValorTotal());
                resp.sendRedirect("pedido-confirmado.jsp");

            } else {
                // Erro ao salvar itens
                resp.sendRedirect("erro.jsp");
            }

        } else {
            // Erro ao salvar pedido principal
            resp.sendRedirect("erro.jsp");
        }
    }
}
