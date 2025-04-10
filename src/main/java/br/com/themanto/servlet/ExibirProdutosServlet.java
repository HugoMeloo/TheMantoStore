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

@WebServlet({"/ExibirProdutos", "/admin/ExibirProdutos"})


public class ExibirProdutosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        List<Produtos> produtos = new ProdutosDao().findAllProdutos();

        req.setAttribute("produtos", produtos);
        System.out.println("Número de produtos retornados: " + produtos.size());

        req.getRequestDispatcher("/produtosBackoffice.jsp").forward(req, resp);
    }
}
