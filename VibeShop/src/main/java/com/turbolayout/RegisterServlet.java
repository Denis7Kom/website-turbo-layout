package com.turbolayout;

import model.UserBean;
import model.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nome = trim(request.getParameter("nome"));
        String cognome = trim(request.getParameter("cognome"));
        String email = trim(request.getParameter("email"));
        String cellulare = trim(request.getParameter("cellulare"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isEmpty(nome) || isEmpty(cognome) || isEmpty(email) || isEmpty(password) || isEmpty(confirmPassword)) {
            forwardWithError(request, response, "Compila tutti i campi obbligatori.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            forwardWithError(request, response, "Le password non coincidono.");
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            forwardWithError(request, response, "Formato email non valido.");
            return;
        }

        if (password.length() < 8) {
            forwardWithError(request, response, "La password deve contenere almeno 8 caratteri.");
            return;
        }

        try {
            if (userDAO.existsByEmail(email)) {
                forwardWithError(request, response, "Email già registrata.");
                return;
            }

            UserBean user = new UserBean();
            user.setNome(nome);
            user.setCognome(cognome);
            user.setEmail(email);
            user.setCellulare(cellulare);

            userDAO.create(user, password);

            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?registered=true");

        } catch (SQLException e) {
            throw new ServletException("Database error during registration", e);
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
