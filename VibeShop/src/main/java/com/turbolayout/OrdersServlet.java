package com.turbolayout;

import model.OrderBean;
import model.UserBean;
import model.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserBean user = getUser(session);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        try {
            List<OrderBean> orders = orderDAO.findByUserId(user.getIdUtente());

            for (OrderBean order : orders) {
                order.setItems(orderDAO.findItemsByOrderId(order.getIdOrdine()));
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/jsp/orders.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error while loading orders", e);
        }
    }

    private UserBean getUser(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object userObject = session.getAttribute("user");
        return userObject instanceof UserBean ? (UserBean) userObject : null;
    }
}
