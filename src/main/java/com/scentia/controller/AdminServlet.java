package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (!"admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            // Total perfumes
            ResultSet rs1 = conn.prepareStatement("SELECT COUNT(*) FROM perfumes").executeQuery();
            int totalPerfumes = rs1.next() ? rs1.getInt(1) : 0;

            // Total users
            ResultSet rs2 = conn.prepareStatement("SELECT COUNT(*) FROM users").executeQuery();
            int totalUsers = rs2.next() ? rs2.getInt(1) : 0;

            // Low stock (stock <= 5)
            ResultSet rs3 = conn.prepareStatement("SELECT COUNT(*) FROM perfumes WHERE stock <= 5").executeQuery();
            int lowStock = rs3.next() ? rs3.getInt(1) : 0;

            req.setAttribute("totalPerfumes", totalPerfumes);
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("lowStock", lowStock);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("totalPerfumes", 0);
            req.setAttribute("totalUsers", 0);
            req.setAttribute("lowStock", 0);
        }

        req.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(req, res);
    }
}
