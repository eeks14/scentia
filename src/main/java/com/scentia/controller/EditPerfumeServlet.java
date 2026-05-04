package com.scentia.controller;

import java.io.IOException;
import java.sql.*;

import com.scentia.config.DBConfig;
import com.scentia.model.Perfume;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/admin/editPerfume")
public class EditPerfumeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM perfumes WHERE id=?"
            );

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Perfume p = new Perfume();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));

                req.setAttribute("perfume", p);
            }

            req.getRequestDispatcher("/WEB-INF/pages/editPerfume.jsp")
               .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String brand = req.getParameter("brand");
        double price = Double.parseDouble(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE perfumes SET name=?, brand=?, price=?, stock=? WHERE id=?"
            );

            ps.setString(1, name);
            ps.setString(2, brand);
            ps.setDouble(3, price);
            ps.setInt(4, stock);
            ps.setInt(5, id);

            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=updated");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}