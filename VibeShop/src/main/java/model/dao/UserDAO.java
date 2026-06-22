package model.dao;

import model.UserBean;
import util.PasswordUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public boolean existsByEmail(String email) throws SQLException {
        String sql = "SELECT 1 FROM utente WHERE email = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean existsByUsername(String username) throws SQLException {
        String sql = "SELECT 1 FROM utente WHERE username = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean existsByEmailForOtherUser(String email, int idUtente) throws SQLException {
        String sql = "SELECT 1 FROM utente WHERE email = ? AND id_utente <> ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setInt(2, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean existsByUsernameForOtherUser(String username, int idUtente) throws SQLException {
        String sql = "SELECT 1 FROM utente WHERE username = ? AND id_utente <> ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setInt(2, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public UserBean findByEmail(String email) throws SQLException {
        String sql = "SELECT id_utente, nome, cognome, username, email, role, cellulare, password_hash "
                + "FROM utente WHERE email = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
                return null;
            }
        }
    }

    public UserBean findById(int idUtente) throws SQLException {
        String sql = "SELECT id_utente, nome, cognome, username, email, role, cellulare, password_hash "
                + "FROM utente WHERE id_utente = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
                return null;
            }
        }
    }

    public UserBean findByLogin(String login) throws SQLException {
        String sql = "SELECT id_utente, nome, cognome, username, email, role, cellulare, password_hash "
                + "FROM utente WHERE email = ? OR username = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, login);
            ps.setString(2, login);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
                return null;
            }
        }
    }

    public UserBean findByEmailAndPassword(String email, String plainPassword) throws SQLException {
        return findByLoginAndPassword(email, plainPassword);
    }

    public UserBean findByLoginAndPassword(String login, String plainPassword) throws SQLException {
        UserBean user = findByLogin(login);

        if (user == null) {
            return null;
        }

        if (!PasswordUtils.verifyPassword(plainPassword, user.getPasswordHash())) {
            return null;
        }

        return user;
    }

    public void create(UserBean user, String plainPassword) throws SQLException {
        String sql = "INSERT INTO utente (nome, cognome, username, email, role, cellulare, password_hash) "
                + "VALUES (?, ?, ?, ?, 'CLIENTE', ?, ?)";

        String passwordHash = PasswordUtils.hashPassword(plainPassword);

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getNome());
            ps.setString(2, user.getCognome());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getCellulare());
            ps.setString(6, passwordHash);

            ps.executeUpdate();
        }
    }

    public void updateProfile(UserBean user) throws SQLException {
        String sql = "UPDATE utente SET nome = ?, cognome = ?, username = ?, email = ?, cellulare = ? WHERE id_utente = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getNome());
            ps.setString(2, user.getCognome());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getCellulare());
            ps.setInt(6, user.getIdUtente());

            ps.executeUpdate();
        }
    }

    public void updatePassword(int idUtente, String newPlainPassword) throws SQLException {
        String sql = "UPDATE utente SET password_hash = ? WHERE id_utente = ?";

        String passwordHash = PasswordUtils.hashPassword(newPlainPassword);

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, passwordHash);
            ps.setInt(2, idUtente);
            ps.executeUpdate();
        }
    }

    private UserBean mapUser(ResultSet rs) throws SQLException {
        UserBean user = new UserBean();
        user.setIdUtente(rs.getInt("id_utente"));
        user.setNome(rs.getString("nome"));
        user.setCognome(rs.getString("cognome"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        user.setCellulare(rs.getString("cellulare"));
        user.setPasswordHash(rs.getString("password_hash"));
        return user;
    }
}
