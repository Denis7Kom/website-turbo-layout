package model.dao;

import model.ConcertoBean;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
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

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM concerto";
        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int create(ConcertoBean concert) throws SQLException {
        String sql = "INSERT INTO concerto (data_ora, titolo_evento, prezzo, iva, id_artista, luogo_indirizzo, event_manager) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillConcertStatement(statement, concert, false);
            statement.executeUpdate();

            try (ResultSet keys = statement.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : 0;
            }
        }
    }

    public void update(ConcertoBean concert) throws SQLException {
        String sql = "UPDATE concerto SET data_ora = ?, titolo_evento = ?, prezzo = ?, iva = ?, "
                + "id_artista = ?, luogo_indirizzo = ?, event_manager = ? WHERE id_concerto = ?";

        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            fillConcertStatement(statement, concert, true);
            statement.executeUpdate();
        }
    }

    public void delete(int idConcerto) throws SQLException {
        String sql = "DELETE FROM concerto WHERE id_concerto = ?";
        try (Connection connection = DataSourceProvider.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, idConcerto);
            statement.executeUpdate();
        }
    }

    private void fillConcertStatement(PreparedStatement statement, ConcertoBean concert, boolean includeId)
            throws SQLException {

        if (concert.getDataEvento() == null) {
            statement.setNull(1, Types.TIMESTAMP);
        } else {
            statement.setTimestamp(1, concert.getDataEvento());
        }

        statement.setString(2, concert.getNome());
        statement.setBigDecimal(3, concert.getPrezzo());
        statement.setBigDecimal(4, concert.getIva());

        if (concert.getIdArtista() == null) {
            statement.setNull(5, Types.INTEGER);
        } else {
            statement.setInt(5, concert.getIdArtista());
        }

        statement.setString(6, concert.getLuogo());
        statement.setString(7, concert.getDescrizione());

        if (includeId) {
            statement.setInt(8, concert.getIdConcerto());
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
        concert.setDescrizione(manager == null || manager.trim().isEmpty() ? "VibeShop Events" : manager);
        concert.setImmagine(null);
        concert.setActive(true);

        return concert;
    }
}
