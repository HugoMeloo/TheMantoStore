package br.com.themanto.servlet;

import dao.EnderecoDao;
import dao.ProdutosDao;
import model.CarrinhoItem;
import model.Endereco;
import model.Produtos;
import model.Users;

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
        req.setCharacterEncoding("UTF-8");
        String idParam = req.getParameter("id");
        String acao = req.getParameter("acao");

        // Obtém a sessão do usuário
        HttpSession session = req.getSession();
        System.out.println("Atributos disponíveis na sessão:");

        var attributeNames = session.getAttributeNames(); // Obtém o Enumeration de atributos

        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement(); // Nome do atributo
            Object attributeValue = session.getAttribute(attributeName); // Valor do atributo
            System.out.println("Atributo: " + attributeName + " -> Valor: " + attributeValue);
        }


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
                            System.out.println("Adicionando mais um item ao carrinho");
                        } else if ("remover".equals(acao) && item.getQuantidade() > 1) {
                            item.setQuantidade(item.getQuantidade() - 1); // Decrementa a quantidade
                            System.out.println("Removendo uma unidade do item do carrinho");
                        } else if ("remover".equals(acao) && item.getQuantidade() == 1) {
                            // Remove o item do carrinho se a quantidade for zero
                            System.out.println("Removendo o item do carrinho");
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

        Users usuarioLogado = (Users) session.getAttribute("usuario");
        if (usuarioLogado != null) {
            String idUserStr = String.valueOf(usuarioLogado.getIdUser());
            EnderecoDao enderecoDao = new EnderecoDao();
            List<Endereco> enderecos = enderecoDao.buscarEnderecosPorUsuario(idUserStr);
            System.out.println("Endereços retornados: " + enderecos);
            req.setAttribute("enderecosUsuario", enderecos);
        }

        // Encaminha para a página JSP
        req.getRequestDispatcher("carrinho.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        req.setCharacterEncoding("UTF-8");

        // 1. Verifica se o usuário está logado
        Users usuario = (Users) session.getAttribute("usuario");
        if (usuario == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. Verifica se endereço e frete foram preenchidos
        String enderecoSelecionado = req.getParameter("enderecoSelecionado");
        if (enderecoSelecionado == null || enderecoSelecionado.isBlank()) {
            session.setAttribute("erroEndereco", "Por favor, selecione um endereço de entrega.");
            resp.sendRedirect("carrinho");
            return;
        }

        String valorFrete = req.getParameter("valorFrete");
        if (valorFrete == null || valorFrete.isBlank()) {
            session.setAttribute("erroFrete", "Por favor, selecione um valor de frete.");
            resp.sendRedirect("carrinho");
            return;
        }

        // 3. Verifica o carrinho
        List<CarrinhoItem> carrinho = (List<CarrinhoItem>) session.getAttribute("carrinho");
        if (carrinho == null || carrinho.isEmpty()) {
            resp.sendRedirect("carrinho");
            return;
        }

        // 4. Calcula totais
        double totalProdutos = carrinho.stream()
                .mapToDouble(item -> item.getProduto().getPreco() * item.getQuantidade())
                .sum();

        double freteDouble = Double.parseDouble(valorFrete);
        double totalComFrete = totalProdutos + freteDouble;
        double descontoPix = totalComFrete * 0.07;
        double totalPix = totalComFrete - descontoPix;

        // 5. Busca o endereço detalhado
        EnderecoDao enderecoDao = new EnderecoDao();
        Endereco enderecoObj = enderecoDao.buscarEnderecoPorId(enderecoSelecionado); // você precisa implementar isso

        if (enderecoObj != null) {
            String enderecoFormatado = String.format(
                    "%s, %s%s, %s, %s - %s, CEP: %s",
                    enderecoObj.getLogradouro(),
                    enderecoObj.getNumero(),
                    enderecoObj.getComplemento() != null && !enderecoObj.getComplemento().isBlank()
                            ? " - " + enderecoObj.getComplemento() : "",
                    enderecoObj.getBairro(),
                    enderecoObj.getCidade(),
                    enderecoObj.getUf(),
                    enderecoObj.getCep()
            );
            session.setAttribute("enderecoSelecionadoDetalhado", enderecoFormatado);
        }

        // 6. Salva na sessão
        session.setAttribute("valorProdutos", totalProdutos);
        session.setAttribute("valorFrete", freteDouble);
        session.setAttribute("totalComFrete", totalComFrete);
        session.setAttribute("totalPix", totalPix);
        session.setAttribute("descontoPix", descontoPix);
        session.setAttribute("enderecoSelecionado", enderecoSelecionado);

        session.removeAttribute("erroEndereco");
        session.removeAttribute("erroFrete");

        // 7. Redireciona para pagamento
        resp.sendRedirect("pagamento.jsp");
    }

}
