package com.scentia.controller;

import com.scentia.config.DBConfig;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Validation
        if (email == null || password == null ||
            email.isEmpty() || password.isEmpty()) {

            req.setAttribute("error", "All fields are required!");
            req.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                String name = rs.getString("name");
                String role = rs.getString("role");

                
                HttpSession session = req.getSession();
                session.setAttribute("userName", name);
                session.setAttribute("role", role);

                
                if ("admin".equals(role)) {
                    res.sendRedirect("admin");   // admin dashboard
                } else {
                    res.sendRedirect("home");    // user dashboard
                }

            } else {
                req.setAttribute("error", "Invalid email or password!");
                req.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Something went wrong!");
            req.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(req, res);
        }
    }
}