package com.turbolayout;

import model.ProductBean;
import model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String query = request.getParameter("q");
        if (query == null) {
            query = "";
        }
        query = query.trim();

        try {
            List<ProductBean> products = query.length() < 2 ? Collections.<ProductBean>emptyList() : productDAO.searchActiveByName(query);
            StringBuilder out = new StringBuilder("[");
            for (int i = 0; i < products.size(); i++) {
                ProductBean p = products.get(i);
                if (i > 0) {
                    out.append(',');
                }
                out.append('{');
                out.append("\"id\":").append(p.getIdProdotto()).append(',');
                out.append("\"name\":\"").append(p.getNome()).append("\",");
                out.append("\"price\":\"").append(p.getPrezzo()).append("\"");
                out.append('}');
            }
            out.append(']');
            response.getWriter().write(out.toString());
        } catch (SQLException e) {
            throw new ServletException("Database error while searching products", e);
        }
    }
}
