<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page import="com.pro.pro.user.model.User" %>
<%@ page import="java.util.*, com.pro.pro.donation.model.Donation" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <div class="action-grid" style="align-items:center; grid-template-columns: 1fr auto;">
        <div>
            <h2 class="page-title">Donations</h2>
            <p>Browse current donation records and take action based on your role.</p>
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
                <th>Action</th>
            </tr>
            <%
                List<Donation> list = (List<Donation>) request.getAttribute("list");
                for (Donation d : list) {
            %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getFoodName() %></td>
                <td><%= d.getQuantity() %></td>
                <td><%= d.getLocation() %></td>
                <td><%= d.getStatus() %></td>
                <td>
                    <% if ("admin".equals(user.getRole())) { %>
                        <a href="<%= contextPath %>/donations?action=delete&id=<%= d.getId() %>">Delete</a>
                    <% } else if ("volunteer".equals(user.getRole()) && "Available".equals(d.getStatus())) { %>
                        <a href="<%= contextPath %>/donations?action=assign&id=<%= d.getId() %>&volunteerId=<%= user.getId() %>">Assign</a>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>
