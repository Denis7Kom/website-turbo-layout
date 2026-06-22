package com.turbolayout;

import model.ConcertoBean;
import model.dao.ConcertoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/concerts", "/admin/concert-form", "/admin/concerts/save", "/admin/concerts/delete"})
public class AdminConcertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ConcertoDAO concertoDAO = new ConcertoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        String path = request.getServletPath();

        try {
            if ("/admin/concert-form".equals(path)) {
                int id = parseInt(request.getParameter("id"), 0);
                if (id > 0) {
                    request.setAttribute("concert", concertoDAO.findById(id));
                }
                request.getRequestDispatcher("/jsp/admin/concert-form.jsp").forward(request, response);
                return;
            }

            List<ConcertoBean> concerts = concertoDAO.findAllActive();
            request.setAttribute("concerts", concerts);
            request.getRequestDispatcher("/jsp/admin/concerts.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error in admin concert area", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String path = request.getServletPath();

        try {
            if ("/admin/concerts/delete".equals(path)) {
                int id = parseInt(request.getParameter("id"), 0);
                if (id > 0) {
                    concertoDAO.delete(id);
                    response.sendRedirect(request.getContextPath() + "/admin/concerts?message=concert-removed");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/concerts?message=invalid-id");
                }
                return;
            }

            ConcertoBean concert = buildConcert(request);
            boolean editing = concert.getIdConcerto() > 0;
            String validationError = validateConcert(concert);
            if (validationError != null) {
                request.setAttribute("error", validationError);
                request.setAttribute("concert", concert);
                request.getRequestDispatcher("/jsp/admin/concert-form.jsp").forward(request, response);
                return;
            }

            if (editing) {
                concertoDAO.update(concert);
            } else {
                concertoDAO.create(concert);
            }

            response.sendRedirect(request.getContextPath() + "/admin/concerts?message=" + (editing ? "concert-updated" : "concert-created"));
        } catch (SQLException e) {
            throw new ServletException("Database error while saving concert", e);
        }
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null && "ADMIN".equals(session.getAttribute("role"))) {
            return true;
        }

        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?auth=required");
        return false;
    }

    private ConcertoBean buildConcert(HttpServletRequest request) {
        ConcertoBean concert = new ConcertoBean();
        concert.setIdConcerto(parseInt(request.getParameter("idConcerto"), 0));
        concert.setNome(trim(request.getParameter("titoloEvento")));
        concert.setLuogo(trim(request.getParameter("luogoIndirizzo")));
        concert.setDescrizione(trim(request.getParameter("eventManager")));
        concert.setIdArtista(parseNullableInt(request.getParameter("idArtista")));
        concert.setPrezzo(parseDecimal(request.getParameter("prezzo"), null));
        concert.setIva(parseDecimal(request.getParameter("iva"), new BigDecimal("10.00")));
        concert.setDataEvento(parseDateTime(request.getParameter("dataOra")));
        concert.setActive(true);
        return concert;
    }

    private String validateConcert(ConcertoBean concert) {
        if (concert.getNome() == null || concert.getNome().trim().isEmpty()) {
            return "Il titolo del concerto è obbligatorio.";
        }

        if (concert.getDataEvento() == null) {
            return "La data e l'orario del concerto sono obbligatori.";
        }

        if (concert.getLuogo() == null || concert.getLuogo().trim().isEmpty()) {
            return "Il luogo del concerto è obbligatorio.";
        }

        if (concert.getPrezzo() == null || concert.getPrezzo().compareTo(BigDecimal.ZERO) <= 0) {
            return "Il prezzo del biglietto deve essere maggiore di zero.";
        }

        if (concert.getIva() == null || concert.getIva().compareTo(BigDecimal.ZERO) < 0) {
            return "L'IVA non può essere negativa.";
        }

        return null;
    }

    private Timestamp parseDateTime(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        try {
            return Timestamp.valueOf(LocalDateTime.parse(value.trim()));
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private Integer parseNullableInt(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return parseInt(value, 0);
    }

    private BigDecimal parseDecimal(String value, BigDecimal fallback) {
        try {
            if (value == null || value.trim().isEmpty()) {
                return fallback;
            }
            return new BigDecimal(value.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private int parseInt(String value, int fallback) {
        try {
            return value == null ? fallback : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
