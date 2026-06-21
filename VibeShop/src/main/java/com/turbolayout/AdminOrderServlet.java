package com.turbolayout;

import model.OrderBean;
import model.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
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

            List<OrderBean> orders;
            if (idUtente != null || fromDate != null || toDate != null) {
                orders = orderDAO.findByFilters(idUtente, fromDate, toDate);
            } else {
                orders = orderDAO.findAll();
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/jsp/admin/ad-orders.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading admin orders", e);
        }
    }

    private Integer parseNullableInt(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private Date parseDate(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Date.valueOf(value.trim());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}
