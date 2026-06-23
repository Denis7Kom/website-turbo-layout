package com.turbolayout;

import model.ArtistBean;
import model.dao.ArtistDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/artists", "/admin/artist-form", "/admin/artists/save", "/admin/artists/delete"})
public class AdminArtistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) {
            return;
        }

        String path = request.getServletPath();

        try {
            if ("/admin/artist-form".equals(path)) {
                int id = parseInt(request.getParameter("id"), 0);
                if (id > 0) {
                    request.setAttribute("artist", artistDAO.findById(id));
                }
                request.getRequestDispatcher("/jsp/admin/artist-form.jsp").forward(request, response);
                return;
            }

            List<ArtistBean> artists = artistDAO.findAll();
            request.setAttribute("artists", artists);
            request.getRequestDispatcher("/jsp/admin/artists.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error in admin artist area", e);
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
            if ("/admin/artists/delete".equals(path)) {
                int id = parseInt(request.getParameter("id"), 0);
                if (id > 0) {
                    artistDAO.delete(id);
                    response.sendRedirect(request.getContextPath() + "/admin/artists?artistAction=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/artists?artistAction=delete-error");
                }
                return;
            }

            ArtistBean artist = buildArtist(request);
            String validationError = validateArtist(artist);
            if (validationError != null) {
                request.setAttribute("error", validationError);
                request.setAttribute("artist", artist);
                request.getRequestDispatcher("/jsp/admin/artist-form.jsp").forward(request, response);
                return;
            }

            if (artist.getIdArtista() > 0) {
                artistDAO.update(artist);
                response.sendRedirect(request.getContextPath() + "/admin/artists?artistAction=updated");
            } else {
                artistDAO.create(artist);
                response.sendRedirect(request.getContextPath() + "/admin/artists?artistAction=created");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error while saving artist", e);
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

    private ArtistBean buildArtist(HttpServletRequest request) {
        ArtistBean artist = new ArtistBean();
        artist.setIdArtista(parseInt(request.getParameter("idArtista"), 0));
        artist.setNomeArte(trim(request.getParameter("nomeArte")));
        artist.setPaese(trim(request.getParameter("paese")));
        artist.setGenere(trim(request.getParameter("genere")));
        artist.setFoto(trim(request.getParameter("foto")));
        artist.setBiografia(trim(request.getParameter("biografia")));
        return artist;
    }

    private String validateArtist(ArtistBean artist) {
        if (artist.getNomeArte() == null || artist.getNomeArte().trim().isEmpty()) {
            return "Il nome d'arte è obbligatorio.";
        }
        return null;
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
