package com.advancedprogramming.foodsharehub.user.controller;
import com.advancedprogramming.foodsharehub.user.model.User;
import com.advancedprogramming.foodsharehub.user.model.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("pages/login.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            UserDao dao = new UserDao();
            User user = dao.login(email, password);

            if (user == null) {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("pages/login.jsp").forward(req, resp);
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                String role = user.getRole();

                if (role.equals("admin")) {
                    resp.sendRedirect("admin-dashboard");
                } else if (role.equals("volunteer")) {
                    resp.sendRedirect("volunteer-dashboard");
                } else {
                    resp.sendRedirect("dashboard");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Login failed: " + e.getMessage());
            req.getRequestDispatcher("pages/login.jsp").forward(req, resp);
        }
    }
}
//Login page