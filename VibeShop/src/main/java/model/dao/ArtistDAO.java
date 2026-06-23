package model.dao;

import model.ArtistBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ArtistDAO {

    public List<ArtistBean> findAll() throws SQLException {
        String sql = "SELECT id_artista, nome_d_arte, paese, biografia, genere, foto "
                + "FROM artista ORDER BY nome_d_arte";
        return findBySql(sql, 0);
    }

    public List<ArtistBean> findFeatured(int limit) throws SQLException {
        String sql = "SELECT id_artista, nome_d_arte, paese, biografia, genere, foto "
                + "FROM artista ORDER BY id_artista LIMIT ?";
        return findBySql(sql, limit);
    }

    public ArtistBean findById(int id) throws SQLException {
        String sql = "SELECT id_artista, nome_d_arte, paese, biografia, genere, foto FROM artista WHERE id_artista = ?";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public void create(ArtistBean artist) throws SQLException {
        String sql = "INSERT INTO artista (nome_d_arte, paese, biografia, genere, foto) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            bindArtist(statement, artist);
            statement.executeUpdate();
        }
    }

    public void update(ArtistBean artist) throws SQLException {
        String sql = "UPDATE artista SET nome_d_arte = ?, paese = ?, biografia = ?, genere = ?, foto = ? WHERE id_artista = ?";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            bindArtist(statement, artist);
            statement.setInt(6, artist.getIdArtista());
            statement.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM artista WHERE id_artista = ?";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    private List<ArtistBean> findBySql(String sql, int limit) throws SQLException {
        List<ArtistBean> artists = new ArrayList<ArtistBean>();

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            if (limit > 0) {
                statement.setInt(1, limit);
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    artists.add(map(rs));
                }
            }
        }

        return artists;
    }

    private void bindArtist(PreparedStatement statement, ArtistBean artist) throws SQLException {
        statement.setString(1, artist.getNomeArte());
        statement.setString(2, emptyToNull(artist.getPaese()));
        statement.setString(3, emptyToNull(artist.getBiografia()));
        statement.setString(4, emptyToNull(artist.getGenere()));
        statement.setString(5, emptyToNull(artist.getFoto()));
    }

    private String emptyToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private ArtistBean map(ResultSet rs) throws SQLException {
        ArtistBean artist = new ArtistBean();
        artist.setIdArtista(rs.getInt("id_artista"));
        artist.setNomeArte(rs.getString("nome_d_arte"));
        artist.setPaese(rs.getString("paese"));
        artist.setBiografia(rs.getString("biografia"));
        artist.setGenere(rs.getString("genere"));
        artist.setFoto(rs.getString("foto"));
        return artist;
    }
}
