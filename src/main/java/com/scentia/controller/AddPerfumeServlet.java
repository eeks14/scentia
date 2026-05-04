package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/admin/addPerfume")
public class AddPerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;
        req.getRequestDispatcher("/WEB-INF/pages/addPerfume.jsp")
           .forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;

        String name    = req.getParameter("name");
        String brand   = req.getParameter("brand");
        String category = req.getParameter("category");
        String notes   = req.getParameter("notes");
        String imageUrl = req.getParameter("image_url");
        String description = req.getParameter("description");
        String vibe    = req.getParameter("vibe");

        // Validate vibe is one of the 4 allowed values
        if (!isValidVibe(vibe)) {
            req.setAttribute("error", "Vibe must be Soft, Bold, Sweet, or Fresh.");
            req.getRequestDispatcher("/WEB-INF/pages/addPerfume.jsp").forward(req, res);
            return;
        }

        double price;
        int stock;
        int sustainabilityScore;

        try {
            price              = Double.parseDouble(req.getParameter("price"));
            stock              = Integer.parseInt(req.getParameter("stock"));
            sustainabilityScore = Integer.parseInt(
                req.getParameter("sustainability_score") != null
                    ? req.getParameter("sustainability_score") : "5");
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Price, Stock, and Sustainability Score must be valid numbers.");
            req.getRequestDispatcher("/WEB-INF/pages/addPerfume.jsp").forward(req, res);
            return;
        }

        String sql =
            "INSERT INTO perfumes " +
            "(name, brand, category, notes, price, image_url, stock, description, sustainability_score, vibe) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, brand);
            stmt.setString(3, category);
            stmt.setString(4, notes);
            stmt.setDouble(5, price);
            stmt.setString(6, imageUrl);
            stmt.setInt(7, stock);
            stmt.setString(8, description);
            stmt.setInt(9, sustainabilityScore);
            stmt.setString(10, vibe);

            stmt.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=added");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to add perfume: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/addPerfume.jsp").forward(req, res);
        }
    }

    private boolean isValidVibe(String vibe) {
        return "Soft".equals(vibe) || "Bold".equals(vibe)
            || "Sweet".equals(vibe) || "Fresh".equals(vibe);
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        if (!"admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/home");
            return false;
        }
        return true;
    }
}
