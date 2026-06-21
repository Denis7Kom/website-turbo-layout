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
