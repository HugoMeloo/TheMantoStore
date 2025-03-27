package br.com.themanto.servlet;

import dao.ProdutosDao;
import model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        ProdutosDao pdao = new ProdutosDao();
        Produtos produto = pdao.findProdutoById(id);


        req.setAttribute("produto", produto);

        req.getRequestDispatcher("carrinho.jsp").forward(req,resp);
    }
}
