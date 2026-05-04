package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.scentia.config.DBConfig;
import com.scentia.model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = req.getParameter("action");
        

        try (Connection c = DBConfig.getConnection()) {

            // ADD ITEM
            if ("add".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));

                // check if already exists
                boolean found = false;

                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }

                if (!found) {

                    PreparedStatement ps = c.prepareStatement(
                        "SELECT * FROM perfumes WHERE id=?"
                    );
                    ps.setInt(1, id);

                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        CartItem item = new CartItem();

                        item.setId(id);
                        item.setName(rs.getString("name"));
                        item.setBrand(rs.getString("brand"));
                        item.setScore(rs.getInt("sustainability_score"));
                        item.setQuantity(1);

                       
                        item.setPrice(120.0);

                        cart.add(item);
                    }
                }
            }

            //  REMOVE ITEM
            if ("remove".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));

                cart.removeIf(item -> item.getId() == id);
            }
         // INCREASE QUANTITY
            if ("increase".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));

                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + 1);
                        break;
                    }
                }
            }

            //  DECREASE QUANTITY
            if ("decrease".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));

                Iterator<CartItem> iterator = cart.iterator();

                while (iterator.hasNext()) {
                    CartItem item = iterator.next();

                    if (item.getId() == id) {

                        if (item.getQuantity() > 1) {
                            item.setQuantity(item.getQuantity() - 1);
                        } else {
                            // remove if quantity becomes 0
                            iterator.remove();
                        }

                        break;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("cart", cart);

        req.getRequestDispatcher("WEB-INF/pages/cart.jsp")
           .forward(req, res);
    }
}