package com.scentia.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import com.scentia.model.CartItem;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // Show checkout page
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("cart") == null) {
            res.sendRedirect("cart");
            return;
        }

        req.getRequestDispatcher("WEB-INF/pages/Checkout.jsp")
           .forward(req, res);
    }

    // Handle form submit
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");

        // simple validation
        if (name == null || name.isEmpty() ||
            address == null || address.isEmpty() ||
            phone == null || phone.isEmpty()) {

            req.setAttribute("error", "All fields are required");
            req.getRequestDispatcher("WEB-INF/pages/Checkout.jsp")
               .forward(req, res);
            return;
        }

        HttpSession session = req.getSession();

        // clear cart after order
        session.removeAttribute("cart");

        // send success page
        req.setAttribute("name", name);
        req.getRequestDispatcher("WEB-INF/pages/Success.jsp")
           .forward(req, res);
    }
}