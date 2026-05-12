package com.scentia.controller;

import com.scentia.config.DBConfig;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import com.scentia.util.ValidationUtil;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = req.getParameter("role");

       
        if (role == null || role.isEmpty()) {
            role = "user";
        }

        
        if (name == null || email == null || password == null || confirmPassword == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {

            req.setAttribute("error", "All fields are required!");
            req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }
        if (!ValidationUtil.isValidName(name)) {
            req.setAttribute("error",
                    "Full name must contain letters only!");

            req.getRequestDispatcher("WEB-INF/pages/register.jsp")
                    .forward(req, res);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match!");
            req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            req.setAttribute("error", "Password must be at least 6 characters!");
            req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            if (conn == null) {
                throw new Exception("Database connection failed!");
            }

            // Check duplicate
            String checkQuery = "SELECT email FROM users WHERE email=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                req.setAttribute("error", "Email already registered!");
                req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
                return;
            }

            // Insert
            String insertQuery = "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(insertQuery);

            stmt.setString(1, name);
            stmt.setString(2, email);
            String hashedPassword =
                    ValidationUtil.hashPassword(password);

            stmt.setString(3, hashedPassword);
            stmt.setString(4, role);

            stmt.executeUpdate();

            res.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage()); // show real error
            req.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(req, res);
        }
    }
}