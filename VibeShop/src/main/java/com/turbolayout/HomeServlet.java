package com.turbolayout;

import model.ArtistBean;
import model.ConcertoBean;
import model.ProductBean;
import model.dao.ArtistDAO;
import model.dao.ConcertoDAO;
import model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();
    private final ConcertoDAO concertoDAO = new ConcertoDAO();
    private final ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ConcertoBean> concerts = concertoDAO.findAllActive();
            List<ArtistBean> artists = artistDAO.findFeatured(6);
            List<ProductBean> products = productDAO.findAllActive();

            request.setAttribute("featuredConcerts", concerts);
            request.setAttribute("featuredArtists", artists);
            request.setAttribute("featuredProducts", products);
        } catch (SQLException e) {
            request.setAttribute("featuredConcerts", Collections.<ConcertoBean>emptyList());
            request.setAttribute("featuredArtists", Collections.<ArtistBean>emptyList());
            request.setAttribute("featuredProducts", Collections.<ProductBean>emptyList());
            request.setAttribute("databaseWarning", "Database non disponibile: contenuti dinamici temporaneamente vuoti.");
        }

        request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
    }
}
