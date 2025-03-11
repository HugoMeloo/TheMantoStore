package br.com.themanto.servlet;

import dao.ProdutosDao;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AlterarStatusProduto")
public class AlterarStatusProdutoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idProdutoStr = req.getParameter("id");
            String statusStr = req.getParameter("status");
            String currentPage = req.getParameter("page");

            if (idProdutoStr == null || idProdutoStr.isEmpty()) {
                throw new IllegalArgumentException("ID do produto não pode ser nulo ou vazio.");
            }

            int produtoId = Integer.parseInt(idProdutoStr);
            boolean novoStatus = "true".equals(statusStr);

            ProdutosDao produtosDao = new ProdutosDao();
            produtosDao.updateProdutoStatus(produtoId, novoStatus);

            // Redireciona para a mesma página após a alteração
            resp.sendRedirect("/ExibirProdutos?page=" + (currentPage != null ? currentPage : "1"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Erro ao alterar status: " + e.getMessage());
        }
    }
}
