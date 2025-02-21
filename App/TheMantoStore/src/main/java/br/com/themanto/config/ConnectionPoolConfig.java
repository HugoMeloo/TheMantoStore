package br.com.themanto.config;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ConnectionPoolConfig {

        private static int cont = 0;


        private static BasicDataSource dataSource;

        private ConnectionPoolConfig() {
            getDataSource();
        }

        private static BasicDataSource getDataSource() {

            if (dataSource == null) {
                dataSource = new BasicDataSource();
                dataSource.setUrl("jdbc:h2:~/test");
                dataSource.setUsername("sa");
                dataSource.setPassword("sa");
                dataSource.setMinIdle(5);
                dataSource.setMaxIdle(10);
                dataSource.setMaxTotal(50);

                System.out.println("New connection pool created with successful");

            }

            return dataSource;

        }

        public static Connection getConnection() throws SQLException {
            if (cont == 0) {
                creates();
                cont++;
            }
            return getDataSource().getConnection();

        }

        private static void creates() {
            try (Connection connection = getDataSource().getConnection()) {
                createTableUsers(connection);


            } catch (SQLException e) {
                System.out.println("Erro na criação das tabelas e procedures: " + e.getMessage());
            }
        }

        private static void createTableUsers(Connection connection) {
            String SQL = "CREATE TABLE IF NOT EXISTS USERS("
                    + "iduser INT AUTO_INCREMENT PRIMARY KEY, "
                    + "nome VARCHAR(50) NOT NULL, "
                    + "email VARCHAR(50) UNIQUE NOT NULL, "
                    + "senha VARCHAR(15) NOT NULL, "
                    + "cpf CHAR(11) UNIQUE NOT NULL, "
                    + "status BOOLEAN DEFAULT TRUE, "
                    + "grupo CHAR(3) CHECK (grupo IN ('adm', 'est')) );";



            try {


                PreparedStatement preparedStatement = connection.prepareStatement(SQL);

                preparedStatement.execute();

                System.out.println("sucess in create table users");

            } catch (Exception e) {
                System.out.println("fail in create table users " + e.getMessage());
            }
        }
    }





