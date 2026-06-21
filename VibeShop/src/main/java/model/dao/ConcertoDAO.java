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
        String sql = "SELECT id_concerto, data_ora, titolo_evento, prezzo, iva, id_artista, luogo_indirizzo, event_manager "
                + "FROM concerto ORDER BY data_ora";

        List<ConcertoBean> concerts = new ArrayList<ConcertoBean>();

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                concerts.add(map(rs));
            }
        }

        return concerts;
    }

    public ConcertoBean findById(int idConcerto) throws SQLException {
        String sql = "SELECT id_concerto, data_ora, titolo_evento, prezzo, iva, id_artista, luogo_indirizzo, event_manager "
                + "FROM concerto WHERE id_concerto = ?";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, idConcerto);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    private ConcertoBean map(ResultSet rs) throws SQLException {
        ConcertoBean concert = new ConcertoBean();
        concert.setIdConcerto(rs.getInt("id_concerto"));

        int idArtista = rs.getInt("id_artista");
        concert.setIdArtista(rs.wasNull() ? null : idArtista);

        concert.setNome(rs.getString("titolo_evento"));
        concert.setLuogo(rs.getString("luogo_indirizzo"));
        concert.setDataEvento(rs.getTimestamp("data_ora"));

        BigDecimal prezzo = rs.getBigDecimal("prezzo");
        BigDecimal iva = rs.getBigDecimal("iva");
        concert.setPrezzo(prezzo == null ? new BigDecimal("0.00") : prezzo);
        concert.setIva(iva == null ? new BigDecimal("10.00") : iva);

        String manager = rs.getString("event_manager");
        concert.setDescrizione(manager == null || manager.trim().isEmpty()
                ? "Evento live VibeShop"
                : "Event manager: " + manager);
        concert.setImmagine(null);
        concert.setActive(true);

        return concert;
    }
}
