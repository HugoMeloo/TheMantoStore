package config;

import org.apache.commons.dbcp2.BasicDataSource;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ConnectionPoolConfig {
    private static int cont = 0;
    private static BasicDataSource dataSource;

    private ConnectionPoolConfig() {
        getDataSource();
    }

    // usar essa url para acessar o banco pelo console: jdbc:h2:file:./database/TheMantoStoreDB
    private static BasicDataSource getDataSource() {
        if (dataSource == null) {
            // Obtém o diretório do projeto dinamicamente
            String projectDir = System.getProperty("user.dir");
            String dbPath = projectDir + File.separator + "database" + File.separator + "TheMantoStoreDB";

            // Garante que o diretório do banco exista
            File databaseFolder = new File(projectDir + File.separator + "database");
            if (!databaseFolder.exists()) {
                databaseFolder.mkdirs();
                System.out.println("📂 Diretório do banco criado: " + databaseFolder.getAbsolutePath());
            }

            // Configura o pool de conexões
            dataSource = new BasicDataSource();
            dataSource.setUrl("jdbc:h2:file:" + dbPath + ";AUTO_SERVER=TRUE"); // 🔹 Caminho dinâmico do banco
            dataSource.setUsername("sa");
            dataSource.setPassword("sa");
            dataSource.setMinIdle(5);
            dataSource.setMaxIdle(10);
            dataSource.setMaxTotal(50);
            dataSource.setDriverClassName("org.h2.Driver");

            System.out.println("✅ Banco de dados H2 conectado em: " + dbPath);
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
            System.out.println("❌ Erro na criação do banco: " + e.getMessage());
        }
    }

    private static void createTableUsers(Connection connection) {
        String SQL = """
                    CREATE TABLE IF NOT EXISTS USERS (
                        iduser INT AUTO_INCREMENT PRIMARY KEY,
                        nome VARCHAR(50) NOT NULL,
                        email VARCHAR(50) UNIQUE NOT NULL,
                        senha VARCHAR(255) NOT NULL,
                        cpf CHAR(50) UNIQUE NOT NULL,
                        status BOOLEAN DEFAULT TRUE,
                        grupo CHAR(3) CHECK (grupo IN ('adm', 'est'))
                    );
                """;

        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.execute();
            System.out.println("✅ Tabela USERS criada/verificada com sucesso!");
        } catch (Exception e) {
            System.out.println("❌ Falha ao criar/verificar tabela USERS: " + e.getMessage());
        }
    }
}
