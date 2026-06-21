package com.turbolayout;

import model.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/check-email")
public class CheckEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String email = request.getParameter("email");
        if (email != null) {
            email = email.trim();
        }

        boolean valid = email != null && email.contains("@") && email.contains(".");
        boolean available = false;

        try {
            available = valid && !userDAO.existsByEmail(email);
        } catch (SQLException e) {
            throw new ServletException("Database error while checking email", e);
        }

        response.getWriter().write("{\"valid\":" + valid + ",\"available\":" + available + "}");
    }
}
