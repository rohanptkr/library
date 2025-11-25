package com.library.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/library_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1";
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        
        // Add connection parameters to prevent timeout and reset issues
        String connectionURL = URL + "?useSSL=false&serverTimezone=UTC&autoReconnect=true&maxReconnects=10";
        
        Connection connection = DriverManager.getConnection(connectionURL, USERNAME, PASSWORD);
        
        return connection;
    }
}
