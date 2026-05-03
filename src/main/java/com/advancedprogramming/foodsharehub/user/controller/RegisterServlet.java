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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("pages/register.jsp").forward(req,resp);
    }

    protected void doPost(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {

        String name=req.getParameter("name");
        String email=req.getParameter("email");
        String pass=req.getParameter("password");
        String role=req.getParameter("role");

        User u=new User();
        u.setFullName(name);
        u.setEmail(email);
        u.setPassword(BCrypt.hashpw(pass,BCrypt.gensalt()));
        u.setRole(role);

        try {
            UserDao dao = new UserDao();
            if (dao.register(u)) {
                resp.sendRedirect("login");
            } else {
                req.setAttribute("error", "Email exists");
                req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
        }
    }
}



//@WebServlet("/register")
//public class RegisterServlet extends HttpServlet {
//
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
//    }
//
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        String name = req.getParameter("fullname");
//        String email = req.getParameter("email");
//        String password = req.getParameter("password");
//        String role = req.getParameter("role");
//
//        if(name.isEmpty() || email.isEmpty() || password.isEmpty()){
//            req.setAttribute("error", "All fields are required");
//            req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
//            return;
//        }
//
//        if(role == null || role.isEmpty()){
//            role = "donor";
//        }
//
//        User user = new User();
//        user.setFullName(name);
//        user.setEmail(email);
//        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
//        user.setRole(role);
//
//        try{
//            UserDao dao = new UserDao();
//            boolean status = dao.insertUser(user);
//
//            if(status){
//                resp.sendRedirect("login");
//            }else{
//                req.setAttribute("error", "Email already exists!");
//                req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
//            }
//        }catch(Exception e){
//            req.setAttribute("error", e.getMessage());
//            req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
//        }
//    }
//}