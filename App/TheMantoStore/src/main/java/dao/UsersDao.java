package dao;

import model.Users;
import config.ConnectionPoolConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class UsersDao {

    public void createUsers(Users users) {
        String SQL = "INSERT INTO USERS (nome, email, senha, cpf, status, grupo) VALUES (?, ?, ?, ?, ?, ?)";


        try {
            Connection connection = ConnectionPoolConfig.getConnection();

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setString(1, users.getNome());
            preparedStatement.setString(2, users.getEmail());
            preparedStatement.setString(3, users.getSenha());
            preparedStatement.setString(4, users.getCpf());
            preparedStatement.setBoolean(5, users.isStatus());
            preparedStatement.setString(6, users.getGrupo());

            preparedStatement.execute();

            System.out.println("Sucesso ao inserir Usuario");
            connection.close();

        } catch (SQLException e) {
            System.err.println("Erro ao inserir usuario: " + e.getMessage());
            e.printStackTrace();

        }
    }

    public List<Users> findAllUsers() {
        String SQL = "SELECT * FROM USERS";
        List<Users> allUsers = new ArrayList<>();

        try (
                Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Users user = new Users(
                        resultSet.getInt("idUser"),
                        resultSet.getString("nome"),
                        resultSet.getString("email"),
                        resultSet.getString("senha"),
                        resultSet.getString("cpf"),
                        resultSet.getBoolean("status"),
                        resultSet.getString("grupo")
                );
                allUsers.add(user);
            }

            System.out.println("Sucesso ao consultar os dados na tabela Users");
        } catch (Exception e) {
            System.out.println("Falha ao consultar os dados na tabela Users: " + e.getMessage());
        }

        return allUsers;
    }

    public boolean updateUserGroup(String idUser, String novoGrupo) {
        String SQL = "UPDATE USERS SET grupo = ? WHERE idUser = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, novoGrupo);
            preparedStatement.setString(2, idUser);

            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar grupo: " + e.getMessage());
            return false;
        }
    }


    public boolean emailExists(String email) {
        String SQL = "SELECT COUNT(*) FROM USERS WHERE email = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Erro ao verificar email: " + e.getMessage());
        }
        return false;
    }
    public boolean cpfExists(String cpf) {
        String SQL = "SELECT COUNT(*) FROM USERS WHERE cpf = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, cpf);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0; // Retorna true se o CPF já existir
            }
        } catch (SQLException e) {
            System.out.println("Erro ao verificar CPF: " + e.getMessage());
        }
        return false;
    }

    public Users findUserById(String idUser) {
        String SQL = "SELECT * FROM USERS WHERE idUser = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, idUser);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return new Users(
                        resultSet.getInt("idUser"),
                        resultSet.getString("nome"),
                        resultSet.getString("email"),
                        resultSet.getString("senha"),
                        resultSet.getString("cpf"),
                        resultSet.getBoolean("status"),
                        resultSet.getString("grupo")
                );
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário pelo ID: " + e.getMessage());
        }
        return null;
    }

    public Users searchUsers(String email, String senhaCriptografada) {
        String SQL = "SELECT * FROM USERS WHERE email = ? AND senha = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senhaCriptografada); // 🔹 Verifica a senha direto no banco

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                System.out.println("✅ Usuário encontrado: " + resultSet.getString("email"));
                return new Users(
                        resultSet.getInt("iduser"),
                        resultSet.getString("nome"),
                        resultSet.getString("email"),
                        resultSet.getString("senha"),
                        resultSet.getString("cpf"),
                        resultSet.getBoolean("status"),
                        resultSet.getString("grupo")
                );
            } else {
                System.out.println("❌ Usuário ou senha incorretos.");
            }
        } catch (Exception e) {
            System.out.println("❌ Erro ao consultar usuário: " + e.getMessage());
        }

        return null; // Retorna null se o usuário não existir ou a senha estiver errada
    }

    public boolean updateUser(Users user) {
        String SQL = "UPDATE USERS SET nome = ?, cpf = ?, senha = ? WHERE idUser = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, user.getNome());
            preparedStatement.setString(2, user.getCpf());
            preparedStatement.setString(3, user.getSenha());
            preparedStatement.setInt(4, user.getIdUser());

            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar usuário: " + e.getMessage());
            return false;
        }
    }

    public boolean updateUserStatus(String email, boolean status) {
        String SQL = "UPDATE USERS SET status = ? WHERE email = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setBoolean(1, status);
            preparedStatement.setString(2, email);

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println("Sucesso ao atualizar status do usuário");
                return true;
            } else {
                System.out.println("Nenhum usuário encontrado para atualizar o status");
                return false;
            }
        } catch (Exception e) {
            System.out.println("Falha ao atualizar status do usuário");
            System.out.println("Erro: " + e.getMessage());
            return false;
        }
    }






}














