package dao;

import config.ConnectionPoolConfig;
import model.DadosPessoais;
import model.Endereco;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnderecoDao {
    public void salvarEndereco(Endereco endereco) {
        String sql = "INSERT INTO ENDERECO (IDUSER, CEP, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, UF, TIPO_ENDERECO,PADRAO) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, endereco.getIdUser());
            stmt.setString(2, endereco.getCep());
            stmt.setString(3, endereco.getLogradouro());
            stmt.setString(4, endereco.getNumero());
            stmt.setString(5, endereco.getComplemento());
            stmt.setString(6, endereco.getBairro());
            stmt.setString(7, endereco.getCidade());
            stmt.setString(8, endereco.getUf());
            stmt.setString(9, endereco.getTipoEndereco());
            stmt.setBoolean(10, endereco.isPadrao());

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar endereço", e);
        }
    }

    public List<Endereco> buscarEnderecosPorUsuario(String idUser) {
        List<Endereco> enderecos = new ArrayList<>();
        String sql = "SELECT * FROM ENDERECO WHERE IDUSER = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, idUser);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Endereco endereco = new Endereco();
                endereco.setIdEndereco(rs.getInt("idendereco"));
                endereco.setIdUser(rs.getInt("iduser"));
                endereco.setCep(rs.getString("cep"));
                endereco.setLogradouro(rs.getString("logradouro"));
                endereco.setNumero(rs.getString("numero"));
                endereco.setComplemento(rs.getString("complemento"));
                endereco.setBairro(rs.getString("bairro"));
                endereco.setCidade(rs.getString("cidade"));
                endereco.setUf(rs.getString("uf"));
                endereco.setTipoEndereco(rs.getString("tipo_endereco"));
                endereco.setPadrao(rs.getBoolean("padrao"));

                // Se você tiver um campo "padrao", adicione:
                try {
                    endereco.setPadrao(rs.getBoolean("padrao"));
                } catch (SQLException ignore) {
                    // ignora se não existir a coluna
                }

                enderecos.add(endereco);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar endereços", e);
        }

        return enderecos;
    }

    public Endereco buscarEnderecoPorId(String idEndereco) {
        String sql = "SELECT * FROM ENDERECO WHERE IDENDERECO = ?";
        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(idEndereco));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Endereco e = new Endereco();
                e.setIdEndereco(rs.getInt("idendereco"));
                e.setCep(rs.getString("cep"));
                e.setLogradouro(rs.getString("logradouro"));
                e.setNumero(rs.getString("numero"));
                e.setComplemento(rs.getString("complemento"));
                e.setBairro(rs.getString("bairro"));
                e.setCidade(rs.getString("cidade"));
                e.setUf(rs.getString("uf"));
                e.setTipoEndereco(rs.getString("tipo_endereco"));
                e.setIdUser(rs.getInt("iduser"));
                return e;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public void definirEnderecoPadrao(int idEndereco, int idUsuario) {
        String desmarcarTodos = "UPDATE ENDERECO SET padrao = FALSE WHERE IDUSER = ?";
        String marcarNovo = "UPDATE ENDERECO SET padrao = TRUE WHERE IDENDERECO = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection()) {
            // Desmarcar todos os outros
            try (PreparedStatement stmt1 = conn.prepareStatement(desmarcarTodos)) {
                stmt1.setInt(1, idUsuario);
                stmt1.executeUpdate();
            }

            // Marcar o selecionado como padrão
            try (PreparedStatement stmt2 = conn.prepareStatement(marcarNovo)) {
                stmt2.setInt(1, idEndereco);
                stmt2.executeUpdate();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao definir endereço padrão", e);
        }
    }

}