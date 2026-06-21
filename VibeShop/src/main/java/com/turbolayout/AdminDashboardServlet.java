package com.turbolayout;

import model.OrderBean;
import model.ProductBean;
import model.dao.OrderDAO;
import model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        try {
            List<OrderBean> orders = orderDAO.findAll();
            List<ProductBean> products = productDAO.findAllActive();
            BigDecimal revenue = BigDecimal.ZERO;

            for (OrderBean order : orders) {
                if (order.getTotalPrice() != null) {
                    revenue = revenue.add(order.getTotalPrice());
                }
            }

            request.setAttribute("orders", orders);
            request.setAttribute("orderCount", orders.size());
            request.setAttribute("productCount", products.size());
            request.setAttribute("revenue", revenue);
            request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading admin dashboard", e);
        }
    }
}
