<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="auth-card">
    <h2 class="page-title">Register</h2>
    <p>Create a donor or volunteer account to start sharing food with your community.</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert"><%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/register" method="post" class="form-grid">
        <label class="label" for="name">Name</label>
        <input class="input-field" type="text" id="name" name="name" required>

        <label class="label" for="email">Email</label>
        <input class="input-field" type="email" id="email" name="email" required>

        <label class="label" for="password">Password</label>
        <input class="input-field" type="password" id="password" name="password" required>

        <label class="label" for="role">Account type</label>
        <select class="select-field" id="role" name="role">
            <option value="donor">Donor</option>
            <option value="volunteer">Volunteer</option>
        </select>

        <button class="primary-button" type="submit">Register</button>
    </form>
</section>
<%@ include file="../includes/footer.jsp" %>
