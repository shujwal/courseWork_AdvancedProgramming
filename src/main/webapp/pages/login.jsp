<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="auth-card">
    <h2 class="page-title">Login</h2>
    <p>Access your FoodShare Hub account to manage donations and assignments.</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert"><%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/login" method="post" class="form-grid">
        <label class="label" for="email">Email</label>
        <input class="input-field" type="email" id="email" name="email" required>

        <label class="label" for="password">Password</label>
        <input class="input-field" type="password" id="password" name="password" required>

        <button class="primary-button" type="submit">Login</button>
    </form>
</section>
<%@ include file="../includes/footer.jsp" %>
