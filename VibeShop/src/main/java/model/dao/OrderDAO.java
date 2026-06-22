package model.dao;

import model.OrderBean;
import model.OrderItemBean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(OrderBean order) throws SQLException {
        String orderSql = "INSERT INTO ordine "
                + "(data_ordine, id_utente, total_price, tipo_pagamento, stato_ordine, indirizzo_spedizione) "
                + "VALUES (NOW(), ?, ?, ?, 'CONFERMATO', ?)";

        String itemSql = "INSERT INTO dettaglio_ordine "
                + "(id_ordine, id_prodotto, id_concerto, quantita_prodotto, quantita_biglietti, "
                + "prezzo_totale, item_type, item_name, unit_price, iva) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection con = null;

        try {
            con = DataSourceProvider.getConnection();
            con.setAutoCommit(false);

            int generatedOrderId;

            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getIdUtente());
                ps.setBigDecimal(2, order.getTotalPrice());
                ps.setString(3, order.getTipoPagamento());
                ps.setString(4, order.getIndirizzoSpedizione());

                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Order insert failed: no generated key returned.");
                    }
                    generatedOrderId = keys.getInt(1);
                }
            }

            try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                for (OrderItemBean item : order.getItems()) {
                    ps.setInt(1, generatedOrderId);
                    setNullableInteger(ps, 2, item.getIdProdotto());
                    setNullableInteger(ps, 3, item.getIdConcerto());
                    setNullableInteger(ps, 4, item.getQuantitaProdotto());
                    setNullableInteger(ps, 5, item.getQuantitaBiglietti());
                    ps.setBigDecimal(6, item.getPrezzoTotale());
                    ps.setString(7, item.getItemType());
                    ps.setString(8, item.getItemName());
                    ps.setBigDecimal(9, item.getUnitPrice());
                    ps.setBigDecimal(10, item.getIva());
                    ps.addBatch();
                }

                ps.executeBatch();
            }

            con.commit();
            return generatedOrderId;

        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException rollbackException) {
                    e.addSuppressed(rollbackException);
                }
            }
            throw e;

        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException closeException) {
                    // Connection close errors should not hide the original SQL error.
                }
            }
        }
    }

    public List<OrderBean> findByUserId(int idUtente) throws SQLException {
        String sql = "SELECT id_ordine, data_ordine, id_utente, total_price, tipo_pagamento, stato_ordine, indirizzo_spedizione "
                + "FROM ordine WHERE id_utente = ? ORDER BY data_ordine DESC";

        List<OrderBean> orders = new ArrayList<OrderBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }

        return orders;
    }

    public List<OrderBean> findAll() throws SQLException {
        String sql = "SELECT id_ordine, data_ordine, id_utente, total_price, tipo_pagamento, stato_ordine, indirizzo_spedizione "
                + "FROM ordine ORDER BY data_ordine DESC";

        List<OrderBean> orders = new ArrayList<OrderBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        }

        return orders;
    }

    public List<OrderBean> findByFilters(Integer idUtente, Date fromDate, Date toDate) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT id_ordine, data_ordine, id_utente, total_price, "
                + "tipo_pagamento, stato_ordine, indirizzo_spedizione FROM ordine WHERE 1 = 1");

        List<Object> params = new ArrayList<Object>();

        if (idUtente != null) {
            sql.append(" AND id_utente = ?");
            params.add(idUtente);
        }

        if (fromDate != null) {
            sql.append(" AND data_ordine >= ?");
            params.add(fromDate);
        }

        if (toDate != null) {
            sql.append(" AND data_ordine < DATE_ADD(?, INTERVAL 1 DAY)");
            params.add(toDate);
        }

        sql.append(" ORDER BY data_ordine DESC");

        List<OrderBean> orders = new ArrayList<OrderBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                Object value = params.get(i);
                if (value instanceof Integer) {
                    ps.setInt(i + 1, (Integer) value);
                } else if (value instanceof Date) {
                    ps.setDate(i + 1, (Date) value);
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }

        return orders;
    }

    public List<OrderItemBean> findItemsByOrderId(int idOrdine) throws SQLException {
        String sql = "SELECT id_dettaglio, id_ordine, id_prodotto, id_concerto, "
                + "quantita_prodotto, quantita_biglietti, prezzo_totale, "
                + "item_type, item_name, unit_price, iva "
                + "FROM dettaglio_ordine WHERE id_ordine = ? ORDER BY id_dettaglio";

        List<OrderItemBean> items = new ArrayList<OrderItemBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idOrdine);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapOrderItem(rs));
                }
            }
        }

        return items;
    }

    private void setNullableInteger(PreparedStatement ps, int index, Integer value) throws SQLException {
        if (value == null) {
            ps.setNull(index, Types.INTEGER);
        } else {
            ps.setInt(index, value);
        }
    }

    private OrderBean mapOrder(ResultSet rs) throws SQLException {
        OrderBean order = new OrderBean();
        order.setIdOrdine(rs.getInt("id_ordine"));
        order.setDataOrdine(rs.getTimestamp("data_ordine"));
        order.setIdUtente(rs.getInt("id_utente"));
        order.setTotalPrice(rs.getBigDecimal("total_price"));
        order.setTipoPagamento(rs.getString("tipo_pagamento"));
        order.setStatoOrdine(rs.getString("stato_ordine"));
        order.setIndirizzoSpedizione(rs.getString("indirizzo_spedizione"));
        return order;
    }

    private OrderItemBean mapOrderItem(ResultSet rs) throws SQLException {
        OrderItemBean item = new OrderItemBean();
        item.setIdDettaglio(rs.getInt("id_dettaglio"));
        item.setIdOrdine(rs.getInt("id_ordine"));

        int idProdotto = rs.getInt("id_prodotto");
        item.setIdProdotto(rs.wasNull() ? null : idProdotto);

        int idConcerto = rs.getInt("id_concerto");
        item.setIdConcerto(rs.wasNull() ? null : idConcerto);

        int quantitaProdotto = rs.getInt("quantita_prodotto");
        item.setQuantitaProdotto(rs.wasNull() ? null : quantitaProdotto);

        int quantitaBiglietti = rs.getInt("quantita_biglietti");
        item.setQuantitaBiglietti(rs.wasNull() ? null : quantitaBiglietti);

        item.setPrezzoTotale(rs.getBigDecimal("prezzo_totale"));
        item.setItemType(rs.getString("item_type"));
        item.setItemName(rs.getString("item_name"));
        item.setUnitPrice(rs.getBigDecimal("unit_price"));
        item.setIva(rs.getBigDecimal("iva"));
        return item;
    }
}
