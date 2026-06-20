package com.turbolayout;

import model.UserBean;
import model.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = trim(request.getParameter("login"));
        String password = request.getParameter("password");

        if (isEmpty(email) || isEmpty(password)) {
            forwardWithError(request, response, "Inserisci email e password.");
            return;
        }

        try {
            UserBean user = userDAO.findByEmailAndPassword(email, password);

            if (user == null) {
                forwardWithError(request, response, "Credenziali non valide.");
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            response.sendRedirect(request.getContextPath() + "/homepage.jsp");

        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
