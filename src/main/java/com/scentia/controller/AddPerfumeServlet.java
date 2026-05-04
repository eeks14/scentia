package com.scentia.controller;

import com.scentia.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/admin/addPerfume")
public class AddPerfumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/pages/add-perfume.jsp")
           .forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String brand = req.getParameter("brand");

        double price =
            Double.parseDouble(req.getParameter("price"));

        int stock =
            Integer.parseInt(req.getParameter("stock"));

        try(Connection conn = DBConfig.getConnection()) {

            String sql =
                "INSERT INTO perfumes(name,brand,price,stock) VALUES(?,?,?,?)";

            PreparedStatement stmt =
                conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, brand);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);

            stmt.executeUpdate();

            res.sendRedirect(req.getContextPath()
                    + "/admin/perfumes");

        } catch(Exception e) {

            e.printStackTrace();
        }
    }
}