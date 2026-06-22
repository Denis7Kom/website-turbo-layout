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
import java.time.YearMonth;
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

        String validationError = validateCheckout(request);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
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

    private String validateCheckout(HttpServletRequest request) {
        String nome = trim(request.getParameter("nome"));
        String indirizzo = trim(request.getParameter("indirizzo"));
        String citta = trim(request.getParameter("citta"));
        String cap = trim(request.getParameter("cap"));
        String cardHolder = trim(request.getParameter("cardHolder"));
        String cardNumber = trim(request.getParameter("cardNumber"));
        String expiry = trim(request.getParameter("expiry"));
        String cvv = trim(request.getParameter("cvv"));

        if (isEmpty(nome) || isEmpty(indirizzo) || isEmpty(citta) || isEmpty(cap)) {
            return "Compila tutti i campi dell'indirizzo di spedizione.";
        }

        if (!cap.matches("\\d{5}")) {
            return "Il CAP deve contenere esattamente 5 cifre.";
        }

        if (isEmpty(cardHolder) || isEmpty(cardNumber) || isEmpty(expiry) || isEmpty(cvv)) {
            return "Compila tutti i campi di pagamento.";
        }

        if (!cardNumber.matches("\\d{16}")) {
            return "Il numero carta deve contenere esattamente 16 cifre.";
        }

        if (!cvv.matches("\\d{3}")) {
            return "Il CVV deve contenere esattamente 3 cifre.";
        }

        String expiryError = validateExpiry(expiry);
        if (expiryError != null) {
            return expiryError;
        }

        return null;
    }

    private String validateExpiry(String expiry) {
        if (expiry == null || !expiry.matches("[0-9]{2}/[0-9]{2}")) {
            return "La scadenza della carta deve essere nel formato MM/YY.";
        }

        try {
            int month = Integer.parseInt(expiry.substring(0, 2));
            int year = 2000 + Integer.parseInt(expiry.substring(3, 5));

            if (month < 1 || month > 12) {
                return "Il mese di scadenza non può essere superiore a 12.";
            }

            YearMonth expiryMonth = YearMonth.of(year, month);
            if (expiryMonth.isBefore(YearMonth.now())) {
                return "La scadenza della carta è già passata.";
            }

            return null;
        } catch (RuntimeException e) {
            return "La scadenza della carta non è valida.";
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
            item.setQuantitaProdotto(cartItem.getIdProdotto() == null ? 0 : cartItem.getQuantity());
            item.setQuantitaBiglietti(cartItem.getIdConcerto() == null ? 0 : cartItem.getQuantity());
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

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
