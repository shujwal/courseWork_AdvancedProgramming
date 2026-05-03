package com.advancedprogramming.foodsharehub.donation.controller;

import com.advancedprogramming.foodsharehub.donation.model.Donation;
import com.advancedprogramming.foodsharehub.donation.model.dao.DonationDao;
import com.advancedprogramming.foodsharehub.user.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/donations")
public class DonationServlet extends HttpServlet {

    DonationDao dao = new DonationDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteDonation(id);
            response.sendRedirect("donations");
        } else if ("assign".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int volunteerId = Integer.parseInt(request.getParameter("volunteerId"));
            dao.updateStatus(id, "Assigned", volunteerId);
            response.sendRedirect("donations");
        } else {
            request.setAttribute("list", dao.getAllDonations());
            RequestDispatcher rd = request.getRequestDispatcher("pages/donation-list.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            response.sendRedirect("login");
            return;
        }

        Donation d = new Donation();
        d.setFoodName(request.getParameter("foodName"));
        d.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        d.setExpiryDate(request.getParameter("expiryDate"));
        d.setLocation(request.getParameter("location"));
        d.setDonorId(user.getId());

        dao.addDonation(d);
        response.sendRedirect("donations");
    }
}
