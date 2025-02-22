package br.com.themanto.dao;

import br.com.themanto.model.Users;
import br.com.themanto.config.ConnectionPoolConfig;

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
            preparedStatement.setString(2, users.getCpf());
            preparedStatement.setString(3, users.getEmail());
            preparedStatement.setString(4, users.getSenha());
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

    public boolean updateUser(Users user) {
        String SQL = "UPDATE USERS SET nome = ?, cpf = ?, senha = ? WHERE email = ?";

        try (Connection connection = ConnectionPoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, user.getNome());
            preparedStatement.setString(2, user.getCpf());
            preparedStatement.setString(3, user.getSenha());
            preparedStatement.setString(4, user.getEmail());

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println("Sucesso ao atualizar usuário");
                return true;
            } else {
                System.out.println("Nenhum usuário encontrado para atualizar");
                return false;
            }
        } catch (Exception e) {
            System.out.println("Falha ao atualizar usuário");
            System.out.println("Erro: " + e.getMessage());
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














