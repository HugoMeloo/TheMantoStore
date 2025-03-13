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

@WebServlet({"/ExibirProdutosEstoquista", "/est/ExibirProdutos"})
public class ExibirProdutosEstoquistaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Produtos> produtos = new ProdutosDao().findAllProdutos();

        req.setAttribute("produtos", produtos);

        req.getRequestDispatcher("/produtosEstoquista.jsp").forward(req, resp);

    }
}
