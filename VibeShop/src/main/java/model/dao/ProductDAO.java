package model.dao;

import model.ProductBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<ProductBean> findAllActive() throws SQLException {
        String sql = "SELECT id_prodotto, active, nome, id_artista, prezzo, iva, descrizione, immagine "
                + "FROM prodotto WHERE active = TRUE ORDER BY nome";

        List<ProductBean> products = new ArrayList<ProductBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }

        return products;
    }

    public ProductBean findById(int idProdotto) throws SQLException {
        String sql = "SELECT id_prodotto, active, nome, id_artista, prezzo, iva, descrizione, immagine "
                + "FROM prodotto WHERE id_prodotto = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProdotto);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
                return null;
            }
        }
    }

    public List<ProductBean> searchActiveByName(String query) throws SQLException {
        String sql = "SELECT id_prodotto, active, nome, id_artista, prezzo, iva, descrizione, immagine "
                + "FROM prodotto WHERE active = TRUE AND nome LIKE ? ORDER BY nome LIMIT 10";

        List<ProductBean> products = new ArrayList<ProductBean>();

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + query + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public int create(ProductBean product) throws SQLException {
        String sql = "INSERT INTO prodotto (active, nome, id_artista, prezzo, iva, descrizione, immagine) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            fillProductStatement(ps, product, false);
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        }

        return 0;
    }

    public void update(ProductBean product) throws SQLException {
        String sql = "UPDATE prodotto SET active = ?, nome = ?, id_artista = ?, prezzo = ?, iva = ?, "
                + "descrizione = ?, immagine = ? WHERE id_prodotto = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            fillProductStatement(ps, product, true);
            ps.executeUpdate();
        }
    }

    public void setActive(int idProdotto, boolean active) throws SQLException {
        String sql = "UPDATE prodotto SET active = ? WHERE id_prodotto = ?";

        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }

    private void fillProductStatement(PreparedStatement ps, ProductBean product, boolean includeId)
            throws SQLException {

        ps.setBoolean(1, product.isActive());
        ps.setString(2, product.getNome());

        if (product.getIdArtista() == null) {
            ps.setNull(3, Types.INTEGER);
        } else {
            ps.setInt(3, product.getIdArtista());
        }

        ps.setBigDecimal(4, product.getPrezzo());
        ps.setBigDecimal(5, product.getIva());
        ps.setString(6, product.getDescrizione());
        ps.setString(7, product.getImmagine());

        if (includeId) {
            ps.setInt(8, product.getIdProdotto());
        }
    }

    private ProductBean mapProduct(ResultSet rs) throws SQLException {
        ProductBean product = new ProductBean();
        product.setIdProdotto(rs.getInt("id_prodotto"));
        product.setActive(rs.getBoolean("active"));
        product.setNome(rs.getString("nome"));

        int idArtista = rs.getInt("id_artista");
        product.setIdArtista(rs.wasNull() ? null : idArtista);

        product.setPrezzo(rs.getBigDecimal("prezzo"));
        product.setIva(rs.getBigDecimal("iva"));
        product.setDescrizione(rs.getString("descrizione"));
        product.setImmagine(rs.getString("immagine"));
        return product;
    }
}
