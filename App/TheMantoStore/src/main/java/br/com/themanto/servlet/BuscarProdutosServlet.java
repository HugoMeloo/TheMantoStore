package br.com.themanto.servlet;
import dao.ProdutosDao;
import model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/BuscarProdutos")
public class BuscarProdutosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String termo = req.getParameter("search");
        int page = 1;
        int pageSize = 10;

        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {}

        int offset = (page - 1) * pageSize;

        ProdutosDao dao = new ProdutosDao();
        List<Produtos> produtos;

        if (termo == null || termo.trim().isEmpty()) {
            // 👍 Busca sem filtro, retorna todos paginados
            produtos = dao.buscarTodosPaginado(pageSize, offset);
        } else {
            // 🔍 Busca com filtro
            produtos = dao.buscarProdutosPorNomePaginado(termo.trim(), pageSize, offset);
        }

        req.setAttribute("produtos", produtos);
        req.getRequestDispatcher("/tabelaProdutos.jsp").forward(req, resp);
    }
}



