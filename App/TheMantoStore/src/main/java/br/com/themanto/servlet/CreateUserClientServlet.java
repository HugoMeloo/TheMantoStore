package br.com.themanto.servlet;

import dao.DadosPessoaisDao;
import dao.UsersDao;
import model.Users;
import utils.CpfValidator;
import utils.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-user-client")
public class CreateUserClientServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();
    private final DadosPessoaisDao dadosPessoaisDao = new DadosPessoaisDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nome = request.getParameter("name");
        String dataNascimento = request.getParameter("dataNascimento");
        String genero = request.getParameter("genero");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senhaCadastro");
        String confirmarSenha = request.getParameter("confirmarSenha");
        System.out.println(senha + "senha");
        System.out.println(confirmarSenha + "senhaconfirma");

        request.setAttribute("name", nome);
        request.setAttribute("email", email);
        request.setAttribute("cpf", cpf);
        request.setAttribute("genero", genero);
        request.setAttribute("dataNascimento", dataNascimento);


        // Valida nome
        if (nome == null || !nome.trim().matches("^(\\b\\w{3,}\\b\\s+){1,}\\b\\w{3,}\\b$")) {
            request.setAttribute("errorMessage", "Informe nome completo com ao menos 2 palavras e mínimo de 3 letras cada.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (senha == null || !senha.equals(confirmarSenha)) {
            request.setAttribute("errorMessage", "As senhas não correspondem.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!CpfValidator.isValidCpf(cpf)) {
            request.setAttribute("errorMessage", "CPF inválido.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (usersDao.cpfExists(cpf)) {
            request.setAttribute("errorMessage", "Este CPF já está cadastrado.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (usersDao.emailExists(email)) {
            request.setAttribute("errorMessage", "Este email já está cadastrado.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        String senhaHash = PasswordUtils.hashPassword(senha);
        Users novoUsuario = new Users(nome, email, senhaHash, cpf, true, "client");
        int idUser = usersDao.createUsers(novoUsuario);
        dadosPessoaisDao.insertDadosPessoais(idUser, dataNascimento, genero);

        response.sendRedirect(request.getContextPath() + "/cadastro-endereco.jsp?idUser=" + idUser);
    }
}
