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
        String SQL = "SELECT * FROM PRODUTOS";
        List<Produtos> allProduct = new ArrayList<>();

        try (
                Connection connection = ConnectionPoolConfig.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Produtos produtos = new Produtos(
                        resultSet.getInt("id"),
                        resultSet.getString("nome"),
                        resultSet.getDouble("avaliacao"),
                        resultSet.getString("descricao"),
                        resultSet.getDouble("preco"),
                        resultSet.getInt("quantidade"),
                        resultSet.getBoolean("status")
                );
                allProduct.add(produtos);
            }

            System.out.println("Sucesso ao consultar os dados na tabela Produtos");
        } catch (Exception e) {
            System.out.println("Falha ao consultar os dados na tabela Produtos: " + e.getMessage());
        }

        return allProduct;
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

    public boolean updateProduto(Produtos produtos) {
        String SQL = "UPDATE PRODUTOS SET nome = ?, avaliacao = ?, descricao = ?, preco = ?, quantidade = ? WHERE id = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, produtos.getNomeProduto());
            preparedStatement.setDouble(2, produtos.getAvaliacao());
            preparedStatement.setString(3, produtos.getDescricao());
            preparedStatement.setDouble(4, produtos.getPreco());
            preparedStatement.setInt(5, produtos.getQtdEstoque());

            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar produto: " + e.getMessage());
            return false;
        }
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

}


