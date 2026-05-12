package com.scentia.controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.scentia.model.User;

import com.scentia.config.DBConfig;

/**
 * Servlet implementation class AdminUserServlet
 */
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
	        throws ServletException, IOException {

	    System.out.println("AdminUserServlet called");

	    String keyword = req.getParameter("q");
	    if (keyword != null) {
	        keyword = keyword.trim();
	    }

	    List<User> users = new ArrayList<>();

	    try (Connection conn = DBConfig.getConnection()) {

	        String sql;

	        boolean hasSearch = keyword != null && !keyword.isEmpty();

	        if (hasSearch) {
	            sql = "SELECT user_id, name, email, role FROM users " +
	                  "WHERE LOWER(name) LIKE ? OR LOWER(email) LIKE ?";
	        } else {
	            sql = "SELECT user_id, name, email, role FROM users";
	        }

	        PreparedStatement ps = conn.prepareStatement(sql);

	        if (hasSearch) {
	            String searchPattern = "%" + keyword.toLowerCase() + "%";
	            ps.setString(1, searchPattern);
	            ps.setString(2, searchPattern);
	        }

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            User u = new User();
	            u.setId(rs.getInt("user_id"));
	            u.setName(rs.getString("name"));
	            u.setEmail(rs.getString("email"));
	            u.setRole(rs.getString("role"));
	            users.add(u);
	        }

	        req.setAttribute("users", users);
	        req.setAttribute("searchKey", keyword); // optional but useful

	        req.getRequestDispatcher("/WEB-INF/pages/adminUsers.jsp")
	           .forward(req, res);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}