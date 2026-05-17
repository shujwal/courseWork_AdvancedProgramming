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
            <h2 class="page-title">My Donations</h2>
            <p>Only donations you created are shown here. You can edit any donation you own.</p>
        </div>
        <a class="button" href="<%= contextPath %>/pages/add-donation.jsp">Add Donation</a>
    </div>

    <div class="table-wrapper">
        <table class="table-list">
            <tr>
                <th>ID</th>
                <th>Food</th>
                <th>Qty</th>
                <th>Location</th>
                <th>Status</th>
                <th>Volunteer</th>
                <th>Action</th>
            </tr>
            <% if (list.isEmpty()) { %>
            <tr>
                <td colspan="7" style="text-align:center; padding: 1rem;">No donations found.</td>
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
                <td><%= d.getVolunteerId() > 0 ? d.getVolunteerId() : "None" %></td>
                <td>
                    <a href="<%= contextPath %>/donations?action=edit&id=<%= d.getId() %>">Edit</a>
                </td>
            </tr>
            <%   }
            } %>
        </table>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>
