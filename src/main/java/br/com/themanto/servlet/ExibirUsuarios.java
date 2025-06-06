package br.com.themanto.servlet;

import dao.UsersDao;
import model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/ExibirUsuarios"})

public class ExibirUsuarios extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        List<Users> user = new UsersDao().findAllUsers();

        req.setAttribute("users", user);

        req.getRequestDispatcher("/backoffice.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        List<Users> user = new UsersDao().findAllUsers();

        req.setAttribute("users", user);

        req.getRequestDispatcher("/backoffice.jsp").forward(req, resp);
    }

}
