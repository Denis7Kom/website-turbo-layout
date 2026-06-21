package com.turbolayout;

import model.OrderBean;
import model.dao.DataSourceProvider;
import model.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Integer idUtente = parseNullableInt(request.getParameter("idUtente"));
            Date fromDate = parseDate(request.getParameter("from"));
            Date toDate = parseDate(request.getParameter("to"));

            List<OrderBean> orders = (idUtente != null || fromDate != null || toDate != null)
                    ? orderDAO.findByFilters(idUtente, fromDate, toDate)
                    : orderDAO.findAll();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/jsp/admin/ad-orders.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading admin orders", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int idOrdine = parseInt(request.getParameter("idOrdine"), 0);
        String stato = request.getParameter("statoOrdine");

        if (idOrdine > 0 && stato != null && !stato.trim().isEmpty()) {
            try (Connection connection = DataSourceProvider.getConnection();
                 PreparedStatement statement = connection.prepareStatement("UPDATE ordine SET stato_ordine = ? WHERE id_ordine = ?")) {
                statement.setString(1, stato.trim());
                statement.setInt(2, idOrdine);
                statement.executeUpdate();
            } catch (SQLException e) {
                throw new ServletException("Database error while updating order status", e);
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private Integer parseNullableInt(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try { return Integer.parseInt(value.trim()); } catch (NumberFormatException e) { return null; }
    }

    private int parseInt(String value, int fallback) {
        try { return value == null ? fallback : Integer.parseInt(value.trim()); } catch (NumberFormatException e) { return fallback; }
    }

    private Date parseDate(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try { return Date.valueOf(value.trim()); } catch (IllegalArgumentException e) { return null; }
    }
}
