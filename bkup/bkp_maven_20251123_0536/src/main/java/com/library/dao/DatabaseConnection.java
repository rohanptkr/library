package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;

public class DatabaseConnection {
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection == null) {
            try {
                Properties props = new Properties();
                InputStream input = DatabaseConnection.class.getClassLoader()
                    .getResourceAsStream("database.properties");
                
                if (input == null) {
                    // Fallback to direct configuration
                    props.setProperty("db.url", "jdbc:mysql://localhost:3306/library_db");
                    props.setProperty("db.user", "library_user");
                    props.setProperty("db.password", "library_password");
                } else {
                    props.load(input);
                }
                
                String url = props.getProperty("db.url");
                String user = props.getProperty("db.user");
                String password = props.getProperty("db.password");
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, password);
                System.out.println("Database connection established successfully.");
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("Failed to establish database connection", e);
            }
        }
        return connection;
    }
    
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
