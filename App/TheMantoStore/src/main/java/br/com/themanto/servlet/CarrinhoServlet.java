package br.com.themanto.servlet;

import dao.ProdutosDao;
import model.CarrinhoItem;
import model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        String acao = req.getParameter("acao");

        // Obtém a sessão do usuário
        HttpSession session = req.getSession();
        List<CarrinhoItem> carrinho = (List<CarrinhoItem>) session.getAttribute("carrinho");

        if (carrinho == null) {
            carrinho = new ArrayList<>();
        }

        if (idParam != null) {
            ProdutosDao pdao = new ProdutosDao();
            Produtos produto = pdao.findProdutoById(idParam);

            if (produto != null) {
                boolean jaNoCarrinho = false;

                // Verifica se o produto já está no carrinho
                for (CarrinhoItem item : carrinho) {
                    // Comparação do ID com o operador '==', já que o ID é int
                    if (item.getProduto().getId() == produto.getId()) {
                        jaNoCarrinho = true;
                        if ("adicionar".equals(acao)) {
                            item.setQuantidade(item.getQuantidade() + 1); // Incrementa a quantidade
                        } else if ("remover".equals(acao) && item.getQuantidade() > 1) {
                            item.setQuantidade(item.getQuantidade() - 1); // Decrementa a quantidade
                        } else if ("remover".equals(acao) && item.getQuantidade() == 1) {
                            // Remove o item do carrinho se a quantidade for zero
                            carrinho.remove(item);
                        }
                        break;
                    }
                }

                // Se o produto não estiver no carrinho e a ação não for "remover", adiciona com quantidade 1
                if (!jaNoCarrinho && !"remover".equals(acao)) {
                    CarrinhoItem item = new CarrinhoItem(produto, 1); // Adiciona um novo item com quantidade 1
                    carrinho.add(item);
                }
            }
        }

        // Salva a lista de produtos no carrinho
        session.setAttribute("carrinho", carrinho);

        // Calcula o total do carrinho
        double totalCarrinho = carrinho.stream().mapToDouble(item -> item.getProduto().getPreco() * item.getQuantidade()).sum();

        // Formatação do total com 2 casas decimais
        DecimalFormat df = new DecimalFormat("R$ #,##0.00");
        String totalFormatado = df.format(totalCarrinho);

        req.setAttribute("totalCarrinho", totalFormatado);

        // Encaminha para a página JSP
        req.getRequestDispatcher("carrinho.jsp").forward(req, resp);
    }

    // Método para finalizar a compra
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Finalizar a compra: limpa o carrinho e finaliza a sessão
        HttpSession session = req.getSession();
        session.removeAttribute("carrinho");

        // Você pode invalidar a sessão completamente se quiser
        // session.invalidate();

        // Redireciona o usuário para uma página de confirmação
        resp.sendRedirect("");
    }
}
