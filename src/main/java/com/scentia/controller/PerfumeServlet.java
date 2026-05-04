package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/perfume")
public class PerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                        HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<Perfume> perfumes = new ArrayList<>();

        String search = req.getParameter("search");   // from vibe click
        String vibe = req.getParameter("vibe");       // optional future use

        try (Connection conn = DBConfig.getConnection()) {

        	String vibe1 = req.getParameter("vibe");
        	String search1 = req.getParameter("search");

        	String sql;
        	PreparedStatement stmt;

        	// PRIORITY 1: VIBE FILTER
        	if (vibe1 != null && !vibe1.trim().isEmpty()) {

        	    sql = "SELECT * FROM perfumes WHERE vibe = ?";
        	    stmt = conn.prepareStatement(sql);
        	    stmt.setString(1, vibe1);

        	}

        	// PRIORITY 2: SEARCH FILTER
        	else if (search1 != null && !search1.trim().isEmpty()) {

        	    sql = "SELECT * FROM perfumes WHERE LOWER(name) LIKE ? OR LOWER(brand) LIKE ?";
        	    stmt = conn.prepareStatement(sql);

        	    String keyword = "%" + search1.toLowerCase() + "%";
        	    stmt.setString(1, keyword);
        	    stmt.setString(2, keyword);

        	}

        	// DEFAULT
        	else {
        	    sql = "SELECT * FROM perfumes";
        	    stmt = conn.prepareStatement(sql);
        	}

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                Perfume perfume = new Perfume();

                perfume.setId(rs.getInt("id"));
                perfume.setName(rs.getString("name"));
                perfume.setBrand(rs.getString("brand"));
                perfume.setCategory(rs.getString("category"));
                perfume.setNotes(rs.getString("notes"));
                perfume.setPrice(rs.getDouble("price"));
                perfume.setImageUrl(rs.getString("image_url"));
                perfume.setStock(rs.getInt("stock"));
                perfume.setDescription(rs.getString("description"));
                perfume.setSustainabilityScore(rs.getInt("sustainability_score"));

                perfumes.add(perfume);
            }

            req.setAttribute("perfumes", perfumes);

            req.getRequestDispatcher("/WEB-INF/pages/viewPerfume.jsp")
               .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}