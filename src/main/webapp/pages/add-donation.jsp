<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%@ page import="com.advancedprogramming.foodsharehub.donation.model.Donation" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    if (!"donor".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/donations");
        return;
    }
    Donation donation = (Donation) request.getAttribute("donation");
    boolean editMode = donation != null;
    String title = editMode ? "Edit Donation" : "Add Donation";
    String buttonText = editMode ? "Save Changes" : "Add Donation";
%>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <h2 class="page-title"><%= title %></h2>
    <p>Tell us what you would like to donate and where it can be picked up.</p>

    <% String error = (String) request.getAttribute("error"); if (error != null) { %>
        <div class="alert"><%= error %></div>
    <% } %>
    <form action="<%= contextPath %>/donations" method="post" class="form-grid">
        <% if (editMode) { %>
            <input type="hidden" name="id" value="<%= donation.getId() %>">
        <% } %>
        <label class="label" for="foodName">Food Name</label>
        <input class="input-field" type="text" id="foodName" name="foodName" value="<%= editMode ? donation.getFoodName() : "" %>" required>

        <label class="label" for="quantity">Quantity</label>
        <input class="input-field" type="number" id="quantity" name="quantity" value="<%= editMode ? donation.getQuantity() : "" %>" required>

        <label class="label" for="expiryDate">Expiry Date</label>
        <input class="input-field" type="date" id="expiryDate" name="expiryDate" value="<%= editMode ? donation.getExpiryDate() : "" %>" required>

        <label class="label" for="location">Location</label>
        <input class="input-field" type="text" id="location" name="location" required>

        <button class="primary-button" type="submit"><%= buttonText %></button>
    </form>
</section>
<%@ include file="../includes/footer.jsp" %>
