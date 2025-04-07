package dao;

import config.ConnectionPoolConfig;
import model.Endereco;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EnderecoDao {
    public void salvarEndereco(Endereco endereco) {
        String sql = "INSERT INTO ENDERECO (IDUSER, CEP, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, UF, TIPO_ENDERECO) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

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

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar endereço", e);
        }
    }

}
