<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.advancedprogramming.foodsharehub.donation.model.Donation" %>
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
%>
<%@ include file="../includes/header.jsp" %>

<section class="content-card">
    <div class="action-grid" style="align-items:center; grid-template-columns: 1fr auto;">
        <div>
            <h2 class="page-title">My Assigned Donations</h2>
            <p>Donations assigned to you by admin are ready for pickup.</p>
        </div>
    </div>

    <% if (list.isEmpty()) { %>
    <div style="text-align:center; padding: 2rem; color: #666;">
        <p>No donations assigned to you yet. Check back soon!</p>
    </div>
    <% } else { %>
    <div class="table-wrapper">
        <table class="table-list">
            <tr>
                <th>ID</th>
                <th>Food Item</th>
                <th>Quantity</th>
                <th>Expiry Date</th>
                <th>Location</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <% for (Donation d : list) { %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getFoodName() %></td>
                <td><%= d.getQuantity() %></td>
                <td><%= d.getExpiryDate() %></td>
                <td><%= d.getLocation() %></td>
                <td>
                    <% if ("completed".equalsIgnoreCase(d.getStatus())) { %>
                    <span style="background-color: #d4edda; color: #155724; padding: 4px 8px; border-radius: 4px; font-weight: bold;">Completed</span>
                    <% } else { %>
                    <span style="background-color: #fff3cd; color: #856404; padding: 4px 8px; border-radius: 4px; font-weight: bold;">Pending</span>
                    <% } %>
                </td>
                <td>
                    <% if (!"completed".equalsIgnoreCase(d.getStatus())) { %>
                    <a href="<%= contextPath %>/donations?action=updateStatus&id=<%= d.getId() %>" class="button" onclick="return confirm('Mark this task as completed?');">Mark Completed</a>
                    <% } else { %>
                    <span style="color: green; font-weight: bold;">✓ Done</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } %>
</section>

<%@ include file="../includes/footer.jsp" %>

