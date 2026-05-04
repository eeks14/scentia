package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/admin/perfumes")
public class AdminPerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<Perfume> perfumes = new ArrayList<>();

        try(Connection conn = DBConfig.getConnection()) {

            String sql = "SELECT * FROM perfumes";

            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while(rs.next()) {

                Perfume perfume = new Perfume();

                perfume.setId(rs.getInt("id"));
                perfume.setName(rs.getString("name"));
                perfume.setBrand(rs.getString("brand"));
                perfume.setPrice(rs.getDouble("price"));
                perfume.setStock(rs.getInt("stock"));

                perfumes.add(perfume);
            }

            req.setAttribute("perfumes", perfumes);

            req.getRequestDispatcher("/WEB-INF/pages/adminPerfumes.jsp")
               .forward(req, res);

        } catch(Exception e) {

            e.printStackTrace();
        }
    }
}