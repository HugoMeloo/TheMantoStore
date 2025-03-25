package br.com.themanto.servlet;

import dao.ProdutosDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AtualizarQuantidadeProduto")
public class AtualizarQuantidadeProdutoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String page = req.getParameter("page");
            int produtoId = Integer.parseInt(req.getParameter("id"));
            int novaQuantidade = Integer.parseInt(req.getParameter("qtdEstoque"));

            ProdutosDao produtosDao = new ProdutosDao();
            produtosDao.atualizarQuantidadeProduto(produtoId, novaQuantidade);

            if (page != null && !page.isEmpty()) {
                resp.sendRedirect("/ExibirProdutos?page=" + page);
            } else {
                resp.sendRedirect("/ExibirProdutos");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Erro ao atualizar quantidade do produto: " + e.getMessage());
        }
    }
}
