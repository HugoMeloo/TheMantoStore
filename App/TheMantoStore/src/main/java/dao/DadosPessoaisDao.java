package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import config.ConnectionPoolConfig;

public class DadosPessoaisDao {

    public void insertDadosPessoais(int idUser, String dataNascimento, String genero) {
        String sql = "INSERT INTO DADOS_PESSOAIS (IDUSER, DATA_NASCIMENTO, GENERO) VALUES (?, ?, ?)";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idUser);
            stmt.setDate(2, java.sql.Date.valueOf(dataNascimento));
            stmt.setString(3, genero);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir dados pessoais", e);
        }
    }
}

