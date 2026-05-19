package com.advancedprogramming.foodsharehub.donation.controller;

import com.advancedprogramming.foodsharehub.assignment.model.dao.AssignmentDao;
import com.advancedprogramming.foodsharehub.donation.model.Donation;
import com.advancedprogramming.foodsharehub.donation.model.dao.DonationDao;
import com.advancedprogramming.foodsharehub.user.model.User;
import com.advancedprogramming.foodsharehub.user.model.dao.UserDao;
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
    AssignmentDao assignmentDao = new AssignmentDao();
    UserDao userDao = new UserDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if ("delete".equals(action)) {
            if (!"admin".equals(user.getRole())) {
                response.sendRedirect("donations");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteDonation(id);
            response.sendRedirect(request.getContextPath() + "/donations");
        } else if ("assign".equals(action)) {
            if (!"admin".equals(user.getRole())) {
                response.sendRedirect("donations");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            String volunteerName = request.getParameter("volunteerName");
            
            if (volunteerName == null || volunteerName.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/donations");
                return;
            }
            
            User volunteer = userDao.getVolunteerByName(volunteerName);
            if (volunteer == null) {
                response.sendRedirect(request.getContextPath() + "/donations");
                return;
            }
            
            assignmentDao.assignVolunteer(id, volunteer.getId());
            response.sendRedirect(request.getContextPath() + "/donations");
        } else if ("updateStatus".equals(action)) {
            if (!"volunteer".equals(user.getRole())) {
                response.sendRedirect("donations");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            Donation donation = dao.getDonationById(id);
            if (donation == null || donation.getVolunteerId() != user.getId()) {
                response.sendRedirect("donations");
                return;
            }
            assignmentDao.updateStatus(id, "completed");
            response.sendRedirect(request.getContextPath() + "/donations");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Donation donation = dao.getDonationById(id);
            if (donation == null || !"donor".equals(user.getRole()) || donation.getDonorId() != user.getId()) {
                response.sendRedirect("donations");
                return;
            }
            request.setAttribute("donation", donation);
            request.setAttribute("editMode", true);
            request.getRequestDispatcher("pages/add-donation.jsp").forward(request, response);
        } else {
            if ("admin".equals(user.getRole())) {
                request.setAttribute("list", dao.getAllDonations());
                request.getRequestDispatcher("pages/admin-donation-list.jsp").forward(request, response);
            } else if ("volunteer".equals(user.getRole())) {
                request.setAttribute("list", dao.getDonationsByVolunteer(user.getId()));
                request.getRequestDispatcher("pages/volunteer-donation-list.jsp").forward(request, response);
            } else {
                request.setAttribute("list", dao.getDonationsByDonor(user.getId()));
                request.getRequestDispatcher("pages/donor-donation-list.jsp").forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            response.sendRedirect("login");
            return;
        }
        // Prevent volunteers from adding donations
        if ("volunteer".equals(user.getRole())) {
            response.sendRedirect("donations");
            return;
        }

        Donation d = new Donation();
        d.setFoodName(request.getParameter("foodName"));
        try {
            d.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Quantity must be a number.");
            request.getRequestDispatcher("pages/add-donation.jsp").forward(request, response);
            return;
        }
        d.setExpiryDate(request.getParameter("expiryDate"));
        d.setLocation(request.getParameter("location"));
        d.setDonorId(user.getId());

        String donationId = request.getParameter("id");
        try {
            if (donationId != null && !donationId.isEmpty()) {
                int id = Integer.parseInt(donationId);
                Donation existing = dao.getDonationById(id);
                if (existing == null || existing.getDonorId() != user.getId()) {
                    response.sendRedirect("donations");
                    return;
                }
                d.setId(id);
                dao.updateDonation(d);
            } else {
                dao.addDonation(d);
            }
            response.sendRedirect(request.getContextPath() + "/donations");
        } catch (Exception e) {
            request.setAttribute("error", "Unable to save donation: " + e.getMessage());
            request.setAttribute("donation", d);
            request.setAttribute("editMode", donationId != null && !donationId.isEmpty());
            request.getRequestDispatcher("pages/add-donation.jsp").forward(request, response);
        }
    }
}
