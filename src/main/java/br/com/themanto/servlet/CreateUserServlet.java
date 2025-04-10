package br.com.themanto.servlet;

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

@WebServlet("/create-user")
public class CreateUserServlet extends HttpServlet {
    private final UsersDao usersDao = new UsersDao();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nome = request.getParameter("name");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senhaCadastro");
        String confirmSenha = request.getParameter("confirmarSenha");
        String grupo = request.getParameter("grupo");


        request.setAttribute("origin", "cadastro");

        // Verifica se o CPF já está cadastrado
        if (usersDao.cpfExists(cpf)) {
            System.out.println("❌ CPF já cadastrado: " + cpf);
            request.setAttribute("errorMessage", "Este CPF já está cadastrado.");
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            return;
        }

        // 1. Comparação antes da criptografia
        if (senha == null || !senha.equals(confirmSenha)) {
            request.setAttribute("errorMessage", "As senhas não correspondem.");
            request.setAttribute("name", nome);
            request.setAttribute("email", email);
            request.setAttribute("cpf", cpf);
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            System.out.println("Senha: " + senha + " Confirmsenha " + confirmSenha);
            return;
        }

        // 2. Validação de CPF
        if (!CpfValidator.isValidCpf(cpf)) {
            request.setAttribute("errorMessage", "CPF inválido.");
            request.setAttribute("name", nome);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            return;
        }

        // 3. Verificação se o email já existe
        if (usersDao.emailExists(email)) {
            request.setAttribute("errorMessage", "Email já cadastrado.");
            request.setAttribute("name", nome);
            request.setAttribute("cpf", cpf);
            request.getRequestDispatcher("/admin/ExibirUsuarios").forward(request, response);
            return;
        }


        // 4. Criptografia da senha
        String senhaHash = PasswordUtils.hashPassword(senha);

        // 5. Criar usuário
        Users novoUsuario = new Users(nome, email, senhaHash, cpf, true, grupo);
        usersDao.createUsers(novoUsuario);

        // 6. Redireciona para login com sucesso
        response.sendRedirect("/admin/ExibirUsuarios");
    }
}
