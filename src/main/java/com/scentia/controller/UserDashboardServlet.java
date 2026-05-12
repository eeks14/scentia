package com.scentia.controller;

import com.scentia.config.DBConfig;
import com.scentia.model.User;
import com.scentia.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/profile")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Admins don't have a user profile — send to admin panel
        if ("admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/pages/userDashboard.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String newName     = req.getParameter("name");
        String newEmail    = req.getParameter("email");
        String newPassword = req.getParameter("password");

        // Basic validation
        if (newName == null || newName.trim().isEmpty() ||
            newEmail == null || newEmail.trim().isEmpty()) {
            req.setAttribute("error", "Name and email are required.");
            req.getRequestDispatcher("/WEB-INF/pages/userDashboard.jsp").forward(req, res);
            return;
        }

        newName  = newName.trim();
        newEmail = newEmail.trim();

        if (newPassword != null && !newPassword.trim().isEmpty() && newPassword.trim().length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.getRequestDispatcher("/WEB-INF/pages/userDashboard.jsp").forward(req, res);
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            PreparedStatement ps;

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                ps = conn.prepareStatement(
                    "UPDATE users SET name=?, email=?, password=? WHERE id=?");
                ps.setString(1, newName);
                ps.setString(2, newEmail);
                ps.setString(3,
                	    ValidationUtil.hashPassword(newPassword.trim()));
                ps.setInt(4, user.getId());
            } else {
                ps = conn.prepareStatement(
                    "UPDATE users SET name=?, email=? WHERE id=?");
                ps.setString(1, newName);
                ps.setString(2, newEmail);
                ps.setInt(3, user.getId());
            }

            ps.executeUpdate();

            // Sync session
            user.setName(newName);
            user.setEmail(newEmail);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                user.setPassword(newPassword.trim());
            }
            session.setAttribute("user", user);

            res.sendRedirect(req.getContextPath() + "/profile?msg=updated");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Update failed: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/userDashboard.jsp").forward(req, res);
        }
    }
}
