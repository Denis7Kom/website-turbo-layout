package com.turbolayout;

import model.ProductBean;
import model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/products", "/admin/product-form", "/admin/products/save", "/admin/products/delete"})
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            if ("/admin/product-form".equals(path)) {
                String id = request.getParameter("id");
                if (id != null && !id.trim().isEmpty()) {
                    request.setAttribute("product", productDAO.findById(Integer.parseInt(id)));
                }
                request.getRequestDispatcher("/jsp/admin/product-form.jsp").forward(request, response);
                return;
            }

            List<ProductBean> products = productDAO.findAllActive();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/jsp/admin/products.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error in admin product area", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getServletPath();

        try {
            if ("/admin/products/delete".equals(path)) {
                int id = parseInt(request.getParameter("id"), 0);
                if (id > 0) {
                    productDAO.setActive(id, false);
                }
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            ProductBean product = buildProduct(request);
            if (product.getIdProdotto() > 0) {
                productDAO.update(product);
            } else {
                productDAO.create(product);
            }
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (SQLException e) {
            throw new ServletException("Database error while saving product", e);
        }
    }

    private ProductBean buildProduct(HttpServletRequest request) {
        ProductBean product = new ProductBean();
        product.setIdProdotto(parseInt(request.getParameter("idProdotto"), 0));
        product.setActive(true);
        product.setNome(firstNonBlank(request.getParameter("nome"), request.getParameter("nomeProdotto")));
        product.setIdArtista(parseNullableInt(request.getParameter("idArtista")));
        product.setPrezzo(parseDecimal(request.getParameter("prezzo"), "0.00"));
        product.setIva(parseDecimal(request.getParameter("iva"), "22.00"));
        product.setDescrizione(request.getParameter("descrizione"));
        product.setImmagine(request.getParameter("immagine"));
        return product;
    }

    private String firstNonBlank(String first, String second) {
        if (first != null && !first.trim().isEmpty()) {
            return first.trim();
        }
        return second == null ? "" : second.trim();
    }

    private Integer parseNullableInt(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return parseInt(value, 0);
    }

    private int parseInt(String value, int fallback) {
        try {
            return value == null ? fallback : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private BigDecimal parseDecimal(String value, String fallback) {
        try {
            return new BigDecimal(value == null || value.trim().isEmpty() ? fallback : value.trim());
        } catch (NumberFormatException e) {
            return new BigDecimal(fallback);
        }
    }
}
