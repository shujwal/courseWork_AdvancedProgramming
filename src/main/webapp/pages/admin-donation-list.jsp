<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.advancedprogramming.foodsharehub.donation.model.Donation" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.dao.UserDao" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Donation> list = (List<Donation>) request.getAttribute("list");
    if (list == null) {
        list = new java.util.ArrayList<>();
    }
    UserDao userDao = new UserDao();
    List<User> volunteers = userDao.getAllVolunteers();
%>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <div class="action-grid" style="align-items:center; grid-template-columns: 1fr auto;">
        <div>
            <h2 class="page-title">All Donations</h2>
            <p>All donations are visible here. Assign volunteers to donations and manage records.</p>
        </div>
    </div>

    <div class="table-wrapper">
        <table class="table-list">
            <tr>
                <th>ID</th>
                <th>Food</th>
                <th>Qty</th>
                <th>Location</th>
                <th>Status</th>
                <th>Donor ID</th>
                <th>Volunteer</th>
                <th>Actions</th>
            </tr>
            <% if (list.isEmpty()) { %>
            <tr>
                <td colspan="8" style="text-align:center; padding: 1rem;">No donations found.</td>
            </tr>
            <% } else {
                for (Donation d : list) {
            %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getFoodName() %></td>
                <td><%= d.getQuantity() %></td>
                <td><%= d.getLocation() %></td>
                <td><%= d.getStatus() != null ? d.getStatus() : "Pending" %></td>
                <td><%= d.getDonorId() %></td>
                <td><%= d.getVolunteerId() > 0 ? d.getVolunteerId() : "None" %></td>
                <td>
                    <% if ("Available".equalsIgnoreCase(d.getStatus()) || d.getStatus() == null || d.getStatus().isEmpty()) { %>
                    <form action="<%= contextPath %>/donations" method="get" style="display:inline-flex; gap:8px; align-items:center;">
                        <input type="hidden" name="action" value="assign">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <select name="volunteerName" style="width:140px; padding:0.5rem; border:1px solid #ccc; border-radius:6px;" required>
                            <option value="">-- Select Volunteer --</option>
                            <% for (User vol : volunteers) { %>
                            <option value="<%= vol.getFullName() %>"><%= vol.getFullName() %></option>
                            <% } %>
                        </select>
                        <button class="button" type="submit" style="padding:0.4rem 0.8rem; font-size:0.9rem;">Assign</button>
                    </form>
                    <% } %>
                    <a href="<%= contextPath %>/donations?action=delete&id=<%= d.getId() %>">Delete</a>
                </td>
            </tr>
            <%   }
            } %>
        </table>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>
