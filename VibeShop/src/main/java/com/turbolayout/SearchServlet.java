package com.turbolayout;

import model.dao.DataSourceProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("q");
        boolean ajax = true;

        if (query == null) {
            query = request.getParameter("ricerca");
            ajax = false;
        }

        if (query == null) {
            query = "";
        }

        query = query.trim();

        try {
            List<SearchResult> results = query.length() < 2 ? new ArrayList<SearchResult>() : searchAll(query);

            if (!ajax) {
                request.setAttribute("results", results);
                request.setAttribute("searchQuery", query);
                request.getRequestDispatcher("/jsp/search-results.jsp").forward(request, response);
                return;
            }

            response.setContentType("application/json");
            response.getWriter().write(toJson(results));
        } catch (SQLException e) {
            throw new ServletException("Database error while searching", e);
        }
    }

    private List<SearchResult> searchAll(String query) throws SQLException {
        List<SearchResult> results = new ArrayList<SearchResult>();
        String like = "%" + query + "%";

        try (Connection connection = DataSourceProvider.getConnection()) {
            searchProducts(connection, like, results);
            searchArtists(connection, like, results);
            searchConcerts(connection, like, results);
        }

        return results;
    }

    private void searchProducts(Connection connection, String like, List<SearchResult> results) throws SQLException {
        String sql = "SELECT id_prodotto, nome, descrizione FROM prodotto WHERE active = true AND (nome LIKE ? OR descrizione LIKE ?) ORDER BY nome LIMIT 8";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, like);
            statement.setString(2, like);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    results.add(new SearchResult("Merch", rs.getString("nome"), rs.getString("descrizione"), "/product?id=" + rs.getInt("id_prodotto")));
                }
            }
        }
    }

    private void searchArtists(Connection connection, String like, List<SearchResult> results) throws SQLException {
        String sql = "SELECT nome_d_arte, genere, paese FROM artista WHERE nome_d_arte LIKE ? OR genere LIKE ? OR paese LIKE ? ORDER BY nome_d_arte LIMIT 8";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, like);
            statement.setString(2, like);
            statement.setString(3, like);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    String subtitle = join(rs.getString("genere"), rs.getString("paese"));
                    results.add(new SearchResult("Artista", rs.getString("nome_d_arte"), subtitle, "/artisti"));
                }
            }
        }
    }

    private void searchConcerts(Connection connection, String like, List<SearchResult> results) throws SQLException {
        String sql = "SELECT titolo_evento, luogo_indirizzo FROM concerto WHERE titolo_evento LIKE ? OR luogo_indirizzo LIKE ? ORDER BY data_ora LIMIT 8";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, like);
            statement.setString(2, like);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    results.add(new SearchResult("Concerto", rs.getString("titolo_evento"), rs.getString("luogo_indirizzo"), "/concerti"));
                }
            }
        }
    }

    private String toJson(List<SearchResult> results) {
        StringBuilder out = new StringBuilder("[");
        for (int i = 0; i < results.size(); i++) {
            SearchResult item = results.get(i);
            if (i > 0) {
                out.append(',');
            }
            out.append('{')
                    .append("\"type\":\"").append(jsonEscape(item.type)).append("\",")
                    .append("\"title\":\"").append(jsonEscape(item.title)).append("\",")
                    .append("\"subtitle\":\"").append(jsonEscape(item.subtitle)).append("\",")
                    .append("\"url\":\"").append(jsonEscape(item.url)).append("\"")
                    .append('}');
        }
        out.append(']');
        return out.toString();
    }

    private String join(String first, String second) {
        if (first == null || first.trim().isEmpty()) {
            return second == null ? "" : second;
        }
        if (second == null || second.trim().isEmpty()) {
            return first;
        }
        return first + " · " + second;
    }

    private String jsonEscape(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"").replace("\r", "\\r").replace("\n", "\\n");
    }

    public static class SearchResult {
        private final String type;
        private final String title;
        private final String subtitle;
        private final String url;

        public SearchResult(String type, String title, String subtitle, String url) {
            this.type = type;
            this.title = title;
            this.subtitle = subtitle;
            this.url = url;
        }

        public String getType() {
            return type;
        }

        public String getTitle() {
            return title;
        }

        public String getSubtitle() {
            return subtitle;
        }

        public String getUrl() {
            return url;
        }
    }
}
