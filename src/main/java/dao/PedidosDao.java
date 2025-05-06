package dao;

import config.ConnectionPoolConfig;
import model.CarrinhoItem;
import model.Pedidos;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.time.ZoneId;
import java.util.Date;


public class PedidosDao {

    // 1. Inserir pedido e retornar o ID gerado
    public int inserirPedido(Pedidos pedido) {
        String sql = "INSERT INTO pedidos (id_cliente, id_endereco, forma_pagamento, valor_produtos, valor_frete, valor_desconto, valor_total, status, observacoes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, pedido.getIdCliente());
            stmt.setInt(2, pedido.getIdEndereco());
            stmt.setString(3, pedido.getFormaPagamento());
            stmt.setDouble(4, pedido.getValorProdutos());
            stmt.setDouble(5, pedido.getValorFrete());
            stmt.setDouble(6, pedido.getValorDesconto());
            stmt.setDouble(7, pedido.getValorTotal());
            stmt.setString(8, pedido.getStatus());
            stmt.setString(9, pedido.getObservacoes());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // ID do pedido gerado
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Erro
    }

    // 2. Inserir os itens de um pedido
    public boolean inserirItensPedido(int idPedido, List<CarrinhoItem> itens) {
        String sql = "INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (CarrinhoItem item : itens) {
                stmt.setInt(1, idPedido);
                stmt.setInt(2, item.getProduto().getId());
                stmt.setInt(3, item.getQuantidade());
                stmt.setDouble(4, item.getProduto().getPreco());
                stmt.addBatch();
            }

            stmt.executeBatch();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. Listar todos os pedidos
    public List<Pedidos> listarTodosPedidos() {
        List<Pedidos> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedidos ORDER BY data_criacao DESC";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Pedidos p = new Pedidos();
                p.setIdPedido(rs.getInt("id_pedido"));
                p.setIdCliente(rs.getInt("id_cliente"));
                p.setIdEndereco(rs.getInt("id_endereco"));
                p.setFormaPagamento(rs.getString("forma_pagamento"));
                p.setValorProdutos(rs.getDouble("valor_produtos"));
                p.setValorFrete(rs.getDouble("valor_frete"));
                p.setValorDesconto(rs.getDouble("valor_desconto"));
                p.setValorTotal(rs.getDouble("valor_total"));
                p.setStatus(rs.getString("status"));
                p.setNumPedido(rs.getInt("num_pedido"));
                p.setObservacoes(rs.getString("observacoes"));

                // NOVO: converte data_criacao para Date
                LocalDateTime dataCriacao = rs.getTimestamp("data_criacao").toLocalDateTime();
                Date dataCriacaoDate = Date.from(dataCriacao.atZone(ZoneId.systemDefault()).toInstant());
                p.setDataCriacaoDate(dataCriacaoDate);

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // 4. Atualizar status do pedido
    public boolean atualizarStatusPedido(int idPedido, String novoStatus) {
        String sql = "UPDATE pedidos SET status = ?, data_atualizacao = CURRENT_TIMESTAMP WHERE id_pedido = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, novoStatus);
            stmt.setInt(2, idPedido);
            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Pedidos> listarPedidosPorCliente(int idCliente) {
        List<Pedidos> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedidos WHERE id_cliente = ? ORDER BY data_criacao DESC";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idCliente);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Pedidos p = new Pedidos();
                p.setIdPedido(rs.getInt("id_pedido"));
                p.setIdCliente(rs.getInt("id_cliente"));
                p.setIdEndereco(rs.getInt("id_endereco"));
                p.setFormaPagamento(rs.getString("forma_pagamento"));
                p.setValorProdutos(rs.getDouble("valor_produtos"));
                p.setValorFrete(rs.getDouble("valor_frete"));
                p.setValorDesconto(rs.getDouble("valor_desconto"));
                p.setValorTotal(rs.getDouble("valor_total"));
                p.setStatus(rs.getString("status"));
                p.setNumPedido(rs.getInt("num_pedido"));
                p.setObservacoes(rs.getString("observacoes"));

                // NOVO: converte data_criacao para Date
                LocalDateTime dataCriacao = rs.getTimestamp("data_criacao").toLocalDateTime();
                Date dataCriacaoDate = Date.from(dataCriacao.atZone(ZoneId.systemDefault()).toInstant());
                p.setDataCriacaoDate(dataCriacaoDate);

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
    public List<CarrinhoItem> buscarItensPedido(int idPedido) {
        List<CarrinhoItem> itens = new ArrayList<>();

        String sql = "SELECT ip.id_produto, ip.quantidade, ip.preco_unitario, " +
                "p.nome, p.status, p.descricao " +
                "FROM itens_pedido ip " +
                "JOIN produtos p ON ip.id_produto = p.id " +
                "WHERE ip.id_pedido = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idPedido);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Cria o objeto Produto
                model.Produtos produto = new model.Produtos();
                produto.setId(rs.getInt("id_produto"));
                produto.setNomeProduto(rs.getString("nome"));
                produto.setPreco(rs.getDouble("preco_unitario")); // salva valor histórico
                produto.setDescricao(rs.getString("descricao"));
                produto.setStatus(rs.getBoolean("status"));

                // Cria o objeto CarrinhoItem
                CarrinhoItem item = new CarrinhoItem();
                item.setProduto(produto);
                item.setQuantidade(rs.getInt("quantidade"));

                itens.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itens;
    }


}
