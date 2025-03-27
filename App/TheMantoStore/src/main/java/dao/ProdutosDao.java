package dao;

import config.ConnectionPoolConfig;

import model.Imagem;
import model.Produtos;
import config.ConnectionPoolConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProdutosDao {


    public int createProductAndGetId(Produtos produtos) throws SQLException {
        String SQL = "INSERT INTO PRODUTOS (nome, avaliacao, descricao, preco, quantidade, status) VALUES (?, ?, ?, ?, ?, ?)";
        int produtoId = 0;

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, produtos.getNomeProduto());
            preparedStatement.setDouble(2, produtos.getAvaliacao());
            preparedStatement.setString(3, produtos.getDescricao());
            preparedStatement.setDouble(4, produtos.getPreco());
            preparedStatement.setInt(5, produtos.getQtdEstoque());
            preparedStatement.setBoolean(6, produtos.isStatus());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha ao inserir produto, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    produtoId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Falha ao obter o ID do produto inserido.");
                }
            }

            System.out.println("Produto inserido com ID: " + produtoId);
            return produtoId;

        } catch (SQLException e) {
            System.err.println("Erro ao inserir produto: " + e.getMessage());
            throw e;
        }
    }



    public List<Produtos> findAllProdutos() {
        String SQL = "SELECT * FROM PRODUTOS"; // Ajuste conforme sua tabela
        List<Produtos> produtos = new ArrayList<>();

        try (
                Connection connection = ConnectionPoolConfig.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL);
                ResultSet resultSet = preparedStatement.executeQuery()
        ) {
            while (resultSet.next()) {
                Produtos produto = new Produtos(
                        resultSet.getInt("id"),
                        resultSet.getString("nome"),
                        resultSet.getDouble("avaliacao"),
                        resultSet.getString("descricao"),
                        resultSet.getDouble("preco"),
                        resultSet.getInt("quantidade"),
                        resultSet.getBoolean("status")
                );

                // Buscar imagens do produto
                List<Imagem> imagens = findAllImageById(produto.getId());
                produto.setImagens(imagens); // Adicionando a lista de imagens ao produto

                produtos.add(produto);
            }
            System.out.println("Produtos e imagens carregados com sucesso.");
        } catch (Exception e) {
            System.out.println("Erro ao carregar produtos: " + e.getMessage());
        }

        return produtos;
    }

    public List<Imagem> findAllImageById(int idProduto) {
        String SQL = "SELECT * FROM IMAGEM_PRODUTO WHERE produto_id = ?";
        List<Imagem> allImages = new ArrayList<>();

        try (
                Connection connection = ConnectionPoolConfig.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL)
        ) {
            // Passando o ID do produto na query
            preparedStatement.setInt(1, idProduto);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Imagem imagem = new Imagem(
                            resultSet.getInt("ID_IMAGE"),
                            resultSet.getInt("produto_id"),          // ID do produto
                            resultSet.getString("nome_arquivo"),     // Nome do arquivo
                            resultSet.getString("caminho_arquivo"),  // Caminho do arquivo
                            resultSet.getBoolean("imagem_padrao")    // Se é a imagem padrão
                    );

                    allImages.add(imagem);
                }
            }

            System.out.println("Sucesso ao consultar os dados na tabela IMAGEM_PRODUTO");
        } catch (Exception e) {
            System.out.println("Falha ao consultar os dados na tabela IMAGEM_PRODUTO: " + e.getMessage());
        }

        return allImages;
    }

    public Produtos findProdutoById(String idProduto) {
        String SQL = "SELECT * FROM PRODUTOS WHERE id = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, idProduto);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return new Produtos(
                        resultSet.getInt("id"),
                        resultSet.getString("nome"),
                        resultSet.getDouble("avaliacao"),
                        resultSet.getString("descricao"),
                        resultSet.getDouble("preco"),
                        resultSet.getInt("quantidade"),
                        resultSet.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar produto pelo ID: " + e.getMessage());
        }
        return null;
    }

    public List<Produtos> buscarTodosPaginado(int limit, int offset) {
        List<Produtos> lista = new ArrayList<>();

        String sql = "SELECT * FROM produtos ORDER BY id ASC LIMIT ? OFFSET ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Produtos produto = new Produtos(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getDouble("avaliacao"),
                        rs.getString("descricao"),
                        rs.getDouble("preco"),
                        rs.getInt("quantidade"),
                        rs.getBoolean("status")
                );

                produto.setId(rs.getInt("id"));
                produto.setNomeProduto(rs.getString("nome"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setQtdEstoque(rs.getInt("quantidade"));
                produto.setAvaliacao(rs.getDouble("avaliacao"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setStatus(rs.getBoolean("status"));

                // 👇 Inclui imagens do produto
                List<Imagem> imagens = findAllImageById(produto.getId());
                produto.setImagens(imagens);

                lista.add(produto);
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace(); // ou log com logger
        }

        return lista;
    }


    public boolean updateProduto(Produtos produtos) {
        String SQL = "UPDATE PRODUTOS SET nome = ?, avaliacao = ?, descricao = ?, preco = ?, quantidade = ? WHERE id = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, produtos.getNomeProduto());
            preparedStatement.setDouble(2, produtos.getAvaliacao());
            preparedStatement.setString(3, produtos.getDescricao());
            preparedStatement.setDouble(4, produtos.getPreco());
            preparedStatement.setInt(5, produtos.getQtdEstoque());
            preparedStatement.setInt(6, produtos.getId()); // Certifique-se de que o ID está correto


            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar produto: " + e.getMessage());
            return false;
        }
    }

    public void atualizarQuantidadeProduto(int produtoId, int novaQuantidade) {
        String sql = "UPDATE PRODUTOS SET quantidade = ? WHERE id = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, novaQuantidade);
            stmt.setInt(2, produtoId);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Quantidade do produto ID " + produtoId + " atualizada para " + novaQuantidade);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Produtos> buscarProdutosPorNomePaginado(String termo, int limit, int offset) {
        List<Produtos> lista = new ArrayList<>();
        String sql = "SELECT * FROM PRODUTOS WHERE LOWER(nome) LIKE ? ORDER BY id ASC LIMIT ? OFFSET ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + termo.toLowerCase() + "%");
            stmt.setInt(2, limit);
            stmt.setInt(3, offset);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Produtos produto = new Produtos(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getDouble("avaliacao"),
                        rs.getString("descricao"),
                        rs.getDouble("preco"),
                        rs.getInt("quantidade"),
                        rs.getBoolean("status")
                );
                lista.add(produto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean updateProdutoStatus(int idProduto, boolean status) {
        String SQL = "UPDATE PRODUTOS SET status = ? WHERE id = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, idProduto);

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println("Sucesso ao atualizar status do produto");
                return true;
            } else {
                System.out.println("Nenhum produto encontrado para atualizar o status");
                return false;
            }
        } catch (Exception e) {
            System.out.println("Falha ao atualizar status do produto");
            System.out.println("Erro: " + e.getMessage());
            return false;
        }
    }

    public void deleteImagensByProdutoId(int produtoId) throws SQLException {
        String sql = "DELETE FROM IMAGEM_PRODUTO WHERE produto_id = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, produtoId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao deletar imagens do produto: " + e.getMessage());
            throw e;
        }
    }


    public void saveImagem(Imagem imagem) throws SQLException {
        String SQL = "INSERT INTO imagem_produto (produto_id, nome_arquivo, caminho_arquivo, imagem_padrao) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, imagem.getProdutoId());
            preparedStatement.setString(2, imagem.getNomeArquivo());
            preparedStatement.setString(3, imagem.getCaminhoArquivo());
            preparedStatement.setBoolean(4, imagem.isImagemPadrao());

            preparedStatement.executeUpdate();
        }
    }

    public List<Imagem> getImagensByProdutoId(int produtoId) {
        List<Imagem> imagens = new ArrayList<>();
        String sql = "SELECT * FROM IMAGEM_PRODUTO WHERE produto_id = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, produtoId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Imagem imagem = new Imagem(
                        rs.getInt("id_image"),
                        rs.getInt("produto_id"),
                        rs.getString("nome_arquivo"),
                        rs.getString("caminho_arquivo"),
                        rs.getBoolean("imagem_padrao")
                );
                imagens.add(imagem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return imagens;
    }


}


