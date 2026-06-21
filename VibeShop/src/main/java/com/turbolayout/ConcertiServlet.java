package com.turbolayout;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ConcertoBean;
import model.dao.ConcertoDAO;

@WebServlet("/concerti")
public class ConcertiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ConcertoDAO dao = new ConcertoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ConcertoBean> list = dao.findAllActive();
            request.setAttribute("concerts", list);
            request.getRequestDispatcher("/jsp/concerti.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Errore caricamento concerti", e);
        }
    }
}
