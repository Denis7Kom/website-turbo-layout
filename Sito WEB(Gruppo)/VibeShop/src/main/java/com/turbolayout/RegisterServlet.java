package com.turbolayout;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");

        // 1. Controllo campi vuoti
        if (isEmpty(nome) || isEmpty(cognome) || isEmpty(email)
                || isEmpty(username) || isEmpty(password) || isEmpty(confirmPassword)) {

            request.setAttribute("error", "Compila tutti i campi obbligatori.");
            // CORRETTO: punta alla cartella /jsp/
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        // 2. Controllo coincidenza password
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Le password non coincidono.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        // 3. Controllo termini
        if (terms == null) {
            request.setAttribute("error", "Devi accettare i Termini e la Privacy Policy.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        /*
            Qui dopo aggiungerai:
            1. Controllo se email/username già esiste nel DB
            2. Hash della password (usa BCrypt!)
            3. Salvataggio nel database
        */

        // Reindirizzamento corretto dopo successo
        // Assicurati che login.jsp sia effettivamente in /jsp/login.jsp
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?registered=true");
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
