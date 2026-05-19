package com.advancedprogramming.foodsharehub.user.controller;


import com.advancedprogramming.foodsharehub.user.model.User;
import com.advancedprogramming.foodsharehub.user.model.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet({"/register", "/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    private static final String REGISTER_VIEW = "/pages/register.jsp";

    protected void doGet(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher(REGISTER_VIEW).forward(req,resp);
    }

    protected void doPost(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {

        String name = trimToEmpty(req.getParameter("name"));
        String email = trimToEmpty(req.getParameter("email"));
        String pass = trimToEmpty(req.getParameter("password"));
        String accountType = trimToEmpty(req.getParameter("accountType")).toLowerCase();
        if (accountType.isEmpty()) {
            accountType = trimToEmpty(req.getParameter("role")).toLowerCase();
        }

        if (name.isEmpty() || email.isEmpty() || pass.isEmpty() || accountType.isEmpty()) {
            req.setAttribute("error", "Please fill in all required fields.");
            req.getRequestDispatcher(REGISTER_VIEW).forward(req, resp);
            return;
        }

        if (!"donor".equals(accountType) && !"volunteer".equals(accountType)) {
            req.setAttribute("error", "Please select a valid account type.");
            req.getRequestDispatcher(REGISTER_VIEW).forward(req, resp);
            return;
        }

        User u=new User();
        u.setFullName(name);
        u.setEmail(email);
        u.setPassword(BCrypt.hashpw(pass,BCrypt.gensalt()));
        u.setRole(accountType);

        try {
            UserDao dao = new UserDao();
            boolean status = dao.register(u);

            if(status){
                resp.sendRedirect("login");
            } else {
                req.setAttribute("error", "An account with this email already exists.");
                req.getRequestDispatcher(REGISTER_VIEW).forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher(REGISTER_VIEW).forward(req, resp);
        }
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }
}
