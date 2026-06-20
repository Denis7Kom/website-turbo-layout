package com.turbolayout;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String login = request.getParameter("login");
        String password = request.getParameter("password");

        if (isEmpty(login) || isEmpty(password)) {
            request.setAttribute("error", "Inserisci email/username e password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        /*
            TEMPORANEO:
            Questa è solo una verifica fittizia.
            Dopo va sostituita con:
            1. ricerca utente nel database
            2. confronto password con hash
            3. creazione sessione reale
        */
        if ("admin".equals(login) && "admin123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", login);

            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        request.setAttribute("error", "Credenziali non valide.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}