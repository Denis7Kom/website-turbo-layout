package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Centralized provider for database connections.
 *
 * Tomcat 9 compatible: this class does not depend on jakarta.*.
 * All DAO classes should obtain MySQL connections only through this class.
 */
public final class DataSourceProvider {

    private static final String URL =
            "jdbc:mysql://localhost:3306/vibeshop"
            + "?useSSL=false"
            + "&serverTimezone=Europe/Rome"
            + "&allowPublicKeyRetrieval=true"
            + "&characterEncoding=UTF-8";

    private static final String USER = "vibeshop_app";
    private static final String PASSWORD = "VibeShopApp2026!";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    private DataSourceProvider() {
        // Utility class: do not instantiate.
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
