package com.advancedprogramming.foodsharehub.user.controller;

import com.advancedprogramming.foodsharehub.donation.model.Donation;
import com.advancedprogramming.foodsharehub.donation.model.dao.DonationDao;
import com.advancedprogramming.foodsharehub.user.model.User;
import com.advancedprogramming.foodsharehub.user.model.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDao userDao = new UserDao();
        DonationDao donationDao = new DonationDao();

        List<User> users = userDao.getAllUsers();
        List<Donation> donations = donationDao.getAllDonations();

        int totalUsers = users.size();
        int donorCount = 0;
        int volunteerCount = 0;
        int adminCount = 0;
        for (User user : users) {
            if ("donor".equals(user.getRole())) {
                donorCount++;
            } else if ("volunteer".equals(user.getRole())) {
                volunteerCount++;
            } else if ("admin".equals(user.getRole())) {
                adminCount++;
            }
        }

        int totalDonations = donations.size();
        int availableDonations = 0;
        int assignedDonations = 0;
        int completedDonations = 0;
        int pendingDonations = 0;
        for (Donation donation : donations) {
            String status = donation.getStatus();
            if (status == null || status.isEmpty() || "Pending".equalsIgnoreCase(status)) {
                pendingDonations++;
            } else if ("Available".equalsIgnoreCase(status)) {
                availableDonations++;
            } else if ("Assigned".equalsIgnoreCase(status)) {
                assignedDonations++;
            } else if ("Completed".equalsIgnoreCase(status)) {
                completedDonations++;
            } else {
                pendingDonations++;
            }
        }

        req.setAttribute("users", users);
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("donorCount", donorCount);
        req.setAttribute("volunteerCount", volunteerCount);
        req.setAttribute("adminCount", adminCount);
        req.setAttribute("totalDonations", totalDonations);
        req.setAttribute("availableDonations", availableDonations);
        req.setAttribute("assignedDonations", assignedDonations);
        req.setAttribute("completedDonations", completedDonations);
        req.setAttribute("pendingDonations", pendingDonations);

        req.getRequestDispatcher("pages/admin-dashboard.jsp").forward(req, resp);
    }
}