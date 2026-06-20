package model.dao;

import model.UserBean;

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

    public UserBean findByEmail(String email) throws SQLException {
        String sql = "SELECT id_utente, nome, cognome, email, role, cellulare, password_hash "
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

    public UserBean findByEmailAndPassword(String email, String plainPassword) throws SQLException {
        String sql = "SELECT id_utente, nome, cognome, email, role, cellulare, password_hash "
                + "FROM utente WHERE email = ? AND password_hash = SHA2(?, 256)";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, plainPassword);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
                return null;
            }
        }
    }

    public void create(UserBean user, String plainPassword) throws SQLException {
        String sql = "INSERT INTO utente (nome, cognome, email, role, cellulare, password_hash) "
                + "VALUES (?, ?, ?, 'CLIENTE', ?, SHA2(?, 256))";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getNome());
            ps.setString(2, user.getCognome());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getCellulare());
            ps.setString(5, plainPassword);

            ps.executeUpdate();
        }
    }

    public void updateProfile(UserBean user) throws SQLException {
        String sql = "UPDATE utente SET nome = ?, cognome = ?, cellulare = ? WHERE id_utente = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getNome());
            ps.setString(2, user.getCognome());
            ps.setString(3, user.getCellulare());
            ps.setInt(4, user.getIdUtente());

            ps.executeUpdate();
        }
    }

    public void updatePassword(int idUtente, String newPlainPassword) throws SQLException {
        String sql = "UPDATE utente SET password_hash = SHA2(?, 256) WHERE id_utente = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newPlainPassword);
            ps.setInt(2, idUtente);

            ps.executeUpdate();
        }
    }

    private UserBean mapUser(ResultSet rs) throws SQLException {
        UserBean user = new UserBean();
        user.setIdUtente(rs.getInt("id_utente"));
        user.setNome(rs.getString("nome"));
        user.setCognome(rs.getString("cognome"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        user.setCellulare(rs.getString("cellulare"));
        user.setPasswordHash(rs.getString("password_hash"));
        return user;
    }
}
