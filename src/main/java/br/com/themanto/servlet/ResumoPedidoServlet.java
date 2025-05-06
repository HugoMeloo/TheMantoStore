package br.com.themanto.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/resumo-pedido")
public class ResumoPedidoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String pagamento = req.getParameter("pagamento");

        session.setAttribute("formaPagamento", pagamento);

        if ("cartao".equals(pagamento)) {
            session.setAttribute("numeroCartao", req.getParameter("numeroCartao"));
            session.setAttribute("nomeTitular", req.getParameter("nomeTitular"));
            session.setAttribute("validade", req.getParameter("validade"));
            session.setAttribute("cvv", req.getParameter("cvv"));
            session.setAttribute("parcelas", req.getParameter("parcelas"));
        }

        // Dados de carrinho e frete já devem estar salvos anteriormente na sessão
        resp.sendRedirect("resumo-pedido.jsp");
    }
}

