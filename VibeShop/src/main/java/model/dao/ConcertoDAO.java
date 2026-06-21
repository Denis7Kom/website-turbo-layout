package model.dao;

import model.ConcertoBean;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConcertoDAO {
    public List<ConcertoBean> findAllActive() throws SQLException {
        String sql = "SELECT id_concerto, id_artista, nome, luogo, data_concerto, prezzo, descrizione, immagine, active FROM concerto WHERE active = true ORDER BY data_concerto";
        List<ConcertoBean> list = new ArrayList<ConcertoBean>();
        try (Connection c = DataSourceProvider.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public ConcertoBean findById(int id) throws SQLException {
        String sql = "SELECT id_concerto, id_artista, nome, luogo, data_concerto, prezzo, descrizione, immagine, active FROM concerto WHERE id_concerto = ?";
        try (Connection c = DataSourceProvider.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    private ConcertoBean map(ResultSet rs) throws SQLException {
        ConcertoBean bean = new ConcertoBean();
        bean.setIdConcerto(rs.getInt("id_concerto"));
        int idArtista = rs.getInt("id_artista");
        bean.setIdArtista(rs.wasNull() ? null : idArtista);
        bean.setNome(rs.getString("nome"));
        bean.setLuogo(rs.getString("luogo"));
        bean.setDataEvento(rs.getTimestamp("data_concerto"));
        BigDecimal prezzo = rs.getBigDecimal("prezzo");
        bean.setPrezzo(prezzo == null ? new BigDecimal("0.00") : prezzo);
        bean.setDescrizione(rs.getString("descrizione"));
        bean.setImmagine(rs.getString("immagine"));
        bean.setActive(rs.getBoolean("active"));
        return bean;
    }
}
