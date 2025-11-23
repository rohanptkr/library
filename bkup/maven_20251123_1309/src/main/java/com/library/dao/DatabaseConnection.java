package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;

public class DatabaseConnection {
    
    public static Connection getConnection() {
        try {
            Properties props = new Properties();
            InputStream input = DatabaseConnection.class.getClassLoader()
                .getResourceAsStream("database.properties");
            
            System.out.println("DatabaseConnection: Creating new connection...");
            
            if (input == null) {
                System.out.println("DatabaseConnection: No database.properties found, using defaults");
                // Fallback to direct configuration
                props.setProperty("db.url", "jdbc:mysql://localhost:3306/library_db");
                props.setProperty("db.user", "library_user");
                props.setProperty("db.password", "library_password");
            } else {
                System.out.println("DatabaseConnection: Loading database.properties");
                props.load(input);
            }
            
            String url = props.getProperty("db.url");
            String user = props.getProperty("db.user");
            String password = props.getProperty("db.password");
            
            System.out.println("DatabaseConnection: URL=" + url);
            System.out.println("DatabaseConnection: User=" + user);
            
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("DatabaseConnection: Driver loaded successfully");
            
            // Establish NEW connection each time
            Connection connection = DriverManager.getConnection(url, user, password);
            System.out.println("DatabaseConnection: New connection established successfully");
            
            return connection;
            
        } catch (ClassNotFoundException e) {
            System.err.println("DatabaseConnection: MySQL Driver not found: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to load MySQL driver", e);
        } catch (SQLException e) {
            System.err.println("DatabaseConnection: SQL Error: " + e.getMessage());
            System.err.println("DatabaseConnection: SQL State: " + e.getSQLState());
            System.err.println("DatabaseConnection: Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        } catch (Exception e) {
            System.err.println("DatabaseConnection: General Error: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }
}
