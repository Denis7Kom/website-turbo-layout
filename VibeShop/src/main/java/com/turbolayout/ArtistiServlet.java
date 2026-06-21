package com.turbolayout;

import model.ArtistBean;
import model.dao.ArtistDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/artisti")
public class ArtistiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ArtistBean> artists = artistDAO.findAll();
            request.setAttribute("artists", artists);
            request.getRequestDispatcher("/jsp/artisti.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading artists", e);
        }
    }
}
