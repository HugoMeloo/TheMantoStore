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
            Map<String, Object> parameters = uploadImage(req); // Captura os parâmetros do formulário

            // Debug: verificar os parâmetros recebidos
            System.out.println("Parâmetros Recebidos:");
            for (Map.Entry<String, Object> entry : parameters.entrySet()) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
            }

            // Obtendo valores do request, garantindo que não sejam nulos
            int produtoId = parameters.get("id") != null && !parameters.get("id").toString().isEmpty()
                    ? Integer.parseInt(parameters.get("id").toString()) : 0;

            String nomeProduto = parameters.get("produto-name") != null ? parameters.get("produto-name").toString() : "";
            String avaliacaoStr = parameters.get("avaliacao") != null ? parameters.get("avaliacao").toString() : "0";
            String descricao = parameters.get("descricao") != null ? parameters.get("descricao").toString() : "";
            String precoStr = parameters.get("preco") != null ? parameters.get("preco").toString() : "0";
            String quantidadeStr = parameters.get("qtdEstoque") != null ? parameters.get("qtdEstoque").toString() : "0";
            String page = parameters.get("page") != null ? parameters.get("page").toString() : null;

            double avaliacao = Double.parseDouble(avaliacaoStr);
            double preco = Double.parseDouble(precoStr);
            int quantidade = Integer.parseInt(quantidadeStr);

            // Criando objeto Produto
            Produtos produto = new Produtos(produtoId, nomeProduto, avaliacao, descricao, preco, quantidade, true);
            ProdutosDao produtosDao = new ProdutosDao();

            if (produtoId == 0) {
                // Criar novo produto e obter ID gerado
                produtoId = produtosDao.createProductAndGetId(produto);
            } else {
                // Atualizar produto existente
                produtosDao.updateProduto(produto);

            }

            // Buscar imagens existentes do produto (caso seja uma atualização)
            List<Imagem> imagensExistentes = produtosDao.getImagensByProdutoId(produtoId);
            System.out.println("Imagens Existentes: " + imagensExistentes.size());

            // Adicionar novas imagens se houver upload
            List<Imagem> novasImagens = (List<Imagem>) parameters.get("imagens");
            if (novasImagens != null && !novasImagens.isEmpty()) {
                for (Imagem imagem : novasImagens) {
                    imagem.setProdutoId(produtoId);
                    produtosDao.saveImagem(imagem);
                }
            }

            if (page != null && !page.isEmpty() && !"null".equals(page)) {
                resp.sendRedirect("/ExibirProdutos?page=" + page);
            } else {
                resp.sendRedirect("/ExibirProdutos");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Erro ao cadastrar/alterar produto: " + e.getMessage());
        }
    }

    private Map<String, Object> uploadImage(HttpServletRequest request) throws Exception {
        Map<String, Object> parameters = new HashMap<>();
        List<Imagem> imagens = new ArrayList<>();
        int imagemPrincipalIndex = 0;

        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> fileItems = upload.parseRequest(request);

            List<FileItem> imagensUpload = new ArrayList<>();
            int indexImagem = 0;

            for (FileItem item : fileItems) {
                if (item.isFormField()) {
                    parameters.put(item.getFieldName(), item.getString("UTF-8"));
                    if ("imagemPrincipalIndex".equals(item.getFieldName())) {
                        imagemPrincipalIndex = Integer.parseInt(item.getString("UTF-8"));
                    }
                } else if (item.getSize() > 0) {
                    imagensUpload.add(item); // Guardar para associar com o índice depois
                }
            }

            for (int i = 0; i < imagensUpload.size(); i++) {
                FileItem item = imagensUpload.get(i);

                String extensao = item.getName().substring(item.getName().lastIndexOf("."));
                String nomeArquivo = UUID.randomUUID() + extensao;
                String caminhoArquivo = "img/" + nomeArquivo;

                String pathReal = getServletContext().getRealPath("img") + File.separator + nomeArquivo;
                item.write(new File(pathReal));

                boolean isPadrao = (i == imagemPrincipalIndex);

                Imagem imagem = new Imagem(0, 0, nomeArquivo, caminhoArquivo, isPadrao);
                imagens.add(imagem);
            }
        }

        parameters.put("imagens", imagens);
        return parameters;
    }

}
