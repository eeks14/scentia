package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/confirmDelete")
public class ConfirmDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        req.setAttribute("id", id);

        req.getRequestDispatcher("WEB-INF/pages/deletePerfume.jsp")
           .forward(req, res);
    }
}