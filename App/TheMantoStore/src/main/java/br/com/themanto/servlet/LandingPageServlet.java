package br.com.themanto.servlet;



import dao.ProdutosDao;
import model.Imagem;
import model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("")
public class LandingPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ProdutosDao pdao = new ProdutosDao();
        List<Produtos> allProdutos = pdao.findAllProdutos();



        req.setAttribute("produtos", allProdutos);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);

    }

}
