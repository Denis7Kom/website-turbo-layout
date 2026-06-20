package com.turbolayout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");

        if (isEmpty(nome) || isEmpty(cognome) || isEmpty(email)
                || isEmpty(username) || isEmpty(password) || isEmpty(confirmPassword)) {

            request.setAttribute("error", "Compila tutti i campi obbligatori.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Le password non coincidono.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (terms == null) {
            request.setAttribute("error", "Devi accettare i Termini e la Privacy Policy.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        /*
            Qui dopo aggiungi:
            1. controllo se email già esiste
            2. hash della password
            3. salvataggio nel database, includendo anche il telefono se fornito
        */

        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?registered=true");
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}