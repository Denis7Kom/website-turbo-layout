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
import java.util.regex.Pattern;

@WebServlet({"/account/edit", "/account/update"})
public class AccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,63}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\+?[0-9 .()\\-]{7,20}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9._-]{3,30}$");

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        refreshSessionUser(request);
        request.getRequestDispatcher("/jsp/modifica-profilo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserBean currentUser = session == null ? null : (UserBean) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        String nome = trim(request.getParameter("nome"));
        String cognome = trim(request.getParameter("cognome"));
        String username = trim(request.getParameter("username"));
        String email = trim(request.getParameter("email"));
        String telefono = trim(request.getParameter("telefono"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isEmpty(nome) || isEmpty(cognome) || isEmpty(username) || isEmpty(email) || isEmpty(telefono)) {
            forwardWithError(request, response, "Compila tutti i dati obbligatori.");
            return;
        }

        if (!USERNAME_PATTERN.matcher(username).matches()) {
            forwardWithError(request, response, "Lo username deve avere 3-30 caratteri e può contenere lettere, numeri, punto, trattino e underscore.");
            return;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            forwardWithError(request, response, "Inserisci un indirizzo email valido.");
            return;
        }

        if (!PHONE_PATTERN.matcher(telefono).matches() || countDigits(telefono) < 7) {
            forwardWithError(request, response, "Inserisci un numero di telefono valido.");
            return;
        }

        boolean changePassword = !isEmpty(newPassword) || !isEmpty(confirmPassword);

        if (changePassword) {
            if (newPassword == null || newPassword.length() < 8) {
                forwardWithError(request, response, "La nuova password deve contenere almeno 8 caratteri.");
                return;
            }
            if (!newPassword.equals(confirmPassword)) {
                forwardWithError(request, response, "Le nuove password non coincidono.");
                return;
            }
        }

        try {
            if (userDAO.existsByEmailForOtherUser(email, currentUser.getIdUtente())) {
                forwardWithError(request, response, "Email già usata da un altro account.");
                return;
            }

            if (userDAO.existsByUsernameForOtherUser(username, currentUser.getIdUtente())) {
                forwardWithError(request, response, "Username già usato da un altro account.");
                return;
            }

            currentUser.setNome(nome);
            currentUser.setCognome(cognome);
            currentUser.setUsername(username);
            currentUser.setEmail(email);
            currentUser.setCellulare(telefono);

            userDAO.updateProfile(currentUser);

            if (changePassword) {
                userDAO.updatePassword(currentUser.getIdUtente(), newPassword);
            }

            UserBean updatedUser = userDAO.findById(currentUser.getIdUtente());
            session.setAttribute("user", updatedUser);
            session.setAttribute("utente", updatedUser.getUsername());
            session.setAttribute("role", updatedUser.getRole());

            response.sendRedirect(request.getContextPath() + "/profile?updated=true");
        } catch (SQLException e) {
            throw new ServletException("Database error while updating account", e);
        }
    }

    private void refreshSessionUser(HttpServletRequest request) throws ServletException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }

        Object userObject = session.getAttribute("user");
        if (!(userObject instanceof UserBean)) {
            return;
        }

        UserBean user = (UserBean) userObject;

        try {
            UserBean freshUser = userDAO.findById(user.getIdUtente());
            if (freshUser != null) {
                session.setAttribute("user", freshUser);
                session.setAttribute("utente", freshUser.getUsername());
                session.setAttribute("role", freshUser.getRole());
            }
        } catch (SQLException e) {
            throw new ServletException("Database error while loading account", e);
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher("/jsp/modifica-profilo.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private int countDigits(String value) {
        int count = 0;
        for (int i = 0; i < value.length(); i++) {
            if (Character.isDigit(value.charAt(i))) {
                count++;
            }
        }
        return count;
    }
}
