package com.scentia.controller;

import java.io.IOException;
import java.sql.*;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;
import com.scentia.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/admin/editPerfume")
public class EditPerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/admin/perfumes");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/admin/perfumes");
            return;
        }

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM perfumes WHERE id=?")) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Perfume p = new Perfume();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setCategory(rs.getString("category"));
                p.setNotes(rs.getString("notes"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStock(rs.getInt("stock"));
                p.setDescription(rs.getString("description"));
                p.setSustainabilityScore(rs.getInt("sustainability_score"));
                p.setVibe(rs.getString("vibe"));
                req.setAttribute("perfume", p);
            } else {
                res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=notfound");
                return;
            }

            req.getRequestDispatcher("/WEB-INF/pages/editPerfume.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;

        int id;
        double price;
        int stock;
        int sustainabilityScore;

        try {
            id                 = Integer.parseInt(req.getParameter("id"));
            price              = Double.parseDouble(req.getParameter("price"));
            stock              = Integer.parseInt(req.getParameter("stock"));
            sustainabilityScore = Integer.parseInt(
                req.getParameter("sustainability_score") != null
                    ? req.getParameter("sustainability_score") : "5");
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=error");
            return;
        }

        String name        = req.getParameter("name");
        String brand       = req.getParameter("brand");
        String category    = req.getParameter("category");
        String notes       = req.getParameter("notes");
        String imageUrl    = req.getParameter("image_url");
        String description = req.getParameter("description");
        String vibe        = req.getParameter("vibe");

        // Validate vibe
        if (!isValidVibe(vibe)) {
            res.sendRedirect(req.getContextPath() + "/admin/editPerfume?id=" + id + "&msg=badvibe");
            return;
        }

        String sql =
            "UPDATE perfumes SET name=?, brand=?, category=?, notes=?, " +
            "price=?, image_url=?, stock=?, description=?, " +
            "sustainability_score=?, vibe=? WHERE id=?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, brand);
            ps.setString(3, category);
            ps.setString(4, notes);
            ps.setDouble(5, price);
            ps.setString(6, imageUrl);
            ps.setInt(7, stock);
            ps.setString(8, description);
            ps.setInt(9, sustainabilityScore);
            ps.setString(10, vibe);
            ps.setInt(11, id);

            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=updated");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=error");
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
