package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

/**
 * AdminPerfumeServlet – /admin/perfumes
 *
 * FIXES:
 *  1. ResultSet was not reading the "vibe" column.
 *  2. Added session guard.
 */
@WebServlet("/admin/perfumes")
public class AdminPerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ArrayList<Perfume> perfumes = new ArrayList<>();

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM perfumes ORDER BY id DESC"
            );
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Perfume p = new Perfume();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setVibe(rs.getString("vibe"));   

                perfumes.add(p);
            }

            req.setAttribute("perfumes", perfumes);
            req.getRequestDispatcher("/WEB-INF/pages/adminPerfumes.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin");
        }
    }
}