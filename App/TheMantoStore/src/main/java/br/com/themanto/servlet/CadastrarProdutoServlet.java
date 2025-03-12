package br.com.themanto.servlet;

import dao.ProdutosDao;
import model.Imagem;
import model.Produtos;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;

@WebServlet("/CadastrarProduto")
public class CadastrarProdutoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Map<String, Object> parameters = uploadImage(req);

            int produtoId = 0;
            if (parameters.get("id") != null && !parameters.get("id").toString().isEmpty()) {
                produtoId = Integer.parseInt(parameters.get("id").toString());
            }

            String nomeProduto = parameters.get("produto-name").toString();
            double avaliacao = Double.parseDouble(parameters.get("avaliacao").toString());
            String descricao = parameters.get("descricao").toString();
            double preco = Double.parseDouble(parameters.get("preco").toString());
            int quantidade = Integer.parseInt(parameters.get("quantidade").toString());

            Produtos produto = new Produtos(produtoId, nomeProduto, avaliacao, descricao, preco, quantidade, true);
            ProdutosDao produtosDao = new ProdutosDao();

            if (produtoId == 0) {
                produtoId = produtosDao.createProductAndGetId(produto); // AGORA CORRETO!
            } else {
                produtosDao.updateProduto(produto);
            }

            List<Imagem> imagens = (List<Imagem>) parameters.get("imagens");
            for (Imagem imagem : imagens) {
                imagem.setProdutoId(produtoId); // AGORA TERÁ O ID VÁLIDO!
                produtosDao.saveImagem(imagem);
            }

            resp.sendRedirect("/ExibirProdutos");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Erro ao cadastrar produto: " + e.getMessage());
        }
    }


    private Map<String, Object> uploadImage(HttpServletRequest request) throws Exception {
        Map<String, Object> parameters = new HashMap<>();
        List<Imagem> imagens = new ArrayList<>();
        boolean primeiraImagem = true;

        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> fileItems = upload.parseRequest(request);

            for (FileItem item : fileItems) {
                if (item.isFormField()) {
                    parameters.put(item.getFieldName(), item.getString());
                } else if (item.getSize() > 0) {
                    String extensao = item.getName().substring(item.getName().lastIndexOf("."));
                    String nomeArquivo = UUID.randomUUID() + extensao;
                    String caminhoArquivo = "img/" + nomeArquivo;

                    String pathReal = getServletContext().getRealPath("img") + File.separator + nomeArquivo;
                    item.write(new File(pathReal));

                    boolean isPadrao = primeiraImagem;
                    primeiraImagem = false;

                    imagens.add(new Imagem(0, 0, nomeArquivo, caminhoArquivo, isPadrao));
                }
            }
        }

        parameters.put("imagens", imagens);  // <- CORREÇÃO AQUI!

        return parameters;
    }
}
