package com.turbolayout;

import model.Cart;
import model.CartItem;
import model.ConcertoBean;
import model.ProductBean;
import model.dao.ConcertoDAO;
import model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private final ConcertoDAO concertoDAO = new ConcertoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Cart cart = getCart(session);
        synchronizeCartCount(session, cart);

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        Cart cart = getCart(session);
        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                addProduct(request, cart);
                synchronizeCartCount(session, cart);
                response.sendRedirect(request.getContextPath() + "/cart?added=true");
                return;
            }

            if ("addConcert".equalsIgnoreCase(action)) {
                addConcert(request, cart);
                synchronizeCartCount(session, cart);
                response.sendRedirect(request.getContextPath() + "/cart?added=true");
                return;
            }

            String cartKey = request.getParameter("cartKey");

            if ("remove".equalsIgnoreCase(action)) {
                cart.removeItem(cartKey);
            } else if ("increase".equalsIgnoreCase(action)) {
                cart.increaseQuantity(cartKey);
            } else if ("decrease".equalsIgnoreCase(action)) {
                cart.decreaseQuantity(cartKey);
            } else if ("clear".equalsIgnoreCase(action)) {
                cart.clear();
            }

            synchronizeCartCount(session, cart);
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (SQLException e) {
            throw new ServletException("Database error while updating cart", e);
        }
    }

    private void addProduct(HttpServletRequest request, Cart cart) throws SQLException {
        int idProdotto = parseInt(request.getParameter("idProdotto"), 0);
        int quantity = parseInt(request.getParameter("quantity"), 1);

        if (idProdotto <= 0) {
            return;
        }

        ProductBean product = productDAO.findById(idProdotto);

        if (product != null && product.isActive()) {
            cart.addProduct(product, quantity);
        }
    }

    private void addConcert(HttpServletRequest request, Cart cart) throws SQLException {
        int idConcerto = parseInt(request.getParameter("idConcerto"), 0);
        int quantity = parseInt(request.getParameter("quantity"), 1);

        if (idConcerto <= 0) {
            return;
        }

        ConcertoBean concert = concertoDAO.findById(idConcerto);

        if (concert != null && concert.isActive()) {
            CartItem item = new CartItem();
            item.setItemType(CartItem.TYPE_CONCERT);
            item.setIdConcerto(concert.getIdConcerto());
            item.setItemName(concert.getNome());
            item.setDescription(concert.getLuogo());
            item.setUnitPrice(concert.getPrezzo());
            item.setIva(concert.getIva());
            item.setQuantity(quantity);
            cart.addItem(item);
        }
    }

    private Cart getCart(HttpSession session) {
        Object cartObject = session.getAttribute("cart");

        if (cartObject instanceof Cart) {
            return (Cart) cartObject;
        }

        Cart cart = new Cart();
        session.setAttribute("cart", cart);
        return cart;
    }

    private void synchronizeCartCount(HttpSession session, Cart cart) {
        session.setAttribute("cartCount", cart.getTotalQuantity());
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return value == null ? defaultValue : Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
