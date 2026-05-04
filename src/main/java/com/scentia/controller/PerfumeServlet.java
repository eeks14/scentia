package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;
import com.scentia.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/perfume")
public class PerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ACCESS CONTROL
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ArrayList<Perfume> perfumes = new ArrayList<>();

        String vibe   = req.getParameter("vibe");
        String search = req.getParameter("search");

        // Normalise to null if blank
        if (vibe   != null && vibe.trim().isEmpty())   vibe   = null;
        if (search != null && search.trim().isEmpty())  search = null;

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement stmt;

            // PRIORITY 1 – vibe filter (case-insensitive; only 4 valid vibes)
            if (vibe != null) {
                String sql = "SELECT * FROM perfumes WHERE LOWER(vibe) = LOWER(?) ORDER BY name";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, vibe.trim());
            }
            // PRIORITY 2 – full-text keyword search across name, brand, notes, category
            else if (search != null) {
                String sql =
                    "SELECT * FROM perfumes WHERE " +
                    "LOWER(name)     LIKE ? OR " +
                    "LOWER(brand)    LIKE ? OR " +
                    "LOWER(notes)    LIKE ? OR " +
                    "LOWER(category) LIKE ? " +
                    "ORDER BY name";
                stmt = conn.prepareStatement(sql);
                String kw = "%" + search.trim().toLowerCase() + "%";
                stmt.setString(1, kw);
                stmt.setString(2, kw);
                stmt.setString(3, kw);
                stmt.setString(4, kw);
            }
            // DEFAULT – return everything
            else {
                stmt = conn.prepareStatement("SELECT * FROM perfumes ORDER BY name");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
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
                    perfumes.add(p);
                }
            }

            stmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("perfumes",       perfumes);
        req.setAttribute("currentVibe",    vibe);
        req.setAttribute("currentSearch",  search);

        req.getRequestDispatcher("/WEB-INF/pages/viewPerfume.jsp").forward(req, res);
    }
}
