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
import java.util.List;

@WebServlet("/merch")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<ProductBean> products = productDAO.findAllActive();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/jsp/merch.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading product catalog", e);
        }
    }
}
