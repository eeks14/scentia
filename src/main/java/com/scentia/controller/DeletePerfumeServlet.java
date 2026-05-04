package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

import com.scentia.config.DBConfig;
import com.scentia.model.User;

@WebServlet("/admin/deletePerfume")
public class DeletePerfumeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

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

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=invalid");
            return;
        }

        int id = Integer.parseInt(idParam);

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM perfumes WHERE id=?")) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=error");
            return;
        }

        res.sendRedirect(req.getContextPath() + "/admin/perfumes?msg=deleted");
    }
}
