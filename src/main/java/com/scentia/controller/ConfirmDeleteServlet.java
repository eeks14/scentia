package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * ConfirmDeleteServlet – /confirmDelete
 *
 * FIXES:
 *  1. Forward path was "WEB-INF/pages/deletePerfume.jsp" (missing leading slash).
 *     Corrected to "/WEB-INF/pages/deletePerfume.jsp".
 *  2. Added session guard.
 */
@WebServlet("/confirmDelete")
public class ConfirmDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String id = req.getParameter("id");
        req.setAttribute("id", id);

        
        req.getRequestDispatcher("/WEB-INF/pages/deletePerfume.jsp").forward(req, res);
    }
}