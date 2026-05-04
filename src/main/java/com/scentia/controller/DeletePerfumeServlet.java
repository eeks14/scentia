package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import com.scentia.config.DBConfig;

@WebServlet("/admin/deletePerfume")
public class DeletePerfumeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM perfumes WHERE id=?"
            );

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=deleted");
    }
}