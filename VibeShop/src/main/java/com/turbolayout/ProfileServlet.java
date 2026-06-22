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

@WebServlet({"/profile", "/profilo"})
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Object userObject = session == null ? null : session.getAttribute("user");

        if (!(userObject instanceof UserBean)) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        UserBean sessionUser = (UserBean) userObject;

        try {
            UserBean freshUser = userDAO.findById(sessionUser.getIdUtente());
            if (freshUser != null) {
                session.setAttribute("user", freshUser);
                session.setAttribute("utente", displayName(freshUser));
                session.setAttribute("role", freshUser.getRole());
            }
        } catch (SQLException e) {
            request.setAttribute("profileWarning", "Profilo mostrato dai dati di sessione: aggiornamento dal database non riuscito.");
        }

        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }

    private String displayName(UserBean user) {
        if (user.getUsername() != null && !user.getUsername().trim().isEmpty()) {
            return user.getUsername();
        }
        if (user.getNome() != null && !user.getNome().trim().isEmpty()) {
            return user.getNome();
        }
        return user.getEmail();
    }
}
