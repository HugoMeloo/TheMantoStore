package dao;

import config.ConnectionPoolConfig;
import model.DadosPessoais;

import java.sql.*;

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

    public DadosPessoais findUserById(String idUser) {
        String sql = "SELECT * FROM DADOS_PESSOAIS WHERE IDUSER = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, idUser);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                DadosPessoais dados = new DadosPessoais();
                dados.setGenero(rs.getString("genero"));
                dados.setDataNascimento(Date.valueOf(rs.getString("data_nascimento")));
                return dados;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar dados pessoais", e);
        }

        return null;
    }

    public void updateDadosPessoais(String idUser, String dataNascimento, String genero) {
        String sql = "UPDATE DADOS_PESSOAIS SET data_nascimento = ?, genero = ? WHERE idUser = ?";

        try (Connection conn = ConnectionPoolConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, dataNascimento); // formato yyyy-MM-dd
            stmt.setString(2, genero);
            stmt.setString(3, idUser);

            int linhasAfetadas = stmt.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println("Dados pessoais de cliente atualizados com sucesso!");
            } else {
                System.out.println("Nenhum registro foi atualizado. Verifique o ID do usuário.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
