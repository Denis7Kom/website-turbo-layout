package com.turbolayout;

import model.Cart;
import model.CartItem;
import model.OrderBean;
import model.OrderItemBean;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Cart cart = getCart(session);

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserBean user = getUser(session);
        Cart cart = getCart(session);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            OrderBean order = buildOrder(request, user, cart);
            int orderId = orderDAO.createOrder(order);

            cart.clear();
            session.setAttribute("cartCount", 0);

            request.setAttribute("orderCompleted", Boolean.TRUE);
            request.setAttribute("orderId", orderId);
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error while creating order", e);
        }
    }

    private OrderBean buildOrder(HttpServletRequest request, UserBean user, Cart cart) {
        String nome = trim(request.getParameter("nome"));
        String indirizzo = trim(request.getParameter("indirizzo"));
        String citta = trim(request.getParameter("citta"));
        String cap = trim(request.getParameter("cap"));
        String tipoPagamento = trim(request.getParameter("tipoPagamento"));

        if (tipoPagamento == null || tipoPagamento.isEmpty()) {
            tipoPagamento = "Carta";
        }

        String indirizzoCompleto = joinAddress(nome, indirizzo, citta, cap);

        OrderBean order = new OrderBean();
        order.setIdUtente(user.getIdUtente());
        order.setTotalPrice(cart.getTotalPrice());
        order.setTipoPagamento(tipoPagamento);
        order.setIndirizzoSpedizione(indirizzoCompleto);
        order.setItems(buildOrderItems(cart));

        return order;
    }

    private List<OrderItemBean> buildOrderItems(Cart cart) {
        List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();

        for (CartItem cartItem : cart.getItems()) {
            OrderItemBean item = new OrderItemBean();
            item.setIdProdotto(cartItem.getIdProdotto());
            item.setIdConcerto(cartItem.getIdConcerto());
            item.setQuantitaProdotto(cartItem.getIdProdotto() == null ? null : cartItem.getQuantity());
            item.setQuantitaBiglietti(cartItem.getIdConcerto() == null ? null : cartItem.getQuantity());
            item.setPrezzoTotale(cartItem.getSubtotal());
            item.setItemType(cartItem.getItemType());
            item.setItemName(cartItem.getItemName());
            item.setUnitPrice(cartItem.getUnitPrice());
            item.setIva(cartItem.getIva());
            orderItems.add(item);
        }

        return orderItems;
    }

    private UserBean getUser(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object userObject = session.getAttribute("user");
        return userObject instanceof UserBean ? (UserBean) userObject : null;
    }

    private Cart getCart(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object cartObject = session.getAttribute("cart");
        return cartObject instanceof Cart ? (Cart) cartObject : new Cart();
    }

    private String joinAddress(String nome, String indirizzo, String citta, String cap) {
        StringBuilder builder = new StringBuilder();

        appendPart(builder, nome);
        appendPart(builder, indirizzo);
        appendPart(builder, citta);
        appendPart(builder, cap);

        return builder.toString();
    }

    private void appendPart(StringBuilder builder, String value) {
        if (value == null || value.isEmpty()) {
            return;
        }

        if (builder.length() > 0) {
            builder.append(", ");
        }

        builder.append(value);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
